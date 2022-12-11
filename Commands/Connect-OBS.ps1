function Connect-OBS
{
    <#
    .SYNOPSIS
        Connects to Open Broadcast Studio
    .DESCRIPTION
        Connects to the obs-websocket.

        This must occur at least once to use obs-powershell.
    .EXAMPLE
        Connect-OBS
    .LINK
        Disconnect-OBS
    #>
    param(
    # A credential describing the connection.
    # The username should be the IPAddress, and the password should be the obs-websocket password.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [Management.Automation.PSCredential]
    $Credential,

    # The websocket password.
    # You can see the websocket password in Tools -> obs-websocket settings -> show connect info
    [Parameter(ValueFromPipelineByPropertyName)]
    [securestring]
    $WebSocketPassword,

    # The websocket URL.  If not provided, this will default to loopback on port 4455.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateScript({
        if ($_.Scheme -ne 'ws') {
            throw "Not a websocket uri"
        }
        return $true
    })]
    [uri]
    $WebSocketUri = "ws://$([ipaddress]::Loopback):4455"
    )

    begin {
        $obsWatcherJobDefinition = {
            param([Management.Automation.PSCredential]$Credential)

            function OBSIdentify {
                $secret = "$obsPwd$($messageData.d.authentication.salt)"
                $enc = [Security.Cryptography.SHA256Managed]::new()
                $secretSalted64 = [Convert]::ToBase64String(
                    $enc.ComputeHash([Text.Encoding]::ascii.GetBytes($secret)
                ))

                $saltedSecretAndChallenge = "$secretSalted64$(
                    $messageData.d.authentication.challenge
                )"

                $enc = [Security.Cryptography.SHA256Managed]::new()
                $challenge64 = [Convert]::ToBase64String(
                    $enc.ComputeHash([Text.Encoding]::ascii.GetBytes(
                        $saltedSecretAndChallenge
                    ))
                )                

                $identifyMessage = [Ordered]@{
                    op = 1
                    d = [Ordered]@{ 
                        rpcVersion = 1
                        authentication = $challenge64                        
                    }
                }
                $PayloadJson = $identifyMessage | ConvertTo-Json -Compress
                $SendSegment  = [ArraySegment[Byte]]::new([Text.Encoding]::UTF8.GetBytes($PayloadJson))
                $null = $Websocket.SendAsync($SendSegment,'Text', $true, [Threading.CancellationToken]::new($false))
            }

            $webSocketUri = $Credential.UserName
            $WebSocketPassword = $Credential.GetNetworkCredential().Password
            $Websocket   = [Net.WebSockets.ClientWebSocket]::new() # [Net.WebSockets.ClientWebSocket]::new()
                        $waitFor = [Timespan]'00:00:05'
            $ConnectTask = $Websocket.ConnectAsync($webSocketUri, [Threading.CancellationToken]::new($false))
            $null = $ConnectTask.ConfigureAwait($false)
    
    
            $obsPwd = $WebSocketPassword
            $WaitInterval = [Timespan]::FromMilliseconds(7)
    
            $BufferSize = 16kb
    
            $maxWaitTime = [DateTime]::Now + $WaitFor
            while (!$ConnectTask.IsCompleted -and [DateTime]::Now -lt $maxWaitTime) {

            }
    
            $Websocket
   
    try {
     
        while ($true) {
            # Create a buffer for the response
            $buffer = [byte[]]::new($BufferSize)
            $receiveSegment = [ArraySegment[byte]]::new($buffer)
            if (!($Websocket.State -eq 'Open')) {
                throw 'Websocket is not open anymore. {0}' -f $Websocket.State
            }
            # Receive the next response from the WebSocket,
            $receiveTask = $Websocket.ReceiveAsync($receiveSegment, [Threading.CancellationToken]::new($false))
            # then wait for it to complete.
            while (-not $receiveTask.IsCompleted) { Start-Sleep -Milliseconds $WaitInterval.TotalMilliseconds }
            # "Receiving $($receiveTask.Result.Count)" | Out-Host
            $msg    = # Get the response and trim with extreme prejudice.
                [Text.Encoding]::UTF8.GetString($buffer, 0, $receiveTask.Result.Count).Trim() -replace '\s+$'
            
            if ($msg) {
                $messageData = ConvertFrom-Json $msg
                $MessageData.pstypenames.insert(0,'OBS.WebSocket.Message')                
                $newEventSplat = @{}
                
                if ($messageData.op -eq 0 -and $messageData.d.authentication) {
                    . OBSIdentify
                }
                                
                $newEventSplat.SourceIdentifier = 'OBS.WebSocket.Message'
                $newEventSplat.MessageData = $MessageData
    
                New-Event @newEventSplat
                
                if ($messageData.op -eq 5) {
                    $newEventSplat = @{}
                    $newEventSplat.SourceIdentifier = "OBS.Event.$($messageData.d.eventType)"
                    if ($messageData.d.eventData) {
                        $newEventSplat.MessageData = [PSObject]::new($messageData.d.eventData)
                        $newEventSplat.MessageData.pstypenames.insert(0,"OBS.$($MessageData.d.eventType).response")
                        $newEventSplat.MessageData.pstypenames.insert(0,"$($newEventSplat.SourceIdentifier)")
                    }
                    New-Event @newEventSplat
                }
                
                # A message with the opcode of 7 is an event response.
                if ($messageData.op -eq 7) {                    
                    $newEventSplat = @{}
                    # For event responses, we want to send another event using the requestID.
                    $newEventSplat.SourceIdentifier = $MessageData.d.requestId
                    # If there was response data
                    if ($messageData.d.responseData) {
                        # create a new object with that data
                        $newEventSplat.MessageData = [PSObject]::new($MessageData.d.responseData)
                        # and decorate it's return
                        $newEventSplat.MessageData.pstypenames.insert(0,"OBS.$($MessageData.d.requestType).response")
                        $newEventSplat.MessageData.pstypenames.insert(0,"$($newEventSplat.SourceIdentifier)")
                    }
                    # Otherwise, if the request failed
                    elseif ($messageData.d.requestStatus.result -eq $false)
                    {
                        # Our message will be an error record.
                        $newEventSplat.MessageData = 
                            [Management.Automation.ErrorRecord]::new(
                                # using the comment as the error message
                                [Exception]::new($MessageData.d.requestStatus.comment),
                                $messageData.d.requestId, 'NotSpecified', $messageData
                            )
                                                    
                        $newEventSplat.MessageData.pstypenames.insert(0,"OBS.$($MessageData.d.requestType).error")
                        $newEventSplat.MessageData.pstypenames.insert(0,"$($newEventSplat.SourceIdentifier).error")
                    }
                    New-Event @newEventSplat
                }
                
            }
    
            $buffer.Clear()
            
        }
    
    } catch {
        Write-Error -Exception $_.Exception -Message "StreamDeck Exception: $($_ | Out-String)" -ErrorId "WebSocket.State.$($Websocket.State)"
    }
        }
        

        if (-not $script:ObsConnections) {
            $script:ObsConnections = [Ordered]@{}
        }
    }

    process {
        if (-not $Credential) {
            if ($WebSocketPassword) {
                $Credential = [Management.Automation.PSCredential]::new($WebSocketUri, $WebSocketPassword)
            }
        }

        if (-not $Credential) {
            Write-Error "Must provide -Credential or -WebSocketPassword"
            return
        }

        $connectionExists = $script:ObsConnections[$Credential.UserName]
        if ($connectionExists -and 
            $connectionExists.State -eq 'Running' -and
            $connectionExists.WebSocket.State -eq 'Open'        
        ) {
            $connectionExists
            Write-Verbose "Already connected"
            return
        }

        $obsWatcher      =
            Start-ThreadJob -ScriptBlock $obsWatcherJobDefinition -Name "OBS.Connection.$($Credential.UserName)" -ArgumentList $Credential
        
        $whenOutputAddedHandler =
            Register-ObjectEvent -InputObject $obsWatcher.Output -EventName DataAdded -Action {
            
                $dataAdded = $sender[$event.SourceArgs[1].Index]
                if ($dataAdded -is [Management.Automation.PSEventArgs]) {
                    $newEventSplat = [Ordered]@{
                        SourceIdentifier = $dataAdded.SourceIdentifier
                    }
                    $newEventSplat.Sender = $eventSubscriber
                    if ($dataAdded.MessageData) {
                        $newEventSplat.MessageData = $dataAdded.MessageData
                    }
                    if ($dataAdded.SourceEventArgs) {
                        $newEventSplat.EventArguments = $dataAdded.SourceEventArgs
                    }
                    $messageData = $dataAdded.MessageData
                    New-Event @newEventSplat
                }
                elseif ($dataAdded -is [Net.WebSockets.ClientWebSocket]) {
                    $eventSubscriber | Add-Member NoteProperty WebSocket $dataAdded -Force -PassThru
                }
                else {

                }
            }

        $whenOutputAddedHandler | Add-Member NoteProperty Watcher $obsWatcher -Force

        $whenOutputAdded = @(
            foreach ($subscriber in Get-EventSubscriber) {
                if ($subscriber.Action -eq $whenOutputAddedHandler) {
                    $subscriber;break
                }
            }
        )

        $obsWatcher | Add-Member NoteProperty WhenOutputAddedHandler $whenOutputAddedHandler -Force
        $obsWatcher | Add-Member NoteProperty WhenOutputAdded $whenOutputAdded -Force
        $obsWatcher | Add-Member NoteProperty StartTime ([datetime]::Now) -Force
        $obsWatcher | Add-Member ScriptProperty WebSocket {
            $this.WhenOutputAdded.WebSocket
        } -Force

        $obsWatcher.pstypenames.insert(0, 'OBS.Connection')
        $script:ObsConnections[$Credential.UserName] = $obsWatcher
        $obsWatcher
    }
}
