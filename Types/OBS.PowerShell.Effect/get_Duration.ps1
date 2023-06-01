<#
.SYNOPSIS
    Gets an Effect's Duration
.DESCRIPTION
    Gets the total time the effect will sleep.
#>

$totalMS = [double]0
foreach ($msg in $this.Messages) {
    if ($msg.RequestType -eq 'Sleep') {
        $totalMS += $msg.RequestData.sleepMillis
    }
}
[timespan]::FromMilliseconds($totalMS)