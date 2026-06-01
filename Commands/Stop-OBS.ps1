function Stop-OBS {
    <#
    .SYNOPSIS
        Stops OBS
    .DESCRIPTION
        Stops OBS.

        By default, stops recording and streaming.

        If -Process is provided, will stop all running OBS processes

        If -Recording is provided, will stop recording
        If -Streaming if provided, will stop obs streaming
        If -VirtualCamera is provided, will stop the virtual camera
    .NOTES        
        This command Supports Should Process and has a ConfirmImpact of 'High'

        In an interactive session, this command prompt by default.

        If `-WhatIf` is passed, will output what happen if this ran
        If `-Confirm:$false`, confirmation will be skipped.
    .EXAMPLE
        # Stop Streaming and Recording
        Stop-OBS 
    .EXAMPLE
        # Stops obs recording
        Stop-OBS -Recording
    .EXAMPLE
        # Stop Streaming        
        Stop-OBS -Streaming
    .EXAMPLE
        # Stop OBS Virtual Camera
        Stop-OBS -VirtualCamera
    .EXAMPLE
        # Stop OBS Virtual Camera without prompting
        Stop-OBS -VirtualCamera -Confirm:$false
    .EXAMPLE
        Stop-OBS -StudioMode
    .LINK
        Stop-OBSRecord
    .LINK
        Stop-OBSStream
    .LINK
        Stop-OBSVirtualCam
    .LINK
        Set-OBSStudioModeEnabled         
    #>
    [CmdletBinding(
        ConfirmImpact='High',
        PositionalBinding=$false,
        SupportsShouldProcess
    )]
    param(
    # If set, will stop recording.
    [switch]
    $Recording,

    # If set, will stop streaming
    [switch]
    $Streaming,

    # If set, will stop the virtual camera.
    [switch]
    $VirtualCamera,

    # If set, will stop the OBS process.
    [switch]
    $Process,

    # If set, will enable studio mode.
    [switch]
    $StudioMode
    )

    if ($Process) { 
        $obsApp = $ExecutionContext.SessionState.InvokeCommand.GetCommand('obs', 'Application')
        if (-not $obsApp -and -not ($IsMacOS -or $IsLinux)) {
            $obsApp = $ExecutionContext.SessionState.InvokeCommand.GetCommand(
                (
                    Join-Path $env:ProgramFiles "obs-studio" |
                        Join-Path -ChildPath 'bin' |
                        Join-Path -ChildPath '64bit' |
                        Join-Path -ChildPath 'obs64.exe'
                ),
                'Application'
            )        
        }

        if (-not $obsApp) {
            Write-Error "OBS not found"
            return 
        }
        
        $obsRunning = Get-Process | 
            Where-Object Path -EQ $obsApp.Source

        if (-not $obsRunning) {
            Write-Error "OBS not running"
            return
        }

        if ($WhatIfPreference) { return $obsRunning }
        if ($PSCmdlet.ShouldProcess('Stop OBS')) {
            $obsRunning | Stop-Process -PassThru
        }
        return
    }

    # Without any parameters, we will stop 
    if (-not $PSBoundParameters.Count) {
        # recording 
        $Recording = $true
        # and streaming.
        $Streaming = $true        
    }



    # If we want to stop recording,
    if ($Recording -and $PSCmdlet.ShouldProcess('Stop Recording')) {
        # `Stop-ObsRecord`.
        Stop-OBSRecord -PassThru:$WhatIfPreference
    }

    # If we want to stop the virtual camera,
    if ($VirtualCamera -and $PSCmdlet.ShouldProcess('Stop Virtual Camera')) {
        # `Stop-OBSVirtualCamera`.
        Stop-OBSVirtualCam -PassThru:$WhatIfPreference
    }

    # If we want to stop streaming,
    if ($Streaming -and $PSCmdlet.ShouldProcess('Stop Streaming')) {
        # `Stop-OBSStream`. 
        Stop-OBSStream -PassThru:$WhatIfPreference
    }

    if ($StudioMode -and $PSCmdlet.ShouldProcess('Stop Studio Mode')) {
        Set-OBSStudioModeEnabled -StudioModeEnabled:$false -PassThru:$WhatIfPreference
    }

    # If we are shutting down any part of obs 
    if ($Recording -or 
        $Streaming -or 
        $StudioMode -or 
        $VirtualCamera) {
        # we do not want to stop obs
        return
    }    
}
