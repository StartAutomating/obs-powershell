function Set-OBSColorSource {
    <#
    
    .SYNOPSIS    
        Adds a color source    
    .DESCRIPTION    
        Adds a color source to OBS.  This displays a single 32-bit color (RGBA).    
    .LINK    
        Add-OBSInput    
    .LINK    
        Set-OBSInputSettings    
    
    #>
            
    [Alias('Add-OBSColorSource')]
    param(
    # The name of the scene.    
    # If no scene name is provided, the current program scene will be used.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('SceneName')]
    [string]
    $Scene,
    # The name of the input.    
    # If no name is provided, "Display $($Monitor + 1)" will be the input source name.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('InputName')]
    [string]
    $Name,
    [ValidatePattern('\#(?>[0-9a-f]{8}|[0-9a-f]{6}|[0-9a-f]{4}|[0-9a-f]{3})')]
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $Color,
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
        
        if (-not $myParameters["Scene"]) {
            $myParameters["Scene"] = Get-OBSCurrentProgramScene
        }
        $hexChar = [Regex]::new('[0-9a-f]')
        $hexColors = @($hexChar.Matches($Color))
        switch ($hexColors.Length) {
            8 {
                #full rgba
                $alpha = [byte]::Parse($hexColors[0..1] -join '', 'HexNumber')
                $red   = [byte]::Parse($hexColors[2..3] -join '', 'HexNumber')
                $green = [byte]::Parse($hexColors[4..5] -join '', 'HexNumber')
                $blue  = [byte]::Parse($hexColors[6..7] -join '', 'HexNumber')
            }
            6 {
                #rgb only, assume ff for alpha
                $alpha = 0xff
                $red   = [byte]::Parse($hexColors[0..1] -join '', 'HexNumber')
                $green = [byte]::Parse($hexColors[2..3] -join '', 'HexNumber')
                $blue  = [byte]::Parse($hexColors[4..5] -join '', 'HexNumber')
            }
            4 {
                #short rgba                
                $alpha = [byte]::Parse(($hexColors[0],$hexColors[0] -join ''), 'HexNumber')
                $red   = [byte]::Parse(($hexColors[1],$hexColors[1] -join ''), 'HexNumber')
                $green = [byte]::Parse(($hexColors[2],$hexColors[2] -join ''), 'HexNumber')
                $blue  = [byte]::Parse(($hexColors[3],$hexColors[3] -join ''), 'HexNumber')
            }
            3 {
                #short rgb, assume f for alpha
                $alpha = 0xff
                $red   = [byte]::Parse(($hexColors[0],$hexColors[0] -join ''), 'HexNumber')
                $green = [byte]::Parse(($hexColors[1],$hexColors[1] -join ''), 'HexNumber')
                $blue  = [byte]::Parse(($hexColors[2],$hexColors[2] -join ''), 'HexNumber')
            }
            0 {
                # No color provided, default to transparent black
                $alpha = 0
                $red   = 0
                $green = 0 
                $blue  = 0
            }
        }
        
        $hexColor = ("{0:x2}{1:x2}{2:x2}{3:x2}" -f $alpha, $blue, $green, $red)
        $realColor = [uint32]::Parse($hexColor,'HexNumber')
        
                
        if (-not $myParameters["Name"]) {
            $myParameters["Name"] = "#$hexColor"
        }
        
        $myParameterData = [Ordered]@{color=$realColor}
        $addSplat = @{
            sceneName = $myParameters["Scene"]
            inputName = $myParameters["Name"]
            inputKind = "color_source_v3"
            inputSettings = $myParameterData
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

