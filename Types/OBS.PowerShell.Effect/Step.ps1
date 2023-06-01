<#
.SYNOPSIS
    Steps thru an effect
.DESCRIPTION
    Steps thru an effect.
    
    This will send individual messages from an effect, without sleeps.
#>
param(
# The step count
[Alias('Ticks')]
[int]
$StepCount = 1
)
if (-not $this.Messages) {
    return
}

$currentIndex = $this.Index
$messages = @($this.Messages)

$stepToIndex = $currentIndex + $StepCount
if ($stepToIndex -lt 0) {
    $messages[0] | Send-OBS -NoResponse
    $this.Index = 0
} elseif ($stepToIndex -gt $messages.Length) {
    $messages[-1] | Send-OBS -NoResponse
    $this.Index = $messages.Length - 1
} else {
    while (
        $stepToIndex -ge 0 -and        
        $messages[$stepToIndex] -and 
        $messages[$stepToIndex].RequestType -eq 'Sleep') {
        if ($StepCount -gt 0) {
            $stepToIndex++
        } else {
            $stepToIndex--
        }
    }
    if ($messages[$stepToIndex]) {
        $messages[$stepToIndex] | Send-obs -NoResponse
    }
    $this.Index = $stepToIndex
}

