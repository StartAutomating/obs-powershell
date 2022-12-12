function Set-OBSSourceFilterEnabled {
<#
.Synopsis
    
    Set-OBSSourceFilterEnabled : SetSourceFilterEnabled
    
.Description
    Sets the enable state of a source filter.
    
    
    Set-OBSSourceFilterEnabled calls the OBS WebSocket with a request of type SetSourceFilterEnabled.
.Link
    https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsourcefilterenabled
#>
[Reflection.AssemblyMetadata('OBS.WebSocket.RequestType', 'SetSourceFilterEnabled')]

param(
<# Name of the source the filter is on #>
[Parameter(Mandatory,ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('sourceName')]
[string]
$sourceName,
<# Name of the filter #>
[Parameter(Mandatory,ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('filterName')]
[string]
$filterName,
<# New enable state of the filter #>
[Parameter(Mandatory,ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('filterEnabled')]
[switch]
$filterEnabled
)


process {


        # Create a copy of the parameters (that are part of the payload)
        $paramCopy = [Ordered]@{}
        # get a reference to this command
        $myCmd = $MyInvocation.MyCommand

        # Keep track of how many requests we have done of a given type
        # (this makes creating RequestIDs easy)
        if (-not $script:ObsRequestsCounts) {
            $script:ObsRequestsCounts = @{}
        }

        # Set my requestType to blank
        $myRequestType = ''
        # and indicate we are not expecting a response
        $responseExpected = $false
        # Then walk over this commands' attributes,
        foreach ($attr in $myCmd.ScriptBlock.Attributes) {
            if ($attr -is [Reflection.AssemblyMetadataAttribute]) {
                if ($attr.Key -eq 'OBS.WebSocket.RequestType') {
                    $myRequestType = $attr.Value # set the requestType,
                }
                elseif ($attr.Key -eq 'OBS.WebSocket.ExpectingResponse') {
                    # and determine if we are expecting a response.
                    $responseExpected = 
                        if ($attr.Value -eq 'false') {
                            $false   
                        } else { $true }
                }
            }
        }

        # Walk over each parameter
        :nextParam foreach ($keyValue in $PSBoundParameters.GetEnumerator()) {
            # and walk over each of it's attributes to see if it part of the payload
            foreach ($attr in $myCmd.Parameters[$keyValue.Key].Attributes) {
                # If the parameter is bound to part of the payload
                if ($attr -is [ComponentModel.DefaultBindingPropertyAttribute]) {
                    # copy it into our payload dicitionary.
                    $paramCopy[$attr.Name] = $keyValue.Value
                    # (don't forget to turn switches into booleans)
                    if ($paramCopy[$attr.Name] -is [switch]) {
                        $paramCopy[$attr.Name] = [bool]$paramCopy[$attr.Name]
                    }
                    continue nextParam
                }
            }
        }

        
        # If we don't have a request counter for this request type
        if (-not $script:ObsRequestsCounts[$myRequestType]) {
            # initialize it to zero.
            $script:ObsRequestsCounts[$myRequestType] = 0
        }
        # Increment the counter for requests of this type
        $script:ObsRequestsCounts[$myRequestType]++

        # and make a request ID from that.
        $myRequestId = "$myRequestType.$($script:ObsRequestsCounts[$myRequestType])"

        # Construct the actual payload
        $payloadJson = [Ordered]@{
            op = 6   # All requests are sent with the opcode 6
            d = @{
                # and must include a request ID
                requestId = "$myRequestType.$($script:ObsRequestsCounts[$myRequestType])"
                # request type
                requestType = $myRequestType
                # and optional data
                requestData = $paramCopy
            }
        } |
            # Once we have constructed the payload, make it JSON
            ConvertTo-Json -Depth 100
        
        # And create a byte segment to send it offf.
        $SendSegment  = [ArraySegment[Byte]]::new([Text.Encoding]::UTF8.GetBytes($PayloadJson))

        # If we have no OBS connections
        if (-not $script:ObsConnections.Values) {
            # error out
            Write-Error "Not connected to OBS.  Use Connect-OBS."
            return
        }

        # Otherwise, walk over each connection
        foreach ($obsConnection in $script:ObsConnections.Values) {
            $OBSWebSocket = $obsConnection.Websocket
            if ($VerbosePreference -notin 'silentlyContinue', 'ignore') {
                Write-Verbose "Sending $payloadJSON"
            }
            # and send the payload
            $null = $OBSWebSocket.SendAsync($SendSegment,'Text', $true, [Threading.CancellationToken]::new($false))

            # If a response was expected
            if ($responseExpected) {
                # wait a second for that event
                $eventResponse = Wait-Event -SourceIdentifier $myRequestId -Timeout 1 |
                    Select-Object -ExpandProperty MessageData

                if ($eventResponse -is [Management.Automation.ErrorRecord]) {
                    Write-Error -ErrorRecord $eventResponse
                    continue
                }
                # Collect all properties from the response
                $eventResponseProperties = @($eventResponse.psobject.properties)
                
                $expandedResponse =
                    # If there was only one, expand that property
                    if ($eventResponseProperties.Length -eq 1) {
                        $eventResponse.psobject.properties.value
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
                    # and decorate it with the command name and OBS.requestype.response
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
        }

}

} 

