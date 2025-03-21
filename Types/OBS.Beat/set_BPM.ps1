<#
.SYNOPSIS
    Sets the BPM    
.DESCRIPTION
    Set the Beats Per Minute (BPM) of obs-powershell.

    This can be used to time effects to a beat.
#>
param(
# The new BPM
[double]
$BPM
)
$this | Add-Member NoteProperty ".BPM" $BPM -Force -PassThru
$duration = 
    [Timespan]::FromMilliseconds(
        (60 * 1000) / $this.'.BPM'
    )
$this.Timer = $duration
