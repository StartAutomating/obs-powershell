function Open-OBSVideoMixProjector {
<#
.Synopsis
    
    Open-OBSVideoMixProjector : OpenVideoMixProjector
    
.Description
    Opens a projector for a specific output video mix.
    
    Mix types:
    
    - `OBS_WEBSOCKET_VIDEO_MIX_TYPE_PREVIEW`
    - `OBS_WEBSOCKET_VIDEO_MIX_TYPE_PROGRAM`
    - `OBS_WEBSOCKET_VIDEO_MIX_TYPE_MULTIVIEW`
    
    Note: This request serves to provide feature parity with 4.x. It is very likely to be changed/deprecated in a future release.
    
    
    Open-OBSVideoMixProjector calls the OBS WebSocket with a request of type OpenVideoMixProjector.
.Link
    https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#openvideomixprojector
#>
[Reflection.AssemblyMetadata('OBS.WebSocket.RequestType', 'OpenVideoMixProjector')]
[Alias('obs.powershell.websocket.OpenVideoMixProjector')]
param(
<# Type of mix to open #>
[Parameter(Mandatory,ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('videoMixType')]
[string]
$VideoMixType,
<# Monitor index, use `GetMonitorList` to obtain index #>
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('monitorIndex')]
[double]
$MonitorIndex,
<# Size/Position data for a windowed projector, in Qt Base64 encoded format. Mutually exclusive with `monitorIndex` #>
[Parameter(ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('projectorGeometry')]
[string]
$ProjectorGeometry,
# If set, will return the information that would otherwise be sent to OBS.
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
                    if ($attr.Name -like '*path') {
                        $paramCopy[$attr.Name] =
                            "$($ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($paramCopy[$attr.Name]))"
                    }
                    continue nextParam
                }
            }
        }
        
        # and make a request ID from that.
        $myRequestId = "$myRequestType.$([Guid]::newGuid())"
    
        # Construct the payload object
        $requestPayload = [Ordered]@{
            # It must include a request ID
            requestId = $myRequestId
            # request type
            requestType = $myRequestType
            # and optional data
            requestData = $paramCopy
        }
        if ($PassThru) {
            [PSCustomObject]$requestPayload
        } else {
            [PSCustomObject]$requestPayload | 
                Send-OBS -DoNotReceive:$responseExpected
        }
}
} 

