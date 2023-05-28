<#
.SYNOPSIS
    Stops an input
.DESCRIPTION
    Sends a "Stop" message to an input.   
.LINK
    Send-OBSTriggerMediaInputAction
#>
param(
# If set, will return the message instead of sending it now.
[switch]
$PassThru
)

$this | Send-OBSTriggerMediaInputAction -MediaAction "OBS_WEBSOCKET_MEDIA_INPUT_ACTION_STOP" -PassThru:$PassThru