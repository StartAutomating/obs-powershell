<#
.SYNOPSIS
    Gets the Duration
.DESCRIPTION
    Gets the Duration of a Beat
.OUTPUTS
    [TimeSpan]
#>
if ($this.'.BPM') {
    [Timespan]::FromMilliseconds((60 * 1000) / $this.'.BPM')
}
