<#
.SYNOPSIS
    Sets an input's volume
.DESCRIPTION
    Sets an OBS input's volume mulitplier.

    This is normally between 0 (no sound) and 1 (normal levels).
    
    A source can be made up to 20 times the original volume.
.LINK
    Set-OBSInputVolume
#>
param(
[double]
$Multiple
)

# If multiple is less than zero, clamp it to avoid errors
if ($Multiple -lt 0) { $Multiple = 0}
# If multiple is greater than 20, claim it to avoid errors (and check your hearing)
if ($Multiple -gt 20) { $Multiple = 20} 

$this | Set-OBSInputVolume -InputVolumeMul $Multiple