function Send-OBS
{
    <#
    .SYNOPSIS
        Sends messages to the OBS websocket.        
    .DESCRIPTION
        Sends one or more messages to the OBS websocket.
    .LINK
        Receive-OBS
    .LINK
        Watch-OBS
    #>
    param(
    # The data to send to the obs websocket.
    [Parameter(ValueFromPipeline,ValueFromPipelineByPropertyName)]    
    [Alias('Payload')]
    $MessageData,

    # If provided, will sleep after each step.
    # If -StepTime is less than 10000 ticks, it will be treated as frames per second.
    # If -SerialFrame was provied, -StepTime will be the number of frames to wait.
    [Parameter(ValueFromPipelineByPropertyName)]
    [timespan]
    $StepTime,

    # If set, will process a batch of requests in parallel.
    [switch]
    $Parallel,

    # If set, will process a batch of requests in parallel.
    [switch]
    $SerialFrame,

    # If set, will receive responses from batches of requests.
    [Alias('ReceiveBatches')]
    [switch]
    $ReceiveBatch,

    # If set, will never attempt to receive a response.
    [Alias('NoReceive','IgnoreResponse','IgnoreReceive','DoNotReceiveResponse')]
    [switch]
    $NoResponse
    )

    begin {
        $allMessages = [Collections.Queue]::new()

        # Keep track of how many requests we have done of a given type
        # (this makes creating RequestIDs easy)
        if (-not $script:ObsRequestsCounts) {
            $script:ObsRequestsCounts = @{}
        }

        if (-not $script:ObsWebSockets) {
            $script:ObsWebSockets = [Ordered]@{}        
        }

        function SendSingleMessageToOBS {
            param(
            [Parameter(ValueFromPipeline)]
            $payloadObject
            )

            process {
                if ($null -eq $payloadObject.op) {
                    if ($payloadObject.requestID) {
                        $payloadObject = [Ordered]@{
                            op = 6
                            d = $payloadObject
                        }
                    }
                    elseif ($payloadObject.authentication) {
                        $payloadObject = [Ordered]@{
                            op = 1
                            d = $payloadObject
                        }
                    }
                    else {
                        Write-Verbose "No payload provided, broadcasting event"
                        $myRequestType = 'BroadcastCustomEvent'                        
    
                        # If we don't have a request counter for this request type
                        if (-not $script:ObsRequestsCounts[$myRequestType]) {
                            # initialize it to zero.
                            $script:ObsRequestsCounts[$myRequestType] = 0
                        }
                        # Increment the counter for requests of this type
                        $script:ObsRequestsCounts[$myRequestType]++
    
                        # and make a request ID from that.
                        $myRequestId = "$myRequestType.$($script:ObsRequestsCounts[$myRequestType])"
    
                        $payloadObject = [Ordered]@{
                            op = 6                        
                            d = [Ordered]@{
                                requestId = $myRequestId
                                requestType = $myRequestType
                                eventData = $payloadObject
                            }
                        }
                    }
                }
                $PayloadJson = ConvertTo-Json -Depth 100 -InputObject $payloadObject
                    
            
                # And create a byte segment to send it off.
                $SendSegment  = [ArraySegment[Byte]]::new([Text.Encoding]::UTF8.GetBytes($PayloadJson))
    
                # If we have no OBS connections
                if (-not $script:ObsConnections.Values) {
                    # error out
                    Write-Error "Not connected to OBS.  Use Connect-OBS."
                    return
                }                
                # Otherwise, walk over each connection
                foreach ($obsConnectionInfo in @($script:ObsConnections.GetEnumerator())) {
                    $obsConnection   = $obsConnectionInfo.Value
                    $OBSWebSocketUri = $obsConnectionInfo.Key
                    $OBSWebSocket    = $obsConnection.Websocket
                    if ($VerbosePreference -notin 'silentlyContinue', 'ignore') {
                        Write-Verbose "Sending $payloadJSON"
                    }

                    # In event-driven contexts, the websocket attachment may not work due to the accessibility of ScriptMethods.
                    if ($OBSWebSocket -eq $null) {                        
                        # to work around this, we can find our websocket by looking at the event it generated on connection
                        if (-not $script:OBSWebSockets[$OBSWebSocketUri] -or $script:OBSWebSockets[$OBSWebSocketUri].State -ne 'Open') {
                            $webSocketEvents = @(Get-Event -SourceIdentifier obs.powershell.websocket)
                            [Array]::Reverse($webSocketEvents) 
                            foreach ($webSocketEvent in $webSocketEvents) {
                                if ($webSocketEvent.MessageData.Uri -eq $OBSWebSocketUri -and 
                                    $webSocketEvent.WebSocket.State -eq 'Open'
                                ) {
                                    # Once we find an open socket, cache it.
                                    $script:OBSWebSockets[$webSocketEvent.MessageData.Uri] = $webSocketEvent.MessageData.WebSocket
                                    break
                                }
                            }
                        }
                        # set the socket to what is in the cache.
                        $OBSWebSocket = $script:OBSWebSockets[$OBSWebSocketUri]

                        # If there was still no socket
                        if (-not $OBSWebSocket) {
                            # write an error 
                            Write-Error "No websocket for $obsWebSocketUri"
                            continue # and continue.
                        }
                    }
                    # Since we have a working websocket, send the payload to it.
                    $null = $OBSWebSocket.SendAsync($SendSegment,'Text', $true, [Threading.CancellationToken]::new($false))
                    # If a response was expected (and we did explicitly say to ignore responses)
                    if ($payloadObject.d.requestID -and 
                        (-not $NoResponse)
                    ) {
                        if ($payloadObject.op -ne 8 -or $ReceiveBatch) {
                            $payloadObject | . Receive-OBS
                        }
                    }
                }
            }
        }
    }

    process {
        foreach ($message in $MessageData) {
            if ($null -eq $message) { continue }
            $allMessages.Enqueue($Message)
            if ($StepTime.TotalMilliseconds -gt 0) {
                if ($SerialFrame) {
                    $allMessages.Enqueue([PSCustomObject][Ordered]@{                
                        requestType = 'Sleep'
                        requestData = @{
                            sleepFrames = [int]$StepTime.Ticks
                        }
                    })
                } else {
                    if ($StepTime.Ticks -lt 10000) {
                        $StepTime = [TimeSpan]::FromMilliseconds(1000 / $StepTime.Ticks)
                    }
                    $allMessages.Enqueue([PSCustomObject][Ordered]@{                
                        requestType = 'Sleep'
                        requestData = @{
                            sleepMillis = [int]$StepTime.TotalMilliseconds
                        }
                    })
                }
            }
        }
        
    }

    end {
        if ($allMessages.Count -eq 1) {
            $payloadObject = $allMessages[0]
            $payloadObject | SendSingleMessageToOBS
        }        
        elseif ($allMessages.Count -gt 0 -and $allMessages.ToArray().RequestType) {
            if (-not $script:ObsRequestsCounts["Batch"]) {
                $script:ObsRequestsCounts["Batch"] = 0
            }
            $script:ObsRequestsCounts["Batch"]++

            [PSCustomObject]@{
                op = 8
                d = [Ordered]@{
                    requestId = "Batch.$([guid]::NewGuid())"                    
                    executionType = if ($Parallel) {
                        2
                    } elseif ($SerialFrame) {
                        1
                    } else {
                        0
                    }
                    requests  = $allMessages.ToArray()
                }
            } | SendSingleMessageToOBS            
        } 
        else {
            $allMessages | SendSingleMessageToOBS
        }   
    }
}
