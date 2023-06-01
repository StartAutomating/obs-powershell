<#
.SYNOPSIS
    Fades in
.DESCRIPTION
    Fades an input by animating an input's opacity.
#>
param(
# The name of the input
[string]
$InputName,

# The duration (by default, one second)
[timespan]
$Duration = "00:00:01"
)

if (-not $InputName -and $this -and $this.InputName) {
    $InputName = $this.InputName
}

if (-not $InputName -and $this -and $this.SourceName) {
    $InputName = $this.SourceName
}

if (-not $InputName) { return }

$addedFilter = Add-OBSColorFilter -FilterName "FadeIn" -SourceName $InputName

# We want to have roughly two steps per frame
$StepCount = [Math]::Ceiling($Duration.TotalMilliseconds / ([timespan]::fromSeconds(1/30).TotalMilliseconds)) * 2

$stepSleep  = $Duration.TotalMilliseconds / $StepCount

$opacity = 0
$stepOpacity = [double]1/$StepCount
@(foreach ($stepNum in 1..$StepCount) {
    $opacity += $stepOpacity
    Set-OBSColorFilter -FilterName "FadeIn" -SourceName $InputName -Opacity $opacity -PassThru
    Send-OBSSleep -SleepMillis $stepSleep -PassThru
})
