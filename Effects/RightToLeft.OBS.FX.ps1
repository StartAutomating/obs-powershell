<#
.SYNOPSIS
    Moves an item from left to right
.DESCRIPTION
    Moves an item from 150% to -50% width.
    
    (just off the edge of the right side of the screen to just past the edge of the left)
#>
param(
# The name of the input
[string]
$SceneName,

# The scene item ID.
[string]
$SceneItemID,

# The start position.  By default, 150% (just off the left edge of the screen)
$StartX = "150%",

# The end position.  By default, -50% (just off the left edge of the screen)
$EndX = "-50%",

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
$this.Animate(@{x=$StartX}, @{x=$EndX}, $Duration, $true)
