function Set-OBSSourceProjectorProperties {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string]$SourceName,

        [Parameter(ValueFromPipelineByPropertyName)]
        [hashtable]$Position,

        [Parameter(ValueFromPipelineByPropertyName)]
        [double]$Rotation,

        [Parameter(ValueFromPipelineByPropertyName)]
        [hashtable]$Scale
    )

    # Create a copy of the parameters
    $paramCopy = [ordered]@{
        'scene' = $SourceName
        'position' = $Position
        'rotation' = $Rotation
        'scale' = $Scale
    }

    # Construct the request payload
    $requestPayload = @{
        'requestType' = 'SetSceneItemProperties'
        'scene-name' = $SourceName
        'item' = $SourceName
        'position' = $Position
        'rotation' = $Rotation
        'scale' = $Scale
    }

    # Send the request to OBS WebSocket API
    [PSCustomObject]$requestPayload | Send-OBSWebSocket
}
