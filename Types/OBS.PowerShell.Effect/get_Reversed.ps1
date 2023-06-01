<#
.SYNOPSIS
    Gets if an effect is reversed.
.DESCRIPTION
    Gets if an effect is currently set to Reverse.

    Whenever reverse is set, effect messages will be reversed before being sent.
#>
if (-not $this.'.Reversed') {
    $this | Add-Member NoteProperty '.Reversed' $false -Force
}

$this.'.Reversed'