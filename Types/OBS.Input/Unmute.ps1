<#
.SYNOPSIS
    Mutes an input
.DESCRIPTION
    Mutes the audio of an OBS Input
.LINK
    Set-OBSInputMute
#>
param(
# If set, returns the message used to unmute.
[switch]
$PassThru
)

$this |
    Set-OBSInputMute -InputMuted:$false -PassThru:$PassThru