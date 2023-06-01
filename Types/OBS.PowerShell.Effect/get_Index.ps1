<#
.SYNOPSIS
    Gets the index of the effect
.DESCRIPTION
    Gets the current index of the effect.  This is only used for to .Step thru an effect.
#>
if (-not $this.'.Index') {
    Add-Member -MemberType NoteProperty -Name '.Index' -Value 0 -InputObject $this -Force
}

$this.'.Index'

