<#
.SYNOPSIS
    Gets the Duration
.DESCRIPTION
    Gets the Duration of a Beat
.OUTPUTSobs
    [TimeSpan]
#>
param(
# The new duration.
# This will also set the BPM
[timespan]
$Duration
)

$this | Add-Member NoteProperty ".BPM" (
    (60 * 1000) / $Duration.TotalMilliseconds
) -Force -PassThru

