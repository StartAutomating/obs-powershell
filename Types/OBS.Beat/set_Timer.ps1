<#
.SYNOPSIS
    Sets the Beat Timer
.DESCRIPTION
    Sets the Beat Timer.

    If no timer exists, one is created.  Otherwise, the interval is updated.
.OUTPUTS
    [TimeSpan]
#>
param(
# The new timer interval.
[timespan]
$Interval
)

if (-not $this.'.Timer') {
    $this.'.Timer' = [Timers.Timer]::new($Interval.TotalMilliseconds)
} else {
    $this.'.Timer'.Interval = $Interval.TotalMilliseconds
}


