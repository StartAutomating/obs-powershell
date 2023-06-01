<#
.SYNOPSIS
    Gets an obs-powershell effect's type
.DESCRIPTION
    Gets the type of an obs-powershell effect.

    Current can be either 'Command' or 'Messages'
#>
if ($this.pstypenames -like 'OBS.PowerShell.Effect.Command*') {
    'Command'
} else {
    'Messages'
}