<#
.SYNOPSIS
    Moves an item from left to right
.DESCRIPTION
    Moves an item from -50% to 150% width.
#>
param(
# The name of the scene.
[string]
$SceneName,

# The name 
[string]
$SceneItemID,

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

$this.Animate(@{x="-50%"}, @{x='150%'}, $Duration, $true)
