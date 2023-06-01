<#
.SYNOPSIS
    Mutes an input
.DESCRIPTION
    Mutes the audio of an OBS Input
.LINK
    Set-OBSInputMute
#>
param(
# If set, returns the message used to mute
[switch]
$PassThru
)

$this |
    Set-OBSInputMute -InputMuted -PassThru:$PassThru