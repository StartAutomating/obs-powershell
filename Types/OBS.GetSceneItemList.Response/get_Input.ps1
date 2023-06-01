<#
.SYNOPSIS
    Gets a Scene Item's Input
.DESCRIPTION
    Gets the OBS Input related to the current scene item.

    This value is cached upon first request, as it will never change as long as the source item exists.
.EXAMPLE
    $stars = Show-OBS -Uri https://pssvg.start-automating.com/Examples/Stars.svg
    $stars.Input
#>
if (-not $this.'.Input') {
    $this | Add-Member NoteProperty '.Input' (
        $this | Get-OBSInput | Where-Object InputName -eq $this.SourceName
    ) -Force
}

$this.'.Input'
