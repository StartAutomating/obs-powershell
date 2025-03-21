<#
.SYNOPSIS
    Quickly enables all filters
.DESCRIPTION
    Quickly enables all filters, except for a list of provided names
#>
param(
# A list of filter names to leave disabled.
[string[]]
$ExceptFilterName
)

$this.Filters | 
    Where-Object FilterName -NotIn $ExceptFilterName |
    Foreach-Object { $_.Enable($true) } |
    Send-OBS
