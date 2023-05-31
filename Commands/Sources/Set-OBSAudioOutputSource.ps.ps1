function Set-OBSAudioOutputSource
{
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
    [inherit("Add-OBSInput", Dynamic, Abstract, ExcludeParameter='inputKind','sceneName','inputName')]
    [Alias('Add-OBSAudioOutputSource')]
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
    [Alias('InputName')]
    [string]
    $Name,

    # If set, will check if the source exists in the scene before creating it and removing any existing sources found.
    # If not set, you will get an error if a source with the same name exists.
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $Force
    )
    
    process {
        $myParameters = [Ordered]@{} + $PSBoundParameters
        
        if (-not $myParameters["Scene"]) {
            $myParameters["Scene"] = Get-OBSCurrentProgramScene
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
            inputKind = "wasapi_output_capture"
            inputSettings = $myParameterData
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