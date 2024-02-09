$this | Set-OBSSceneItemIndex -SceneItemIndex ($args[0])
$this | Add-Member NoteProperty "sceneItemIndex" $args[0] -Force 