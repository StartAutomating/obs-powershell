<#
.SYNOPSIS
    Gets the Beat Sine
.DESCRIPTION
    Gets the Sine of the BeatCount.

    Since this starts at 0, this would be at its highest value during the middle of the beat.
#>
[Math]::Cos($this.BeatCount * [Math]::PI/2)