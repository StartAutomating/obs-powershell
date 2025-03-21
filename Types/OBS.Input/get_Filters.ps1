<#
.SYNOPSIS
    Gets an input's filters
.DESCRIPTION
    Gets the filters related to an OBS input.
.EXAMPLE
     $obsPowerShellIcon = Show-OBS -Uri https://obs-powershell.start-automating.com/Assets/obs-powershell-animated-icon.svg
     $obsPowerShellIcon | Set-OBSColorFilter -Opacity .5
     $obsPowerShellIcon.Input.Filters
.LINK
    Get-OBSSourceFilterList
#>
Get-OBSSourceFilterList -SourceName $this.InputName