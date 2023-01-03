param(
[Alias('Degrees', 'Rotation')]
[double]
$Degree
)

$this | Set-OBSSceneItemTransform -SceneItemTransform @{
    rotation = $Degree
}