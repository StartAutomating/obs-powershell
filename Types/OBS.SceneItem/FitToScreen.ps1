<#
.SYNOPSIS
    Fits an item to the screen
.DESCRIPTION
    Centers an item and makes it fit to the screen.
.LINK
    Get-OBSVideoSettings
.LINK
    Get-OBSSceneItemTransform
.LINK
    Set-OBSSceneItemTransform
#>
param()
if (-not $script:CachedOBSVideoSettings) {
    $script:CachedOBSVideoSettings = Get-OBSVideoSettings
}
$videoSettings = $script:CachedOBSVideoSettings

$thisTransform = $this | Get-OBSSceneItemTransform

$sceneItemTransform = ([Ordered]@{
    alignment = 0
    scaleX    = ([double]$videoSettings.outputWidth / $thisTransform.sourceWidth )
    positionX = [int]($videoSettings.outputWidth / 2)
    positionY = [int]($videoSettings.outputHeight / 2)
    scaleY    = ([double]$videoSettings.outputHeight / $thisTransform.sourceHeight )
})

$this | Set-OBSSceneItemTransform -SceneItemTransform $sceneItemTransform