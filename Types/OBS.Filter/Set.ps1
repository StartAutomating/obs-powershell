<#
.SYNOPSIS
    Sets a filter
.DESCRIPTION
    Changes a filter's settings.
#>
param(
# The settings that can be changed.
[Alias('Setting')]
$Settings,

# Return the message that would be sent to OBS, rather than changing the filter settings.
[switch]
$PassThru
)

$this | 
    Set-OBSSourceFilterSettings -FilterSettings $Settings -PassThru:$PassThru