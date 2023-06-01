<#
.SYNOPSIS
    Gets the Effect's Changes
.DESCRIPTION
    Gets the changes the effect will make, without a timespan.
#>
,@(if ($this.Messages) {
        
    foreach ($msg in $this.Messages) {
        if ($msg.RequestType -eq 'Sleep') {
            continue
        }
        $msg
    }
})