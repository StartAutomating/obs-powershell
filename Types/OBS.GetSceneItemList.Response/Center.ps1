<#
.SYNOPSIS
    Centers a scene item
.DESCRIPTION
    Sets the scene item alignment to center
.NOTES
    Also corrects the position so that the image does not only appear in a quadrant. 

    If a boolean argument is passed, and it is true, then this will PassThru instead of run.
    (this can be used for animations)

    If an explicit null argument is passed, then the command will not wait for an OBS response.
    (this will be slightly faster)
#>
param()

$passingThru = $false
$NoResponse  = $false

foreach ($arg in $args) {
    if ($arg -is [bool]) {
        if ($arg) {
            $passingThru= $true
        }
    }
    if ($null -eq $arg) {
        $NoResponse = $true
    }
}

$sceneItemTransform = $this | Get-OBSSceneItemTransform

$sceneItemTransform.alignment = 0 # 0 means center
$sceneItemTransform.positionX = $sceneItemTransform.boundsWidth/2
$sceneItemTransform.positionY = $sceneItemTransform.boundsHeight/2

$this | Set-OBSSceneItemTransform -SceneItemTransform $sceneItemTransform -PassThru:$passingThru -NoResponse:$NoResponse