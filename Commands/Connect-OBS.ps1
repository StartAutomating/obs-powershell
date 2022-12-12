function Connect-OBS
{
    <#
    .SYNOPSIS
        Connects to Open Broadcast Studio
    .DESCRIPTION
        Connects to the obs-websocket.

        This must occur at least once to use obs-powershell.
    .EXAMPLE
        Connect-OBS
    .LINK
        Disconnect-OBS
    #>
    [CmdletBinding(DefaultParameterSetName='ExistingConnections')]
    param(
    # A randomly generated password used to connect to obs.
    # You can see the websocket password in Tools -> obs-websocket settings -> show connect info
    [Parameter(ValueFromPipelineByPropertyName,ParameterSetName='NewConnection')]
    [Alias('WebSocketPassword')]
    [string]
    $WebSocketToken,

    # The websocket URL.  If not provided, this will default to loopback on port 4455.
    [Parameter(ValueFromPipelineByPropertyName,ParameterSetName='NewConnection')]
    [ValidateScript({
        if ($_.Scheme -ne 'ws') {
            throw "Not a websocket uri"
        }
        return $true
    })]
    [uri]
    $WebSocketUri = "ws://$([ipaddress]::Loopback):4455"
    )


    begin {
        if ($home) {
            $obsPowerShellRoot = Join-Path $home '.obs-powershell'
        }
    }

    process {        
        if ($PSCmdlet.ParameterSetName -eq 'NewConnection') {
            $connectionExists = $script:ObsConnections[$WebSocketUri]
            if ($connectionExists -and 
                $connectionExists.State -eq 'Running' -and
                $connectionExists.WebSocket.State -eq 'Open'
            ) {
                $connectionExists
                Write-Verbose "Already connected"
                return
            }

            Watch-OBS @PSBoundParameters
            return
        }
        elseif ($PSCmdlet.ParameterSetName -eq 'ExistingConnections') {
            if ($script:ObsConnections.Count) {
                $script:ObsConnections.Values
            } else {
                $storedSockets = Get-ChildItem -path $obsPowerShellRoot -ErrorAction SilentlyContinue -Filter *.obs-websocket.clixml

                if (-not $storedSockets) {
                    [PSCustomObject][Ordered]@{
                        PSTypeName = 'obs-powershell.not.connected'
                        Message    = 'No connections to OBS.  Use Connect-OBS to connect.'
                    }
                } else {
                    $storedSockets |
                        Import-Clixml |
                        Watch-OBS
                }
            }
        }
    }
}
