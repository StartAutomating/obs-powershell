<#
.SYNOPSIS
    Sets the Beat Start Time
.DESCRIPTION
    Sets the time when the beat started. 
#>
param(
    # The Beat Start Time
    [DateTime]$BeatStartTime
)
if ($this.'.BPM') {
    $this | Add-Member NoteProperty ".BeatStart" (
        $BeatStartTime
    ) -Force
    $this.Timer.Start()
}

