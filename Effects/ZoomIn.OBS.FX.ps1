<#
.SYNOPSIS
    Zooms an item in
.DESCRIPTION
    Zooms an item from 0% scale to 200%
#>
param(
# The name of the scene.
[string]
$SceneName,

# The name 
[string]
$SceneItemID,

# The start zoom.  By default, 0% (effectively invisible)
$StartZoom = "0%",

# The end zoom.  By default, 200% (twice normal size)
$EndZoom = "200%",

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
$this.scale(
    $StartZoom, 
    $Duration,
    $EndZoom,     
    $true
)

