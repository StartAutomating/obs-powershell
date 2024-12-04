function Set-OBSSoundCloudSource {
    <#
    
    .SYNOPSIS    
        Sets a Sound Cloud Source    
    .DESCRIPTION    
        Adds or changes a Sound Cloud source OBS.    
        Sound Cloud Sources are Browser Sources that display a [SoundCloud Player Widget](https://developers.soundcloud.com/docs/api/html5-widget).    
    .EXAMPLE    
        Set-obssoundCloudSource -Uri https://soundcloud.com/outertone/sets/new-earth    
    
    #>
            
    [Alias('Add-OBSSoundCloudSource','Get-OBSSoundCloudSource')]
    param(
    # The uri to display.  This must point to a SoundCloud URL.    
    [Parameter(ValueFromPipelineByPropertyName)]    
    [Alias('Url','SoundCloudUri','SoundCloudUrl')]
    [uri]
    $Uri,

    # If set, will not autoplay.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $NoAutoPlay,

    # If set, will not display album artwork.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $NoArtwork,

    # If set, will not display play count.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $NoPlayCount,

    # If set, will not display uploader info.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $NoUploaderInfo,

    # If provided, will start playing at a given track number.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [int]
    $TrackNumber,

    # If set, will show a share link.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $ShowShare,

    # If set, will show a download link.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $ShowDownload,

    # If set, will show a buy link.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $ShowBuy,

    # The color used for the SoundCloud audio bars and buttons.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $Color,

    # The width of the browser source.    
    # If none is provided, this will be the output width of the video settings.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("width")]
    [int]
    $Width,

    # The width of the browser source.    
    # If none is provided, this will be the output height of the video settings.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("height")]
    [int]
    $Height,

    # The css style used to render the browser page.     
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("css")]
    [string]
    $CSS = "body { background-color: rgba(0, 0, 0, 0); margin: 0px auto; overflow: hidden; }",

    # If set, the browser source will shutdown when it is hidden    
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("shutdown")]
    [switch]
    $ShutdownWhenHidden,

    # If set, the browser source will restart when it is activated.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("restart_when_active")]
    [switch]
    $RestartWhenActived,

    # If set, audio from the browser source will be rerouted into OBS.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("reroute_audio")]
    [switch]
    $RerouteAudio,

    # If provided, the browser source will render at a custom frame rate.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("fps")]
    [Alias('FPS')]    
    [int]
    $FramesPerSecond,

    # The name of the scene.    
    # If no scene name is provided, the current program scene will be used.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('SceneName')]
    [string]
    $Scene,

    # The name of the input.    
    # If no name is provided, then "SoundCloud" will be used.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('InputName','SourceName')]
    [string]
    $Name,

    # If set, will check if the source exists in the scene before creating it and removing any existing sources found.    
    # If not set, you will get an error if a source with the same name exists.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $Force
    )
    dynamicParam {
    $baseCommand = 
        if (-not $script:AddOBSInput) {
            $script:AddOBSInput = 
                $executionContext.SessionState.InvokeCommand.GetCommand('Add-OBSInput','Function')
            $script:AddOBSInput
        } else {
            $script:AddOBSInput
        }
    $IncludeParameter = @()
    $ExcludeParameter = 'inputKind','sceneName','inputName'


    $DynamicParameters = [Management.Automation.RuntimeDefinedParameterDictionary]::new()            
    :nextInputParameter foreach ($paramName in ([Management.Automation.CommandMetaData]$baseCommand).Parameters.Keys) {
        if ($ExcludeParameter) {
            foreach ($exclude in $ExcludeParameter) {
                if ($paramName -like $exclude) { continue nextInputParameter}
            }
        }
        if ($IncludeParameter) {
            $shouldInclude = 
                foreach ($include in $IncludeParameter) {
                    if ($paramName -like $include) { $true;break}
                }
            if (-not $shouldInclude) { continue nextInputParameter }
        }
        
        $DynamicParameters.Add($paramName, [Management.Automation.RuntimeDefinedParameter]::new(
            $baseCommand.Parameters[$paramName].Name,
            $baseCommand.Parameters[$paramName].ParameterType,
            $baseCommand.Parameters[$paramName].Attributes
        ))
    }
    $DynamicParameters

    }
        begin {
        # Browser Sources are built into OBS.  Their input kind is browser_source.
        # Sound Cloud Sources are really Browser Sources.
        $inputKind = "browser_source"
    
    }
        process {        
        # Copy the bound parameters
        $myParameters = [Ordered]@{} + $PSBoundParameters
        # and determine the name of the invocation
        $MyInvocationName  = "$($MyInvocation.InvocationName)"
        # Split it into verb and noun
        $myVerb, $myNoun   = $MyInvocationName -split '-'        
        # and get a copy of ourself that we can call with anonymous recursion.
        $myScriptBlock     = $MyInvocation.MyCommand.ScriptBlock
        # Determine if the verb was get,
        $IsGet             = $myVerb -eq "Get"
        # if no verb was used,
        $NoVerb            = $MyInvocationName -match '^[^\.\&][^-]+$'
        # and if there were any other parameters then name
        $NonNameParameters = @($PSBoundParameters.Keys) -ne 'Name'


        if (-not $uri.DnsSafeHost -or $uri.DnsSafeHost -notmatch 'SoundCloud\.com$') {
            Write-Error "URI must be from SoundCloud.com"
            return
        }

        if ($uri.Query) {
            $uri = "https://$($uri.DnsSafeHost)" + $($uri.Segments -join '')
        }

        # If it is a get or there was no verb
        if ($IsGet -or $NoVerb) {
            $inputsOfKind = # Get all inputs of this kind
                Get-OBSInput -InputKind $InputKind |
                    Where-Object {
                        if ($Name) { # If -Name was provided, 
                            $_.InputName -like $Name # filter by name (as a wildcard).
                        } else {
                            $_ #  otherwise, return every input.
                        }
                    } |
                    Where-Object {
                        $_.Settings['LocalFile'] -like '*.SoundCloud.*'
                    }
            
            # If there were parameters other than name, 
            # and we were not explicitly called Get-*
            if ($NonNameParameters -and -not $IsGet) {
                # remove the name parameter
                if ($myParameters.Name) { $myParameters.Remove('Name') }
                # and pipe results back to ourself.
                $inputsOfKind | & $myScriptBlock @myParameters
            } else {
                # Otherwise, we're just getting the list of inputs                
                $inputsOfKind
            }
            # (either way, if we were called Get- or with no verb, we're done now).
            return
        }

        if ((-not $width) -or (-not $height)) {
            if (-not $script:CachedOBSVideoSettings) {
                $script:CachedOBSVideoSettings = Get-OBSVideoSettings
            }
            $videoSettings = $script:CachedOBSVideoSettings
            
            $myParameters["Width"]  = $width = $videoSettings.outputWidth
            $myParameters["Height"] = $height = $videoSettings.outputHeight
        }

        if (-not $myParameters["Scene"]) {
            $myParameters["Scene"] = Get-OBSCurrentProgramScene | 
                Select-Object -ExpandProperty currentProgramSceneName
        }
                
        $myParameterData = [Ordered]@{}
        foreach ($parameter in $MyInvocation.MyCommand.Parameters.Values) {

            $bindToPropertyName = $null
            
            foreach ($attribute in $parameter.Attributes) {
                if ($attribute -is [ComponentModel.DefaultBindingPropertyAttribute]) {
                    $bindToPropertyName = $attribute.Name
                    break
                }
            }

            if (-not $bindToPropertyName) { continue }
            if ($myParameters.Contains($parameter.Name)) {
                $myParameterData[$bindToPropertyName] = $myParameters[$parameter.Name]
                if ($myParameters[$parameter.Name] -is [switch]) {
                    $myParameterData[$bindToPropertyName] = $myParameters[$parameter.Name] -as [bool]
                }
            }
        }

        if ($fps -and $fps -ne 30) {
            $myParameterData["custom_fps"] = $true            
        }

        $MyObsPowerShellPath = if ($home) {
            Join-Path $home ".obs-powershell"
        }

        $ThisSoundCloudSourceFileName = 
            if ($name) {
                "${name}.SoundCloudSource.html"
            } else {
                "SoundCloudSource.html"
            }

        $ThisSoundCloudSourceFilePath = Join-Path $MyObsPowerShellPath $ThisSoundCloudSourceFileName
        

        $soundCloudSrc = @(
            "https://w.soundcloud.com/player/?url="
            $Uri
            "&amp;"
            @(
                if ($PSBoundParameters["TrackNumber"]) {"start_track=$trackNumber"}
                if ($color) { "color=$color" -replace "\#",'%23'}                
                if ($NoAutoPlay) { "auto_play=false" } else { "auto_play=true"}
                if ($NoArtwork) { "show_artwork=false" } else {"show_artwork=true" }
                if ($NoUploaderInfo) { "show_user=false" } else {"show_user=true"}
                if ($NoPlayCount) { "show_playcount=false" } else {"show_playcount=true" }
                if ($ShowDownload) { "download=true"} else { "download=false" }
                if ($ShowBuy) { "buying=true"} else { "buying=false" }
                if ($ShowShare) { "sharing=true"} else { "sharing=false" }
            ) -join '&amp;'
        ) -join ''
        
        $soundCloudWidget = @(
            "<html><head><script src='https://w.soundcloud.com/player/api.js'></script></head>"
            "<body>"
                "<iframe width='100%' height='166' scrolling='no' frameborder='no' allow='autoplay' src='$soundCloudSrc'>
                </iframe>"
            "</body>"
            "</html>"
        ) -join ' '

        $newHtmlFile = New-Item -Value $soundCloudWidget -ItemType File -Path $ThisSoundCloudSourceFilePath -Force
        
        $myParameterData["local_file"] = ([uri]$newHtmlFile.FullName) -replace '[\\/]', '/' -replace '^file:///'
        $myParameterData["is_local_file"] = $true    

        if (-not $Name) {
            $Name = $myParameters['Name'] = 'SoundCloud'
        }        

        $addSplat = [Ordered]@{
            sceneName = $myParameters["Scene"]
            inputKind = $inputKind
            inputSettings = $myParameterData
            inputName = $Name
            NoResponse = $myParameters["NoResponse"]
        }
        # If -SceneItemEnabled was passed,
        if ($myParameters.Contains('SceneItemEnabled')) {
            # propagate it to Add-OBSInput.
            $addSplat.SceneItemEnabled = $myParameters['SceneItemEnabled'] -as [bool]
        }

        # If -PassThru was passed
        if ($MyParameters["PassThru"]) {
            # pass it down to each command
            $addSplat.Passthru = $MyParameters["PassThru"]
            # If we were called with Add-
            if ($MyInvocation.InvocationName -like 'Add-*') {
                Add-OBSInput @addSplat # passthru Add-OBSInput
            } else {
                # Otherwise, remove SceneItemEnabled, InputKind, and SceneName
                $addSplat.Remove('SceneItemEnabled')
                $addSplat.Remove('inputKind')
                $addSplat.Remove('sceneName')
                # and passthru Set-OBSInputSettings.
                Set-OBSInputSettings @addSplat
            }
            return
        }
        
        # Add the input.
        $outputAddedResult = Add-OBSInput @addSplat *>&1

        # If we got back an error
        if ($outputAddedResult -is [Management.Automation.ErrorRecord]) {
            # and that error was saying the source already exists, 
            if ($outputAddedResult.TargetObject.d.requestStatus.code -eq 601) {
                # then check if we use the -Force.
                if ($Force)  { # If we do, remove the input                    
                    Remove-OBSInput -InputName $addSplat.inputName
                    # and re-add our result.
                    $outputAddedResult = Add-OBSInput @addSplat *>&1
                } else {
                    # Otherwise, get the input from the scene,
                    $sceneItem = Get-OBSSceneItem -sceneName $myParameters["Scene"] |
                        Where-Object SourceName -eq $myParameters["Name"]
                    # update the input settings
                    $sceneItem.Input.Settings = $addSplat.inputSettings
                    $sceneItem # and return the scene item.
                    $outputAddedResult = $null
                }
            }

            # If the output was still an error
            if ($outputAddedResult -is [Management.Automation.ErrorRecord]) {
                # use $psCmdlet.WriteError so that it shows the error correctly.
                $psCmdlet.WriteError($outputAddedResult)
            }            
        }
        # Otherwise, if we had a result
        if ($outputAddedResult -and 
            $outputAddedResult -isnot [Management.Automation.ErrorRecord]) {
            # get the input from the scene.
            Get-OBSSceneItem -sceneName $myParameters["Scene"] |
                Where-Object SourceName -eq $myParameters["Name"]
        }
    
    }
}
