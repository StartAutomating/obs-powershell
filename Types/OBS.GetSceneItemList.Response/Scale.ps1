param(
[double[]]
$ScaleX = 1,

[double[]]
$ScaleY = 1,

# The timespan the animation will take
[TimeSpan]
$TimeSpan = [timespan]::fromSeconds(1)
)

if ($scaleX.Length -eq 1 -and $scaleY.Length -eq 1) {
    $this | Set-OBSSceneItemTransform -SceneItemTransform @{
        scaleX = $ScaleX[0]
        scaleY = $scaleY[0]
    }
    return
}

$thisTransform = $this | Get-OBSSceneItemTransform 

$fromValue = [Ordered]@{
    scaleX = $thisTransform.scaleX
    scaleY = $thisTransform.scaleY
}

$durationPerStep = [TimeSpan]::FromMilliseconds($TimeSpan.TotalMilliseconds / $ScaleX.Length)

for ($stepNumber = 0; $stepNumber -lt $ScaleX.Length; $stepNumber++) {
    $toValue = [Ordered]@{
        scaleX = $ScaleX[$stepNumber]
        scaleY = $ScaleY[$stepNumber]
    }
    $this.Animate($fromValue, $toValue, $durationPerStep)
    $fromValue = $toValue
}

