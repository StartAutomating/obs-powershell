function Set-OBSAudioOutputSource {
    <#
    
    .SYNOPSIS    
        Adds or sets an audio output source    
    .DESCRIPTION    
        Adds or sets an audio output source in OBS.  This captures the audio that is being sent to an output device.    
    .EXAMPLE    
        Add-OBSAudioOutputSource     
    .EXAMPLE    
        Set-OBSAudioOutputSource -AudioDevice Speakers    
    .NOTES    
        This command currently only supports capturing default audio on Windows.    
        To add support for other operating systems, file an issue or open a pull request.    
    
    #>
            
    #>    
    [Alias('Add-OBSAudioOutputSource','Get-OBSAudioOutputSource')]
    param(
    # The name of the audio device.    
    # This name or device ID of the audio device that should be captured.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('ItemValue','ItemName','DeviceID')]
    [string]
    $AudioDevice,

    # The name of the scene.    
    # If no scene name is provided, the current program scene will be used.    
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('SceneName')]
    [string]
    $Scene,

    # The name of the input.    
    # If no name is provided, "AudioOutput$($AudioDevice)" will be the input source name.    
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
        # Audio Output sources have an inputKind of 'wasapi_output_capture'.
        $inputKind = "wasapi_output_capture"
    
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

        
        if (-not $myParameters["AudioDevice"]) {
            $myParameters["AudioDevice"] = "default"
        }

        # Window capture is a bit of a tricky one.
        # In order to get the WindowTitle to match that OBS needs, we need to look thru the input properties list.
        # and for that, an input needs to exist.
        if (-not $myParameters["Name"]) {

            
            if ($myParameters["AudioDevice"]) {
                $Name = $myParameters["Name"] = "AudioOutput-" + $myParameters["AudioDevice"]
            }
            else {
                $Name = $myParameters["Name"] = "AudioOutput"
            }
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

        $addSplat = @{
            sceneName = $myParameters["Scene"]
            inputName = $myParameters["Name"]
            inputKind = $inputKind
            inputSettings = $myParameterData
            NoResponse = $myParameters["NoResponse"]
        }        

        # If -SceneItemEnabled was passed,
        if ($myParameters.Contains('SceneItemEnabled')) {
            # propagate it to Add-OBSInput.
            $addSplat.SceneItemEnabled = $myParameters['SceneItemEnabled'] -as [bool]
        }
        
        # Add the input.
        $outputAddedResult = Add-OBSInput @addSplat *>&1        
        $possibleDevices = Get-OBSInputPropertiesListPropertyItems -InputName $addSplat.inputName -PropertyName device_id
        foreach ($deviceInfo in $possibleDevices) {
            if (
                ($deviceInfo.itemName -eq $AudioDevice) -or
                ($deviceInfo.ItemValue -eq $AudioDevice) -or
                ($deviceInfo.ItemName -replace '\[[^\[\]]+\]\:\s' -eq $AudioDevice) -or
                ($deviceInfo.ItemValue -like "*$AudioDevice*") -or
                ($deviceInfo.ItemName -like "*$AudioDevice*")
            ) {
                $myParameterData["device_id"] = $deviceInfo.itemValue
                break
            }
        }

        # If -PassThru was passed
        if ($MyParameters["PassThru"]) {
            # pass it down to each command            
            # Otherwise, remove SceneItemEnabled, InputKind, and SceneName
            $addSplat.PassThru = $true
            $addSplat.Remove('SceneItemEnabled')
            $addSplat.Remove('inputKind')
            $addSplat.Remove('sceneName')
            # and passthru Set-OBSInputSettings.
            Set-OBSInputSettings @addSplat
            
            return
        }

        if ($Force)  { # If we do, remove the input                    
            Remove-OBSInput -InputName $addSplat.inputName
            # and re-add our result.
            $outputAddedResult = Add-OBSInput @addSplat *>&1
            # If the output was still an error
            if ($outputAddedResult -is [Management.Automation.ErrorRecord]) {
                # use $psCmdlet.WriteError so that it shows the error correctly.
                $psCmdlet.WriteError($outputAddedResult)
            }
            # Otherwise, if we had a result
            elseif ($outputAddedResult) {
                # get the input from the scene.
                Get-OBSSceneItem -sceneName $myParameters["Scene"] |
                    Where-Object SourceName -eq $myParameters["Scene"]
            }
        } else {
            # Otherwise, get the input from the scene,
            $sceneItem = Get-OBSSceneItem -sceneName $myParameters["Scene"] |
                Where-Object SourceName -eq $myParameters["Name"]
            # update the input settings
            $sceneItem.Input.Settings = $addSplat.inputSettings
            $sceneItem # and return the scene item.
        }
    
    }
}
