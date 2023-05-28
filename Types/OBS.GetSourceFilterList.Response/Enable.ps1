<#
.SYNOPSIS
    Enables a filter
.DESCRIPTION
    Enables an OBS filter.
.LINK
    Set-OBSSourceFilterEnabled
#>
param(
# If set, will return the request that would enable a filter.
[switch]
$PassThru
)

$this | Set-OBSSourceFilterEnabled -FilterEnabled:$true -PassThru:$PassThru
if (-not $PassThru) {
    $this | Add-Member filterEnabled $true -Force -PassThru
}