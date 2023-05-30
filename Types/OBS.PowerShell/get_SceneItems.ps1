<#
.SYNOPSIS
    Gets all obs scene items.
.DESCRIPTION
    Gets every item in every scene in OBS.
.LINK
    Get-OBSScene
.LINK
    Get-OBSSceneItem
#>
$this.Scenes | Get-OBSSceneItem
