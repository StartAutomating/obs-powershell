$CommandsPath = (Join-Path $PSScriptRoot "Commands")
[Include('*-*.ps1')]$CommandsPath

$MyInvocation.MyCommand.ScriptBlock.Module.OnRemove = {
    Get-OBSEffect | Stop-OBSEffect
    Disconnect-OBS
}

$myModule = $MyInvocation.MyCommand.ScriptBlock.Module
$NewDriveSplat = @{PSProvider='FileSystem';ErrorAction='Ignore';Scope='Global'}
New-PSDrive -Name $myModule.Name -Root $PSScriptRoot -Description "$MyModule" @NewDriveSplat

if ($home) {
    New-PSDrive -Name "my-$($MyModule.Name)" -Root (Join-Path $home ".$($myModule.Name)") -Description "My $MyModule" @NewDriveSplat
}

foreach ($noun in 'Streaming','Recording') {
    foreach ($verb in 'Start', 'Stop') {
        Set-Alias "$verb-$noun" "$verb-OBS$($noun -replace 'ing')"        
    }
}

Connect-OBS

$script:OBS = ${script:OBS-PowerShell} = $MyInvocation.MyCommand.ScriptBlock.Module

$script:OBS | Import-OBSEffect

$script:OBS.pstypenames.insert(0,'obs.powershell')

$ModuleProfilePath = $Profile | Split-Path | Join-Path -ChildPath "$($script:OBS.Name).profile.ps1"
$script:variablesToExport = @('obs','obs-powershell')
if (Test-Path $ModuleProfilePath) {
    . $ModuleProfilePath
}

Export-ModuleMember -Function * -Variable $script:variablesToExport -Alias *