function Get-OBS
{
    <#
    .SYNOPSIS
        Gets OBS
    .DESCRIPTION
        Outputs OBS connection information and state. 
    .EXAMPLE
        Get-OBS
    #>
    param()

    if (-not $script:OBSProcess) {
        $script:OBSProcess = Get-Process obs* | Where-Object Name -in 'obs', 'obs64', 'obs32'
    }

    if (-not $script:OBSProcess) {
        Write-Error "OBS is not running"
        return
    }

    if (-not $script:ObsConnections) {
        Write-Error "Not connected to OBS, use Connect-OBS"
        return
    }

    [PSCustomObject][Ordered]@{
        PSTypeName = 'OBS.PowerShell'
        Process = $script:OBSProcess        
        Connections = $script:ObsConnections.Values
    }
}
