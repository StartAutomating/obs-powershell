<#
.SYNOPSIS
    Disables a filter
.DESCRIPTION
    Disables an OBS filter.
.LINK
    Set-OBSSourceFilterEnabled
#>
param(
# If set, will return the request that would enable a filter.
[switch]
$PassThru
)
$this | Set-OBSSourceFilterEnabled -FilterEnabled:$false -PassThru $PassThru
if (-not $PassThru) {
    $this | Add-Member filterEnabled $false -Force -PassThru
}