function Set-OBSStreamServiceSettings {
<#
.Synopsis
    
    Set-OBSStreamServiceSettings : SetStreamServiceSettings
    
.Description
    Sets the current stream service settings (stream destination).
    
    Note: Simple RTMP settings can be set with type `rtmp_custom` and the settings fields `server` and `key`.
    
    
    Set-OBSStreamServiceSettings calls the OBS WebSocket with a request of type SetStreamServiceSettings.
.Link
    https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setstreamservicesettings
#>
[Reflection.AssemblyMetadata('OBS.WebSocket.RequestType', 'SetStreamServiceSettings')]

param(
<# Type of stream service to apply. Example: `rtmp_common` or `rtmp_custom` #>
[Parameter(Mandatory,ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('streamServiceType')]
[string]
$streamServiceType,
<# Settings to apply to the service #>
[Parameter(Mandatory,ValueFromPipelineByPropertyName)]
[ComponentModel.DefaultBindingProperty('streamServiceSettings')]
[PSObject]
$streamServiceSettings,
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
                Send-OBS
        }

}

} 

