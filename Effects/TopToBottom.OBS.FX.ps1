<#
.SYNOPSIS
    Moves an item from the top to the bottom
.DESCRIPTION
    Moves an item from -50% to 150% height.

    (just off the edge of the top of the screen to just past the bottom edge)
#>
param(
# The name of the scene.
[string]
$SceneName,

# The name 
[string]
$SceneItemID,

# The start position.  By default, -50% (just off the top of the screen)
$StartY = "-50%",

# The end position.  By default, 150% (just off the bottom of the screen)
$EndY = "150%",

# The duration (by default, one second)
[timespan]
$Duration = "00:00:01"
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

# $this.FitToScreen()
$this.Animate(@{y=$StartY}, @{y=$EndY}, $Duration, $true)
