<#
.SYNOPSIS
    Quickly disables all filters
.DESCRIPTION
    Quickly disables all filters, except for a list of provided names
#>
param(
# A list of filter names to leave disabled.
[string[]]
$ExceptFilterName
)

$this.Filters | 
    Where-Object FilterName -NotIn $ExceptFilterName |
    Foreach-Object { $_.Disable($true) } |
    Send-OBS
