describe "obs-powershell" {
    it "Lets you control OBS from PowerShell" {
        Get-OBSMonitor -PassThru | 
            Select-Object -ExpandProperty requestID |
            Should -BeLike GetMonitorList
    }    
}
