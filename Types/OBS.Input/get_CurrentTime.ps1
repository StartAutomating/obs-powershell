<#
.SYNOPSIS
    Gets an input's current time
.DESCRIPTION
    Gets an input's current time, if applicable
.LINK
    Get-OBSMediaInputStatus
#>
param()

$mediaCursor = ($this | Get-OBSMediaInputStatus).mediaCursor -as [double]
if (-not $mediaCursor) { $mediaCursor = [double]0}
[timespan]::FromMilliseconds($mediaCursor)