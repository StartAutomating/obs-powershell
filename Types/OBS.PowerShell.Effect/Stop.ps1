<#
.SYNOPSIS
    Stops an effect
.DESCRIPTION
    Stops an effect, or more properly, prevents an effect from looping
#>
$this | Add-Member -MemberType NoteProperty Mode "Stopped" -Force
