[Include('*-*.ps1')]$PSScriptRoot

$MyInvocation.MyCommand.ScriptBlock.Module.OnRemove = {
    Get-OBSEffect | Stop-OBSEffect
    Disconnect-OBS
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