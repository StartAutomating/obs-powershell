<#
.SYNOPSIS
    Gets an input's settings
.DESCRIPTION
    Gets the current settings for an OBS input.
.EXAMPLE
     $obsPowerShellIcon = Show-OBS -Uri https://obs-powershell.start-automating.com/Assets/obs-powershell-animated-icon.svg
     $obsPowerShellIcon.Input.Settings     
.LINK
    Get-OBSInputSettings
#>
(Get-OBSInputSettings -InputName $this.InputName).inputSettings