<#
.SYNOPSIS
    Sets if an effect should be reversed.
.DESCRIPTION
    Sets if an effect should be played in reverse.
#>
$this | Add-Member NoteProperty '.Reversed' ($args[0] -as [bool]) -Force
