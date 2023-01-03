param([string]$BlendMode)

if ($blendMode -cnotmatch '^OBS_BLEND_') {
    $blendMode = "OBS_BLEND_$($blendMode.ToUpper())"
}
$this |
    Set-OBSSceneItemBlendMode -SceneItemBlendMode $blendMode
