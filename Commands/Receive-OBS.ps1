function Receive-OBS
{ 
    <#
    .SYNOPSIS
        Receives data from OBS
    .DESCRIPTION
        Receives responses from the OBS WebSocket
    #>
    [CmdletBinding(DefaultParameterSetName='WaitForResponse')]
    param(
    # The message data that has been received
    [Parameter(ValueFromPipeline)]
    $MessageData,

    # If set will wait for a response from the message and expand the results.
    [Parameter(ParameterSetName='WaitForResponse')]
    [switch]
    $WaitForReponse,

    # If set, will responsd to known events, like 'hello', and resend other events as PowerShell events
    [Parameter(ParameterSetName='SendEvent')]
    [Alias('Resend')]
    [switch]
    $SendEvent,

    # The OBS websocket URL.  If not provided, this will default to loopback on port 4455.
    [Parameter(Mandatory,ParameterSetName='SendEvent')]
    [Alias('WebSocketURL')]
    [uri]    
    $WebSocketURI = "ws://$([ipaddress]::Loopback):4455",

    # A randomly generated password used to connect to OBS.
    # You can see the websocket password in Tools -> obs-websocket settings -> show connect info
    [Parameter(Mandatory,ParameterSetName='SendEvent')]
    [Alias('WebSocketPassword')]
    [string]
    $WebSocketToken
    )

    begin {
        function OBSIdentify {
            $secret = "$webSocketToken$($messageData.d.authentication.salt)"
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

        if ($home) {
            $obsPowerShellRoot = Join-Path $home '.obs-powershell'
        }
    }

    process {
        $payloadObject = $MessageData
        
        if ($PSCmdlet.ParameterSetName -eq 'WaitForResponse') {
            $myRequestId = $payloadObject.d.requestID
            $myRequestType = $payloadObject.d.requestType
            if (-not $myRequestId) {
                Write-Error "No .RequestID to wait for"
                return
            }
                                
            # Normally, we can just wait for the event
            $eventResponse = Wait-Event -SourceIdentifier $myRequestId -Timeout 1 |
                Select-Object -ExpandProperty MessageData
            
            # however, if we are in the event pump we need to look at the output of the connection.            
            if (-not $eventResponse -and 
                $obsConnection -is [Management.Automation.Job]) {                
                for ($outputIndex = $obsConnection.Output.Count - 1; $outputIndex -ge 0; $outputIndex--) {
                    $obsOutput = $obsConnection.Output[$outputIndex]
                    if ($obsOutput.SourceIdentifier -eq $myRequestId) {                        
                        $eventResponse = $obsOutput.MessageData
                        break
                    }
                }
            }        
            
            if ($eventResponse -is [Management.Automation.ErrorRecord]) {
                if ($eventResponse.Exception.Message) {
                    Write-Error -ErrorRecord $eventResponse
                }
                return
            }

            if ($null -eq $eventResponse) { return }
            # Collect all properties from the response
            $eventResponseProperties = @($eventResponse.psobject.properties)
            
            $expandedResponse =
                # If there was only one property
                if ($eventResponseProperties.Length -eq 1) {
                    $typeName = "$($eventResponseProperties.TypeNameOfValue)"
                    # and it was a string, array, or PSCustomObject
                    if ($typeName -eq 'System.String' -or $typeName -eq 'System.Object[]' -or $typeName -eq 'System.Management.Automation.PSCustomObject')  {
                        # expand it
                        $eventResponse.psobject.properties.value
                    } else {
                        # otherwise, return it as is.
                        $eventResponse
                    }
                } else {
                    $eventResponse
                }
    
            
            # Now walk thru each response and expand / decorate it
            foreach ($responseObject in $expandedResponse) {
                # If there was no response, move on.
                if ($null -eq $responseObject) {
                    continue
                }
                # If the response is a string and it's the same as the request type                        
                if ($responseObject -is [string] -and $responseObject -eq $myRequestType) {
                    continue # ignore it
                }
                # otherwise, if the response looks like a file
                elseif ($responseObject -is [string] -and 
                    $responseObject -match '^(?:\p{L}\:){0,1}[\\/]') {
                    $fileName = $responseObject -replace '[\\/]', ([io.path]::DirectorySeparatorChar)
                    if (Test-Path $fileName) {
                        $responseObject = Get-Item -LiteralPath $fileName
                    }
                }
    
                # Otherwise, create a new PSObject out of the response
                $responseObject = [PSObject]::new($responseObject)
                
                # If the response is not a string
                if ($responseObject -isnot [string]) {
                    # clear the typename.
                    $responseObject.pstypenames.clear()
                }

                if ($responseObject.inputKind) {
                    $responseObject.pstypenames.add("OBS.Input.$($responseObject.inputKind -replace '_', '.')")
                }
                # Decorate the response with the command name and OBS.requestype.response                
                $responseObject.pstypenames.add("$myCmd")
                $responseObject.pstypenames.add("OBS.$myRequestType.Response")
    
                # Now, walk thru all properties in our input payload
                foreach ($keyValue in $paramCopy.GetEnumerator()) {
                    # If they were not in our output
                    if (-not $responseObject.psobject.properties[$keyValue.Key]) {
                        # add them
                        $responseObject.psobject.properties.add(
                            [psnoteproperty]::new($keyValue.Key, $keyValue.Value)
                        )
                    }
    
                    # Doing this will make it easier to pipe one step to another
                    # and make results more useful.
                }
    
                # finally, emit our response object
                $responseObject
            }            
        }
        
        if ($PSCmdlet.ParameterSetName -eq 'SendEvent') {
            if (-not $script:ObsConnections[$webSocketUri]) {
                Write-Error "Not connected to '$webSocketUri'"
                return
            }

            $MessageData.pstypenames.insert(0,'OBS.WebSocket.Message')                
            $newEventSplat = @{}
            
            if ($messageData.op -eq 0 -and $messageData.d.authentication) {
                . OBSIdentify
            }
                            
            $newEventSplat.SourceIdentifier = 'OBS.WebSocket.Message'
            $newEventSplat.MessageData = $MessageData

            New-Event @newEventSplat

            if ($messageData.op -eq 2 -and 
                $obsPowerShellRoot) {
                $obsConnectedFileName = $webSocketUri.DnsSafeHost + '_' + $webSocketUri.Port
                if (-not (Test-Path $obsPowerShellRoot)) {
                    $null = New-Item -ItemType Directory -Path $obsPowerShellRoot
                }
                $obsConnectionFile =
                    Join-Path $obsPowerShellRoot "$obsConnectedFileName.obs-websocket.clixml"

                if (Test-Path $obsConnectionFile) {
                    $fileData = Import-Clixml $obsConnectionFile
                    $fileData.WebSocketToken = $WebSocketToken
                    $fileData.WebSocketUri = $webSocketUri
                    $fileData | Export-Clixml -Path $obsConnectionFile
                } else {
                    [PSCustomObject][Ordered]@{
                        PSTypeName = 'OBS.PowerShell.Connection.Info'
                        WebSocketToken = $WebSocketToken
                        WebSocketUri   = $webSocketUri
                    } | Export-Clixml -Path $obsConnectionFile
                }
                
                
            }
            
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
                            ($messageData.d.requestId -replace '\.[0-9a-f\-]+$') + ".$($MessageData.d.requestStatus.code)", 'NotSpecified', $messageData
                        )
                                                
                    $newEventSplat.MessageData.pstypenames.insert(0,"OBS.$($MessageData.d.requestType).error")
                    $newEventSplat.MessageData.pstypenames.insert(0,"$($newEventSplat.SourceIdentifier).error")
                }
                New-Event @newEventSplat
            }
        }


    }
}
