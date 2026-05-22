
function Start-OBS {
    <#
    .SYNOPSIS
        Start OBS
    .DESCRIPTION
        Starts OBS

        Without any parameters, will attempt to start the obs process.

        If OBS is already running, will output the current obs process.

        * If `-Recording` is passed, will start recording
        * If `-Streaming` is passed, will start streaming
        * If `-StudioMode` is passed, will start studio mode
        * If `-VirtualCamera` is passed, will start the virtual camera
        
        If additional arguments are passed, will pass them thru to a new obs process.
    .LINK
        Stop-OBS
    .LINK
        Start-OBSRecord
    .LINK
        Start-OBSStream
    .LINK
        Start-OBSVirtualCam    
    #>
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess)]
    param(
    # A list of arguments.  These will be passed to a new obs process. 
    [Parameter(ValueFromRemainingArguments)]
    [Alias('Arguments','Argument','Args')]
    [PSObject[]]
    $ArgumentList,

    # Any input object.  This will currently be ignored.
    [Parameter(ValueFromPipeline)]
    [PSObject[]]
    $InputObject,

    # If set, will start recording.
    [Alias('Record')]
    [switch]
    $Recording,

    # If set, will start streaming.
    [Alias('Stream')]
    [switch]
    $Streaming,

    # If set, will start studio mode.
    [switch]
    $StudioMode,

    # If set, will start the virtual camera
    [Alias('VirtualCam')]
    [switch]
    $VirtualCamera
    )


    # Get the obs application
    $obsApp = $ExecutionContext.SessionState.InvokeCommand.GetCommand('obs', 'Application')
    # If it was not in the path, and we are on Windows
    if (-not $obsApp -and -not ($IsMacOS -or $IsLinux)) {
        # look in program files.
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

    # If we could not find obs
    if (-not $obsApp) {
        # error out
        Write-Error "OBS not found"
        return 
    }
    
    # Determine if obs is already running
    $obsRunning = Get-Process | 
        Where-Object Path -EQ $obsApp.Source

    # If it is running, we can start various obs features.
    if ($obsRunning) {        
        # If we want to start recording,
        if ($Recording -and (
            $WhatIfPreference -or 
            $PSCmdlet.ShouldProcess('Start Recording')
        )) {
            # `Start-OBSRecord`.
            Start-OBSRecord -PassThru:$WhatIfPreference
        }
        
        # If we want to start streaming,
        if ($Streaming -and (
            $WhatIfPreference -or 
            $PSCmdlet.ShouldProcess('Start Streaming')
        )) {
            # `Start-OBSStream`.
            Start-OBSStream -PassThru:$WhatIfPreference
        }

        # If we want to start studio mode,
        if ($StudioMode -and (
            $WhatIfPreference -or 
            $PSCmdlet.ShouldProcess('Start Studio Mode')
        )) {
            # `Set-OBSStudioModeEnabled`.
            Set-OBSStudioModeEnabled -StudioModeEnabled:$true -PassThru:$WhatIfPreference
        }

        # If we want to start the virtual camera,
        if ($VirtualCamera -and (
            $WhatIfPreference -or 
            $PSCmdlet.ShouldProcess('Start Virtual Camera')
        )) {
            # `Start-OBSVirtualCam`.
            Start-OBSVirtualCam -PassThru:$WhatIfPreference
        }
        
        # If any of these options were run
        # they will output
        if ($Recording -or 
            $Streaming -or 
            $StudioMode -or 
            $VirtualCamera
        ) {
            # and we can return.
            return
        }

        # Otherwise, return the obs process.
        return $obsRunning
    } else {
        # If the process was not running, start it.
        Start-Process -FilePath $obsApp.Path -PassThru -ArgumentList $ArgumentList -WorkingDirectory (
            $obsApp.Path | Split-Path
        )

        # If we wanted to start recording, streaming, studio mode, or virtual camera
        if ($Recording -or 
            $Streaming -or 
            $StudioMode -or 
            $VirtualCamera
        ) {
            # warn us that we need to wait a bit.
            Write-Warning "OBS starting up, cannot start virtual camera, recording, or streaming"
        }
    }
}