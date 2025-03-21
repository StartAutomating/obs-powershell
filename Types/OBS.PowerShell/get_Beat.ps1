<#
.SYNOPSIS
    Gets the Beat
.DESCRIPTION
    Gets the Beat Controller for obs-powershell.

    The beat controller allows you to control effects on a beat.
#>
if (-not $this.'.Beat') {
    $this | Add-Member NoteProperty '.Beat' ([PSCustomObject]@{
        PSTypeName = "OBS.Beat"
    }) -Force
}
return $this.'.Beat'