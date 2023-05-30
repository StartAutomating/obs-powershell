<#
.SYNOPSIS
    Gets obs-powershell commands
.DESCRIPTION
    Gets the commands in obs-powershell.
.EXAMPLE
    (Get-OBS).Commands
#>
if (-not $this.'.Commands') {
    $this | Add-Member NoteProperty '.Commands' (Get-Command -Module obs-powershell)
}

$this.'.Commands'