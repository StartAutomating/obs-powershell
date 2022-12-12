function Switch-OBSRecord {
<#
.Synopsis
    
    Switch-OBSRecord : ToggleRecord
    
.Description
    Toggles the status of the record output.
    
    
    Switch-OBSRecord calls the OBS WebSocket with a request of type ToggleRecord.
.Example
    Switch-OBSRecord
.Link
    https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#togglerecord
#>
[Reflection.AssemblyMetadata('OBS.WebSocket.RequestType', 'ToggleRecord')]

param(
[Parameter(ValueFromPipelineByPropertyName)]
[Alias('OutputRequest','OutputInput')]
[switch]
$PassThru
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

    
        # Construct the payload object
        $requestPayload = [Ordered]@{
            # It must include a request ID
            requestId = "$myRequestType.$($script:ObsRequestsCounts[$myRequestType])"
            # request type
            requestType = $myRequestType
            # and optional data
            requestData = $paramCopy
        }

        if ($PassThru) {
            [PSCustomObject]$requestPayload
        } else {
            [PSCustomObject]$requestPayload | 
                Send-OBS
        }

}

} 

