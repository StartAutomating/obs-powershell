<#
.SYNOPSIS
    Loops Colors
.DESCRIPTION
    Loops thru potential hue adjustment for an input.
#>
param(
[string]
$InputName,

[timespan]
$Duration = "00:00:02"
)

if (-not $InputName -and $this -and $this.InputName) {
    $InputName = $this.InputName
}

if (-not $InputName -and $this -and $this.SourceName) {
    $InputName = $this.SourceName
}

if (-not $InputName) { return }

Add-OBSColorFilter -FilterName "ColorLoop" -SourceName $InputName -ErrorAction SilentlyContinue | Out-Null

$StepCount = [Math]::Ceiling($Duration.TotalMilliseconds / ([timespan]::fromSeconds(1/30).TotalMilliseconds)) * 2

$stepSleep  = $Duration.TotalMilliseconds / $StepCount

$hue = 0
$hueIncrement = 360 / $StepCount
@(foreach ($stepNum in 1..$StepCount) {
    $hue += $hueIncrement
    Set-OBSColorFilter -FilterName "ColorLoop" -SourceName $InputName -Hue $hue  -PassThru
    Send-OBSSleep -SleepMillis $stepSleep -PassThru
})
