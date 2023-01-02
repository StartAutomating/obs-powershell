$videoSettings = Get-OBSVideoSettings

$this | Set-OBSSceneItemTransform -SceneItemTransform ([PSCustomObject][Ordered]@{
    alignment = 0
    height = $videoSettings.outputHeight    
    positionX = [int]($videoSettings.outputWidth / 2)
    positionY = [int]($videoSettings.outputHeight / 2)
    width = $videoSettings.outputWidth
})