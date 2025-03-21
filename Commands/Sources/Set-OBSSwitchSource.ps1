function Set-OBSSwitchSource {
    <#
    
    .SYNOPSIS    
        Adds a VLC playlist source    
    .DESCRIPTION    
        Adds or sets VLC playlist sources to OBS.    
        VLC must be installed for this to work.    
    .EXAMPLE    
        Set-OBSVLCSource -FilePath .\*.mp3 # Creates a playlist of all MP3s in the current directory    
    .LINK    
        Add-OBSInput    
    .LINK    
        Set-OBSInputSettings    
    
    #>
            
    [Alias('Add-OBSSwitchSource','Get-OBSSwitchSource')]
    param(
    # The path to the media file.    
    [Parameter(ValueFromPipelineByPropertyName)]    
    [Alias('Sources')]
    [string[]]
    $SourceList,

    # What to select in the playlist.    
    # If a number is provided, this will select an index.    
    # If a string is provided, this will select the whole name or last part of a name, accepting wildcards.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateScript({
    $validTypeList = [System.Int32],[System.String]
    
    $thisType = $_.GetType()
    $IsTypeOk =
        $(@( foreach ($validType in $validTypeList) {
            if ($_ -as $validType) {
                $true;break
            }
        }))
    
    if (-not $isTypeOk) {
        throw "Unexpected type '$(@($thisType)[0])'.  Must be 'int','string'."
    }
    return $true
    })]
    
    [Alias('SelectIndex','SelectName')]
    $Select,

    # If set, the list of sources will loop.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("loop")]
    [Alias('Looping')]
    [switch]
    $Loop,

    # If set, will switch between sources.    
    # Sources will be displayed for a -Duration.    
    # No source wil be displayed for an -Interval.        
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("time_switch")]
    [switch]
    $TimeSwitch,

    # The interval between sources    
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("time_switch_between")]
    [timespan]
    $Interval,

    # The duration between sources that are switching at a time.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("time_switch_duration")]
    [timespan]
    $Duration,

    # The item that will be switched in a TimeSwitch, after -Duration and -Interval.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateSet("None","Next","Previous","First","Last","Random")]
    [string]
    $TimeSwitchTo = "Next",

    # If set, will switch on the underlying source's media state events.    
    # Sources will be displayed for a -Duration.    
    # No source wil be displayed for an -Interval.        
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("media_state_switch")]
    [switch]
    $MediaStateSwitch,

    # The change in media state that should trigger a switch    
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateSet("Playing","Opening","Buffering","Paused","Stopped","Ended", "Error","Playing","NotOpening","NotBuffering","NotPaused","NotStopped","NotEnded", "NotError")]
    $MediaStateChange,

    # When the source switcher is trigger by media end, this determines the next source that will be switched to.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateSet("None","Next","Previous","First","Last","Random")]
    [string]
    $MediaSwitchTo = "Next",

    # The name of the transition between sources.    
    [ArgumentCompleter({
        param ( $commandName,
            $parameterName,
            $wordToComplete,
            $commandAst,
            $fakeBoundParameters )
        if (-not $script:OBSTransitionKinds) {
            $script:OBSTransitionKinds = @(Get-OBSTransitionKind) -replace '_transition$' 
        }
        
        if ($wordToComplete) {        
            $toComplete = $wordToComplete -replace "^'" -replace "'$"
            return @($script:OBSTransitionKinds -like "$toComplete*" -replace '^', "'" -replace '$',"'")
        } else {
            return @($script:OBSTransitionKinds -replace '^', "'" -replace '$',"'")
        }
    })]
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $TransitionName,

    # The properties sent to the transition.    
    # Notice: this current requires confirmation in the UI.     
    [Parameter(ValueFromPipelineByPropertyName)]
    [PSObject]
    $TransitionProperty,

    # The name of the transition used to show a source.    
    [ArgumentCompleter({
        param ( $commandName,
            $parameterName,
            $wordToComplete,
            $commandAst,
            $fakeBoundParameters )
        if (-not $script:OBSTransitionKinds) {
            $script:OBSTransitionKinds = @(Get-OBSTransitionKind) -replace '_transition$' 
        }
        
        if ($wordToComplete) {        
            $toComplete = $wordToComplete -replace "^'" -replace "'$"
            return @($script:OBSTransitionKinds -like "$toComplete*" -replace '^', "'" -replace '$',"'")
        } else {
            return @($script:OBSTransitionKinds -replace '^', "'" -replace '$',"'")
        }
    })]
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $ShowTransition,

    # The properties sent to the show transition.    
    # Notice: this current requires confirmation in the UI.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [PSObject]
    $ShowTransitionProperty,

    # The transition used to hide a source.    
    [ArgumentCompleter({
        param ( $commandName,
            $parameterName,
            $wordToComplete,
            $commandAst,
            $fakeBoundParameters )
        if (-not $script:OBSTransitionKinds) {
            $script:OBSTransitionKinds = @(Get-OBSTransitionKind) -replace '_transition$' 
        }
        
        if ($wordToComplete) {        
            $toComplete = $wordToComplete -replace "^'" -replace "'$"
            return @($script:OBSTransitionKinds -like "$toComplete*" -replace '^', "'" -replace '$',"'")
        } else {
            return @($script:OBSTransitionKinds -replace '^', "'" -replace '$',"'")
        }
    })]
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $HideTransition,

    # The properties sent to the hide transition.    
    # Notice: this current requires confirmation in the UI.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [PSObject]
    $HideTransitionProperty,

    # The name of the scene.    
    # If no scene name is provided, the current program scene will be used.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $Scene,

    # The name of the input.    
    # If no name is provided, the last segment of the URI or file path will be the input name.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('InputName','SourceName')]
    [string]
    $Name,

    # If set, will check if the source exists in the scene before creating it and removing any existing sources found.    
    # If not set, you will get an error if a source with the same name exists.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $Force,

    # If set, will fit the input to the screen.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $FitToScreen
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
        filter OutputAndFitToScreen {
        
                    if ($FitToScreen -and $_.FitToScreen) {
                        $_.FitToScreen()
                    }
                    $_
                
        }
        $InputKind = "source_switcher"
    
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
                if ($myParameters[$parameter.Name] -is [timespan]) {
                    $myParameterData[$bindToPropertyName] = [int]$myParameters[$parameter.Name].TotalMilliseconds
                }
            }
        }
        
        
        $selectedIndex = -1
        $sourcesObject = @(
            $currentIndex = -1
            foreach ($sourceName in $SourceList) {
                $currentIndex++
                $selected = ($null -ne $Select) -and (
                    ($select -is [int] -and $currentIndex -eq $select) -or
                    ($select -is [string] -and
                        ($sourceName -like $select -or ($sourceName | Split-Path -Leaf -ErrorAction Ignore) -like $Select)
                    )
                )
                if ($selected) {
                    $selectedIndex = $currentIndex
                }
                [PSCustomObject][Ordered]@{hidden=$false;selected=$selected;value=$sourceName}
            }
        )

        if ($sourcesObject) {
            $myParameterData['sources'] = $sourcesObject
            if ($selectedIndex -gt 0) {
                $myParameterData["current_index"] = $selectedIndex
            }
        }
        elseif ($Select -is [int]) {
            $myParameterData['current_index'] = $Select
        }
        

        
        if ($TransitionName) {
            if ($TransitionName -notlike '*_transition') {
                $TransitionName = "${TransitionName}_transition"
            }
            $myParameterData["transition"] = $TransitionName
        }
        
        if ($TransitionProperty) {
            $myParameterData["transition_properties"] = $TransitionProperty
        }

        if ($ShowTransition) {
            if ($ShowTransition -notlike '*_transition') {
                $ShowTransition = "${ShowTransition}_transition"
            }
            $myParameterData["show_transition"] = $ShowTransition
        }

        if ($ShowTransitionProperty) {
            $myParameterData["show_transition_properties"] = $ShowTransitionProperty
        }

        if ($HideTransition) {
            if ($HideTransition -notlike '*_transition') {
                $HideTransition = "${HideTransition}_transition"
            }
            $myParameterData["hide_transition"] = $ShowTransition
        }

        if ($HideTransitionProperty) {
            $myParameterData["hide_transition_properties"] = $HideTransitionProperty
        }    

        if ($TimeSwitchTo) {
            $validValues = $MyInvocation.MyCommand.Parameters["TimeSwitchTo"].Attributes.ValidValues
            for ($vvi = 0; $vvi -lt $validValues.Length;$vvi++) {
                if ($TimeSwitchTo -eq $validValues[$vvi]) {
                    $myParameterData["time_switch_to"] = $vvi
                    break
                }
            }            
        }

        if ($MediaSwitchTo) {
            $validValues = $MyInvocation.MyCommand.Parameters["MediaSwitchTo"].Attributes.ValidValues
            for ($vvi = 0; $vvi -lt $validValues.Length;$vvi++) {
                if ($TimeSwitchTo -eq $validValues[$vvi]) {
                    $myParameterData["media_state_switch_to"] = $vvi
                    break
                }
            }
        }

        if ($MediaStateChange) {
            $validValues = $MyInvocation.MyCommand.Parameters["MediaStateChange"].Attributes.ValidValues
            for ($vvi = 0; $vvi -lt $validValues.Length;$vvi++) {
                if ($TimeSwitchTo -eq $validValues[$vvi]) {
                    $myParameterData["media_switch_state"] = $vvi
                    break
                }
            }
        }
 
        if (-not $Name) {
            $Name = $myParameters["Name"] = "Source Switcher"
        }

        

        $addSplat = [Ordered]@{
            sceneName = $myParameters["Scene"]
            inputKind = $InputKind
            inputSettings = $myParameterData
            inputName = $Name
            NoResponse = $myParameters["NoResponse"]
        }

        if ($myParameters.Contains('SceneItemEnabled')) {
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
                    if ($sceneItem) {
                        $sceneItem.Input.Settings = $addSplat.inputSettings
                        $sceneItem # and return the scene item.
                        $outputAddedResult = $null
                    }                    
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
            # get the input from the scene and optionally fit it to the screen.
            Get-OBSSceneItem -sceneName $myParameters["Scene"] |
                Where-Object SourceName -eq $name |
                OutputAndFitToScreen
        }
    
    }
}
