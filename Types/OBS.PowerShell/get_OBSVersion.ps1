<#
.SYNOPSIS
    Gets the obs version.
.DESCRIPTION
    Gets the version of obs.
.EXAMPLE
    Get-OBS | Select-Object -ExpandProperty OBSVersion
#>
if (-not $this.'.OBSVersionInfo') {
    $this | Add-Member NoteProperty '.OBSVersionInfo' (Get-OBSVersion) -Force
}

$this.'.OBSVersionInfo'.OBSVersion -as [version]