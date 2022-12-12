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
}
