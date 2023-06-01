<#
.SYNOPSIS
    Updates the Effect's Index
.DESCRIPTION
    Updates an effect's index.  This is only used to .Step()
#>
Add-Member -MemberType NoteProperty -Name '.Index' -Value ($args[0] -as [int]) -InputObject $this -Force


