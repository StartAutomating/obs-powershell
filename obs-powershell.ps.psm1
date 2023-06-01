[Include('*-*.ps1')]$PSScriptRoot

$MyInvocation.MyCommand.ScriptBlock.Module.OnRemove = {
    Disconnect-OBS
}

foreach ($noun in 'Streaming','Recording') {
    foreach ($verb in 'Start', 'Stop') {
        Set-Alias "$verb-$noun" "$verb-OBS$($noun -replace 'ing')"        
    }
}

Connect-OBS

$MyInvocation.MyCommand.Module | Import-OBSEffect