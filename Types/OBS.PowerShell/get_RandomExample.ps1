<#
.SYNOPSIS

.DESCRIPTION

#>
$foundAnExample = $false
do {
    $helpObject = $this.Commands | Get-Random | Get-Help
    if (-not $helpObject.Examples) { continue }
    $foundAnExample = $helpObject.Examples[0] | Get-Random | Select-Object -ExpandProperty Example
} until ($foundAnExample)

$foundAnExample
