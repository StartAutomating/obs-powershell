<#
.SYNOPSIS
    Previouss an input
.DESCRIPTION
    Sends a "Previous" message to an input.   
.LINK
    Send-OBSTriggerMediaInputAction
#>
param(
# If set, will return the message instead of sending it now.
[switch]
$PassThru
)

$this | Send-OBSTriggerMediaInputAction -MediaAction "OBS_WEBSOCKET_MEDIA_INPUT_ACTION_PREVIOUS" -PassThru:$PassThru