$videoSettings = Get-OBSVideoSettings

$thisTransform = $this | Get-OBSSceneItemTransform

$sceneItemTransform = ([Ordered]@{
    alignment = 0
    scaleX    = ([double]$videoSettings.outputWidth / $thisTransform.sourceWidth )
    positionX = [int]($videoSettings.outputWidth / 2)
    positionY = [int]($videoSettings.outputHeight / 2)
    scaleY    = ([double]$videoSettings.outputHeight / $thisTransform.sourceHeight )
})

$this | Set-OBSSceneItemTransform -SceneItemTransform $sceneItemTransform