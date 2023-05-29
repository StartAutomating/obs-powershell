function Set-OBSBrowserSource {
    <#
    
    .SYNOPSIS    
        Sets a browser source    
    .DESCRIPTION    
        Adds or changes a browser source in OBS.    
    .EXAMPLE    
        Set-OBSBrowserSource -Uri https://pssvg.start-automating.com/Examples/Stars.svg    
    
    #>
            
    [Alias('Add-OBSBrowserSource')]    
    [CmdletBinding()]
    param(
    # The uri or file path to display.    
    # If the uri points to a local file, this will be preferred    
    [Parameter(ValueFromPipelineByPropertyName)]    
    [Alias('Url', 'Href','Path','FilePath','FullName')]
    [uri]
    $Uri,
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
    [string]
    $Scene,
    # The name of the input.    
    # If no name is provided, the last segment of the URI or file path will be the input name.    
    [Parameter(ValueFromPipelineByPropertyName)]
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
        process {
        $myParameters = [Ordered]@{} + $PSBoundParameters
        
        if ((-not $width) -or (-not $height)) {
            if (-not $script:CachedOBSVideoSettings) {
                $script:CachedOBSVideoSettings = Get-OBSVideoSettings
            }
            $videoSettings = $script:CachedOBSVideoSettings
            $myParameters["Width"]  = $width = $videoSettings.outputWidth
            $myParameters["Height"] = $height = $videoSettings.outputHeight
        }
        if (-not $myParameters["Scene"]) {
            $myParameters["Scene"] = Get-OBSCurrentProgramScene
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
                    $myParameterData[$bindToPropertyName] = $parameter.Name -as [bool]
                }
            }
        }
        if ($fps -and $fps -ne 30) {
            $myParameterData["custom_fps"] = $true            
        }
        if ($uri.Scheme -eq 'File') {
            if (Test-Path $uri.AbsolutePath) {
                $myParameterData["local_file"] = "$uri" -replace '[\\/]', '/' -replace '^file:///'
                $myParameterData["is_local_file"] = $true
            }
        }
        else
        {
            if (Test-Path $uri) {
                $rp = $ExecutionContext.SessionState.Path.GetResolvedPSPathFromPSPath($uri)
                $myParameterData["local_file"] = "$rp" -replace '[\\/]', '/' -replace '^file:///'
                $myParameterData["is_local_file"] = $true
            } else {
                $myParameterData["url"] = "$uri"
            }            
        }
 
        if (-not $Name) {
            $Name = $myParameters['Name'] =
                if ($uri.Segments) {
                    $uri.Segments[-1]
                } elseif ($uri -match '[\\/]') {
                    @($uri -split '[\\/]')[-1]
                } else {
                    $uri
                }
        }        
        $addSplat = [Ordered]@{
            sceneName = $myParameters["Scene"]
            inputKind = "browser_source"
            inputSettings = $myParameterData
            inputName = $Name
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
        elseif ($outputAddedResult) {
            # get the input from the scene.
            Get-OBSSceneItem -sceneName $myParameters["Scene"] |
                Where-Object SourceName -eq $myParameters["Name"]
        }
    
    }
}
