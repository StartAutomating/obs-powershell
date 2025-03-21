<#
.SYNOPSIS
    Sets an input's settings
.DESCRIPTION
    Changes the settings for an OBS input.
.LINK
    Set-OBSInputSettings
#>
param()
Set-OBSInputSettings -InputName $this.InputName -InputSettings $args[0]