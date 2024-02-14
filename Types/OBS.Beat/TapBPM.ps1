<#
.SYNOPSIS
    Tap BPM
.DESCRIPTION
    Tap out a BPM by pressing ENTER on N beats.

    The BPM will be set to the average time between taps, and the beat will be started. 
#>
param(
# The number of taps.
[int]
$TapCount = 8
)

Write-Host "Press ENTER on the next..."
$beatTimes = @()
$beatTimeStart = [datetime]::Now
$lastBeatTime  = [timespan]::FromMilliseconds(0)
$beatTimes = do {
    Write-Host "$($TapCount -$beatTimes.Length) beats:" -NoNewline
    $readNothing = Read-Host
    $beatTimes += [datetime]::Now
    $lastBeatTime = $beatTimes[-1] - $beatTimeStart
    $beatTimeStart = [datetime]::Now
    $lastBeatTime
} while ($beatTimes.Length -lt $TapCount)

$averageTimeBetweenBeats = 
    $beatTimes.TotalMilliseconds | Measure-Object -Average  | Select-Object -ExpandProperty Average

$this.Duration = $averageTimeBetweenBeats
$this.BeatStart = $beatTimes[-1]
$TappedBpm


