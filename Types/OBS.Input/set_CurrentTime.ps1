<#
.SYNOPSIS
    Sets an input's current time
.DESCRIPTION
    Sets an input's current time.
.LINK
    Send-OBSMediaInputCursor
#>
param()

$mediaCursor = 0

$PassThru = $false
foreach ($arg in $args) {
    if ($arg -is [double]) {
        $mediaCursor = $arg
    }
    elseif ($arg -as [timespan]) {
        $mediaCursor = $arg -as [timespan].TotalMilliseconds
    }
    if ($arg -is [bool]) {
        $PassThru = $true
    }
}
$this | Set-OBSMediaInputCursor -MediaCursor $mediaCursor  -PassThru:$PassThru