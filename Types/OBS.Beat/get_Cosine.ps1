<#
.SYNOPSIS
    Gets the Beat Cosine
.DESCRIPTION
    Gets the Cosine of the BeatCount.

    Since this starts at 1, this would be at its highest value during the top of the beat.
#>
[Math]::Cos($this.BeatCount * ([Math]::PI/2))