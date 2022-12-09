obs-powershell is a PowerShell module that lets you script Open Broadcast Studio.

## Getting Started

### Installing and importing

obs-powershell is available on the PowerShell gallery, so you can use these two simple lines to install / import

~~~PowerShell
Install-Module obs-powershell -Scope CurrentUser -Force
Import-Module obs-powershell -PassThru -Force
~~~

## Examples

### Getting all monitors

~~~PowerShell
Get-OBSMonitor
~~~

### Getting all kinds of available inputs
~~~PowerShell
Get-OBSInputKind
~~~

### Getting OBS Starts
~~~PowerShell
Get-OBSStats
~~~

### Getting Recording Status
~~~PowerShell
Get-OBSRecordStatus
~~~

### Starting Recording
~~~PowerShell
Start-OBSRecord
~~~

### Stopping Recording
~~~PowerShell
Stop-OBSRecord
~~~

### Start Recording, Wait 5 seconds, Stop Recording, and Play the Recording.
~~~PowerShell
Start-OBSRecord

Start-Sleep -Seconds 5

Stop-OBSRecord |
    Invoke-Item
~~~

### Listing scenes

~~~Powershell
Get-OBSScene
~~~

### Enabling all sources in all scenes
~~~PowerShell
Get-OBSScene |
    Select-Object -ExpandProperty Scene
    Get-OBSSceneItem |
    Set-OBSSceneItemEnabled -sceneItemEnabled
~~~

### Disabling all sources in all scenes
~~~PowerShell
Get-OBSScene |
    Select-Object -ExpandProperty Scene
    Get-OBSSceneItem |
    Set-OBSSceneItemEnabled -sceneItemEnabled:$false
~~~

### Adding a Browser Input to all scenes
~~~PowerShell
Get-OBSScene | 
    Add-OBSInput -inputName "Browser Input 2" -inputKind browser_source -inputSettings @{
        width=1920
        height=1080
        url='https://pssvg.start-automating.com/Examples/SpinningSpiral901.svg'
    }
~~~



## How it Works

obs-powershell communicates with OBS with the obs websocket.

obs-powershell has a command for every websocket request.

Because the obs-websocket cleanly documents it's protocol, most commands in obs-powershell are automatically generated with [PipeScript](https://github.com/StartAutomating/PipeScript).

### obs-powershell websocket commands

~~~PipeScript {
    $importedModule = Import-Module .\obs-powershell.psd1 -Passthru
    $exportedCmds = $importedModule.ExportedCommands.Values | 
        Where-Object Name -notin 'Connect-OBS', 'Disconnect-OBS'
    [PSCustomObject]@{
        Table = $exportedCmds |
            .Name {
                "[$($_.Name)]($("docs/$($_.Name).md"))"
            } .RequestType {
                $cmd = $_
                foreach ($attr in $cmd.ScriptBlock.Attributes) {
                    if ($attr.Key -eq 'OBS.WebSocket.RequestType') {
                        "[$($attr.Value)](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#$($attr.Value.ToLower()))"
                    }
                }
            }
    }    
}
~~~


