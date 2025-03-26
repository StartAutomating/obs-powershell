function Watch-OBS
{
    <#
    .SYNOPSIS
        Watches OBS
    .DESCRIPTION
        Watches the OBS websocket for events.
    .EXAMPLE    
        Watch-OBS -WebSocketToken 12345  # Obviously, replace this with your password.
    .EXAMPLE
        Watch-OBS    # If you turn off authentication on OBS
    .LINK
        Connect-OBS
    .LINK
        Receive-OBS
    #>
    param(
    # The OBS websocket URL.  If not provided, this will default to loopback on port 4455.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('WebSocketURL')]
    [uri]    
    $WebSocketURI = "ws://$([ipaddress]::Loopback):4455",

    # A randomly generated password used to connect to OBS.
    # You can see the websocket password in Tools -> obs-websocket settings -> show connect info
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('WebSocketPassword')]
    [string]
    $WebSocketToken,

    # The size of the buffer to use when receiving messages from the websocket.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateRange(1,1mb)]
    [int]
    $BufferSize = 64kb
    )

    begin {
        $obsWatcherJobDefinition = '' + {
            param(            
            [Collections.IDictionary]$Variable
            )

            foreach ($keyValue in $Variable.GetEnumerator()) {
                $ExecutionContext.SessionState.PSVariable.Set($keyValue.Name, $keyValue.Value)
            }
        }.ToString() + 
"
function Receive-OBS {
$($ExecutionContext.SessionState.InvokeCommand.GetCommand('Receive-OBS', 'Function').Definition)
}

function Send-OBS {
$($ExecutionContext.SessionState.InvokeCommand.GetCommand('Send-OBS', 'Function').Definition)
}
" + {
            $Websocket   = [Net.WebSockets.ClientWebSocket]::new() # [Net.WebSockets.ClientWebSocket]::new()
                        $waitFor = [Timespan]'00:00:05'
            $ConnectTask = $Websocket.ConnectAsync($webSocketUri, [Threading.CancellationToken]::new($false))
            $null = $ConnectTask.ConfigureAwait($false)
    
    
            $obsPwd = $WebSocketToken
            $WaitInterval = [Timespan]::FromMilliseconds(7)
    
            $BufferSize = 64kb
    
            $maxWaitTime = [DateTime]::Now + $WaitFor
            while (!$ConnectTask.IsCompleted -and [DateTime]::Now -lt $maxWaitTime) {

            }

            if (-not $script:ObsConnections) {
                $script:ObsConnections = @{}
            }
            $script:ObsConnections[$webSocketUri] = $Websocket
            $Variable['WebSocket'] = $Websocket
    
            [PSCustomObject][Ordered]@{
                PSTypename = 'obs.websocket'
                Uri = $webSocketUri
                WebSocket = $Websocket
            }
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
                $messageData = try { ConvertFrom-Json $msg -ErrorAction Ignore} catch { $_ }
                $received = if ($messageData -isnot [Management.Automation.ErrorRecord]) {
                    $messageData | Receive-OBS -WebSocketToken $WebSocketToken -WebSocketUri $webSocketUri -SendEvent 
                } else {
                    $messageData
                }
                if ($MainRunspace) {
                    foreach ($receivedItem in $received) {
                        if ($receivedItem -is [Management.Automation.PSEvent]) {
                            $MainRunspace.Events.GenerateEvent($receivedItem.SourceIdentifier, $receivedItem.Sender, $receivedItem.SourceArgs, $receivedItem.MessageData)
                        } else {
                            $MainRunspace.Events.GenerateEvent('obs://', $Websocket, $received, $null)
                        }
                    }                    
                }
                $received                
            }
    
            $buffer.Clear()
            
        }
    
    } catch {
        Write-Error -Exception $_.Exception -Message "Exception: $($_ | Out-String)" -ErrorId "WebSocket.State.$($Websocket.State)"
    }
        }

        $obsWatcherJobDefinition = [scriptblock]::Create($obsWatcherJobDefinition)
        
        if (-not $script:ObsConnections) {
            $script:ObsConnections = [Ordered]@{}
        }

        $obsProcess = Get-Process obs* | 
            Where-Object Name -In 'obs', 'obs64', 'obs32'

        if (-not $obsProcess) {
            Write-Warning "OBS is not running"
        }
    }

    process {
        
        $MainRunspace = [Runspace]::DefaultRunspace
        $obsWatcher      =
            Start-ThreadJob -ScriptBlock $obsWatcherJobDefinition -Name "OBS.Connection.$($Credential.UserName)" -ArgumentList ([Ordered]@{
                WebSocketURI = $WebSocketURI
                WebSocketToken = $WebSocketToken
                BufferSize = $BufferSize                
                MainRunspace = $MainRunspace
            })
        
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
                elseif ($dataAdded.pstypenames -contains 'obs.websocket') {
                    New-Event -SourceIdentifier obs.powershell.websocket -MessageData $dataAdded
                    $eventSubscriber | Add-Member NoteProperty WebSocket $dataAdded.WebSocket -Force -PassThru
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

        Start-Sleep -Milliseconds 1 # Do the smallest of sleeps, so that the thread job actually has a chance to start.

        $obsWatcher | Add-Member NoteProperty WhenOutputAddedHandler $whenOutputAddedHandler -Force
        $obsWatcher | Add-Member NoteProperty WhenOutputAdded $whenOutputAdded -Force
        $obsWatcher | Add-Member NoteProperty StartTime ([datetime]::Now) -Force
        $obsWatcher | Add-Member ScriptProperty WebSocket {
            $this.WhenOutputAdded.WebSocket
        } -Force

        $obsWatcher.pstypenames.insert(0, 'OBS.Connection')
        $script:ObsConnections[$WebSocketURI] = $obsWatcher
        $obsWatcher
    }
}
