<#
.SYNOPSIS
    Toggles Reversed and Starts an Effect
.DESCRIPTION
    Toggles an Effect's Reversed bool, and starts the effect.
#>
$this.Reversed = -not $this.Reversed
$this.Start()