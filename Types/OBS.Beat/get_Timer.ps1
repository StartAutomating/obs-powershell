<#
.SYNOPSIS
    Gets the Beat Timer
.DESCRIPTION
    Gets the Timer object that should elapse every beat.

    This can be used to Register-ObjectEvent to run on a beat.
#>
return $this.'.Timer'
