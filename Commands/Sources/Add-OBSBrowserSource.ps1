function Add-OBSBrowserSource {
    <#
    
    .SYNOPSIS    
        Adds a browser source    
    .DESCRIPTION    
        Adds a browser source to OBS.    
    .EXAMPLE    
        Add-OBSBrowserSource    
    
    #>
            
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
            $Name =
                if ($uri.Segments) {
                    $uri.Segments[-1]
                } elseif ($uri -match '[\\/]') {
                    @($uri -split '[\\/]')[-1]
                } else {
                    $uri
                }
        }
        # If -Force is provided
        if ($Force) {
            # Clear any items from that scene
            Get-OBSSceneItem -sceneName $myParameters["Scene"] |
                Where-Object SourceName -eq $name |
                Remove-OBSInput -InputName { $_.SourceName }
        }
        $addObsInputParams = [Ordered]@{
            sceneName = $myParameters["Scene"]
            inputKind = "browser_source"
            inputSettings = $myParameterData
            inputName = $Name
        }
        # If -SceneItemEnabled was passed,
        if ($myParameters.Contains('SceneItemEnabled')) {
            # propagate it to Add-OBSInput.
            $addObsInputParams.SceneItemEnabled = $myParameters['SceneItemEnabled'] -as [bool]
        }
        
        $outputAddedResult = 
            Add-OBSInput @addObsInputParams
        if ($outputAddedResult) {
            Get-OBSSceneItem -sceneName $myParameters["Scene"] |
                Where-Object SourceName -eq $name
        }
    
    }
}
