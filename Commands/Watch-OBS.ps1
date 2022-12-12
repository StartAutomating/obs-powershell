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
    $WebSocketToken
    )

    begin {
        $obsWatcherJobDefinition = '' + {
            param(            
            [uri]$webSocketUri,
            
            [Alias('WebSocketPassword')]
            $WebSocketToken
            )
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
    
            $BufferSize = 16kb
    
            $maxWaitTime = [DateTime]::Now + $WaitFor
            while (!$ConnectTask.IsCompleted -and [DateTime]::Now -lt $maxWaitTime) {

            }

            if (-not $script:ObsConnections) {
                $script:ObsConnections = @{}
            }
            $script:ObsConnections[$webSocketUri] = $Websocket
    
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
                $messageData | Receive-OBS -WebSocketToken $WebSocketToken -WebSocketUri $webSocketUri -SendEvent
            }
    
            $buffer.Clear()
            
        }
    
    } catch {
        Write-Error -Exception $_.Exception -Message "StreamDeck Exception: $($_ | Out-String)" -ErrorId "WebSocket.State.$($Websocket.State)"
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
        
        
        $obsWatcher      =
            Start-ThreadJob -ScriptBlock $obsWatcherJobDefinition -Name "OBS.Connection.$($Credential.UserName)" -ArgumentList $WebSocketURI, $WebSocketToken
        
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
        $script:ObsConnections[$WebSocketURI] = $obsWatcher
        $obsWatcher
    }
}
