[Include('*-*.ps1')]$PSScriptRoot

$MyInvocation.MyCommand.ScriptBlock.Module.OnRemove = {
    Disconnect-OBS
}

Connect-OBS