<#
.SYNOPSIS
    Gets the Beat Count
.DESCRIPTION
    Gets the number of beats since the beat started.
.EXAMPLE
    $obs.Beat.BeatCount
#>
if ($this.'.BPM' -and $this.'.BeatStart') {
    ([DateTime]::Now - $this.'.BeatStart').TotalMilliseconds /  
        ((60 * 1000) / $this.'.BPM')
}
