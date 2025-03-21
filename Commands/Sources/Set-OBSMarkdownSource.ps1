function Set-OBSMarkdownSource {
    <#
    
    .SYNOPSIS    
        Sets a markdown source    
    .DESCRIPTION    
        Adds or changes a markdown source in OBS.        
    
    #>
            
    [Alias('Add-OBSMarkdownSource','Get-OBSMarkdownSource')]
    param(
    # The markdown text, or the path to a markdown file        
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $Markdown,

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

    # The css style used to render the markdown.     
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("css")]
    [string]
    $CSS = "body { background-color: rgba(0, 0, 0, 0); margin: 0px auto; overflow: hidden; }",

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
        begin {
        $inputKind = "markdown_source"
    
    }
        process {
        $myParameters = [Ordered]@{} + $PSBoundParameters

        $IsGet             = $MyInvocation.InvocationName -like "Get-*"
        $NoVerb            = $MyInvocation.InvocationName -match '^[^-]+$'
        $NonNameParameters = @($PSBoundParameters.Keys) -ne 'Name'

        if (
            $IsGet -or 
            ($NoVerb -and -not $NonNameParameters)
        ) {
            Get-OBSInput -InputKind $InputKind |
                Where-Object {
                    if ($Name) {
                        $_.InputName -like $Name
                    } else {
                        $_
                    }
                }
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

        $markdownAsUri = $null
        if ($Markdown -like '*.md') {
            $markdownAsUri = $markdown -as [uri]
            if ($markdownAsUri.Scheme -eq 'File') {
                $myParameterData["markdown_path"] = "$markdownAsUri" -replace '[\\/]', '/' -replace '^file:///'
                $myParameterData["markdown_source"] = 1
            }
            else {

            }
        } else {
            $myParameterData["text"] = $Markdown
            $myParameterData["markdown_source"] = 0
        }
        
        if (-not $Name) {
            $Name = $myParameters['Name'] =
                if ($markdownAsUri.Segments) {
                    $markdownAsUri.Segments[-1]
                } elseif ($markdownAsUri -match '[\\/]') {
                    @($markdownAsUri -split '[\\/]')[-1]
                } elseif ($markdownAsUri) {
                    $markdownAsUri
                } else {
                    "Markdown"
                }
        }            

        $addSplat = [Ordered]@{
            sceneName = $myParameters["Scene"]
            inputKind = "markdown_source"
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
