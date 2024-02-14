<#
.SYNOPSIS
    Gets the Beat Angle
.DESCRIPTION
    Gets the Angle of the Beat.

    If we imagine that as the beat is moving, we are rotating around a circle, this should be the angle at any given moment.
#>
$this.BeatCount * 180/[Math]::PI