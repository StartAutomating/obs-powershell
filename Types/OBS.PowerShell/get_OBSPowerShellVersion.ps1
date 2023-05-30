<#
.SYNOPSIS
    Gets the obs-powershell version.
.DESCRIPTION
    Gets the version of obs-powershell.
.EXAMPLE
    Get-OBS | Select-Object -ExpandProperty OBSPowerShellVersion
#>
Get-Module obs-powershell | Select-Object -ExpandProperty Version