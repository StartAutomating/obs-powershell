<#
.SYNOPSIS
    Zooms In and Out again
.DESCRIPTION
    Zooms an Input In and Out.
#>
param(
# The name of the scene.
[string]
$SceneName,

# The name 
[string]
$SceneItemID,

# The duration (by default, one a half second)
[timespan]
$Duration = "00:00:00.5",

# The pause between (by default, one a half second)
[Timespan]
$PauseBetween = '00:00:00.5'
)

if (-not $SceneName -and $this -and $this.SceneName) {
    $SceneName = $this.SceneName
}

if (-not $SceneItemID -and $this -and $this.SceneItemID) {
    $SceneItemID = $this.SceneItemID
}

if (-not $SceneItemID -and $SceneName) { return }

$sceneItem = if ($this.SceneName -and $this.SceneItemID) {
    $this
} elseif ($SceneItemID) {
    Get-OBSSceneItem -SceneName $this.SceneName | 
        Where-Object { 
            $_.SceneItemID -eq $SceneItemID -or 
            $_.SourceName -eq $SceneItemID
        }
}
# Fit it to the screen once, so we're centered correctly.
$sceneItem.FitToScreen()

# 
$sceneItem.Scale(
    "0%", 
    "150%", 
    $Duration, 
    $PauseBetween, 
    $Duration,
    "0%",
    $true
)

