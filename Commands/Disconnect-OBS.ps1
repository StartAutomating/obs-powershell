function Disconnect-OBS 
{
    <#
    .SYNOPSIS
        Disconnects OBS
    .DESCRIPTION
        Disconnects Websockets from OBS.

        All websockets will be disconnected.    
    .EXAMPLE
        Disconnect-OBS
    .LINK
        Connect-OBS
    #>
    param()

    process {
        if ($script:ObsConnections.Values) {
            foreach ($connection in $script:ObsConnections.Values) {
                if ($connection.WebSocket.State -eq 'Open') {
                    $null = $connection.WebSocket.CloseAsync('NormalClosure', "obs-powershell $pid disconnecting", [Threading.CancellationToken]::new($false))
                }
            }
            $script:ObsConnections.Values | Stop-Job
            $script:ObsConnections.Values | Remove-Job
        }
        if ($script:ObsConnections) {
            $script:ObsConnections.Clear()
        }
    }
}
