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
    $this | Add-Member NoteProperty '.Timer' ([Timers.Timer]::new($Interval.TotalMilliseconds)) -Force
} else {
    $this.'.Timer'.Interval = $Interval.TotalMilliseconds
}


