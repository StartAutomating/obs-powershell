<#
.SYNOPSIS
    Gets the Duration
.DESCRIPTION
    Gets the Duration of a Beat
.OUTPUTS
    [TimeSpan]
#>
param(
# The new duration.
[timespan]
$Duration
)

$this.BPM = ( 60000 / $Duration.TotalMilliseconds )

