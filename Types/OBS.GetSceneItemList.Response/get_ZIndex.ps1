$indexInfo = $this | Get-OBSSceneItemIndex
if ($indexInfo.SceneItemIndex) {
    $indexInfo.SceneItemIndex
}
elseif ($indexInfo -is [int]) {
    $indexInfo
}