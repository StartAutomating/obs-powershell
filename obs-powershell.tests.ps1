describe "obs-powershell" {
    it "Lets you control OBS from PowerShell" {
        Get-OBSMonitor -PassThru | 
            Select-Object -ExpandProperty requestID |
            Should -BeLike GetMonitorList*
    }
    
    it 'Has lots of OBS websocket commands' {
        Get-Command -Name *-OBS | 
            Measure-Object |
            Select-Object -ExpandProperty Count |
            Should -BeGreaterThan 100
    }

    it 'Communicates requests in a predictable way' {
        $allRequestCommands = Get-Command -Name *-OBS* |
            Where-Object { 
                $_.ScriptBlock.Attributes.Key -contains 'OBS.WebSocket.RequestType'
            }

        $allEasyCommands = $allRequestCommands | 
            Where-Object {
                ($_ | Get-Command -Syntax) -match "$($_.Name) \[-PassThru\]"
            }

        foreach ($command in $allEasyCommands) {
            $requestType  = foreach ($attr in $command.ScriptBlock.Attributes) {
                if ($attr.Key -eq 'OBS.WebSocket.RequestType') {
                    $attr.Value;break
                }
            }
            $cmdOut = & $command -PassThru
            $cmdOut | Select-Object -ExpandProperty RequestID | Should -belike "$requestType*"
        }
        
    }
}
