function Set-OBSMediaSource
{
    <#
    .SYNOPSIS
        Adds a media source
    .DESCRIPTION
        Adds a media source to OBS.
    .EXAMPLE
        Set-OBSMediaSource -FilePath My.mp4
    .LINK
        Add-OBSInput
    .LINK
        Set-OBSInputSettings
    #>
    [inherit("Add-OBSInput", Dynamic, Abstract, ExcludeParameter='inputKind','sceneName','inputName')]
    [Alias('Add-OBSFFMpegSource','Add-OBSMediaSource','Set-OBSFFMpegSource')]
    param(
    # The path to the media file.
    [Parameter(Mandatory,ValueFromPipelineByPropertyName)]    
    [Alias('FullName','LocalFile','local_file')]
    [string]
    $FilePath,

    # If set, the source will close when it is inactive.
    # By default, this will be set to true.
    # To explicitly set it to false, use -CloseWhenInactive:$false
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("close_when_inactive")]
    [switch]
    $CloseWhenInactive,

    # If set, the source will automatically restart.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("looping")]
    [Alias('Looping')]
    [switch]
    $Loop,

    # If set, will use hardware decoding, if available.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("hw_decode")]
    [Alias('HardwareDecoding','hw_decode')]
    [switch]
    $UseHardwareDecoding,
        
    # If set, will clear the output on the end of the media.
    # If this is set to false, the media will freeze on the last frame.
    # This is set to true by default.
    # To explicitly set to false, use -ClearMediaEnd:$false
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("clear_on_media_end")]
    [Alias('ClearOnEnd','NoFreezeFrameOnEnd')]
    [switch]
    $ClearOnMediaEnd,

    # Any FFMpeg demuxer options.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("ffmpeg_options")]
    [Alias('FFMpegOptions', 'FFMpeg_Options')]
    [string]
    $FFMpegOption,

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
    $Force,

    # If set, will fit the input to the screen.
    [Parameter(ValueFromPipelineByPropertyName)]
    [switch]
    $FitToScreen
    )

    begin {
        filter OutputAndFitToScreen {
            if ($FitToScreen -and $_.FitToScreen) {
                $_.FitToScreen()
            }
            $_
        }
    }
    
    process {
        $myParameters = [Ordered]@{} + $PSBoundParameters
        
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

        if (-not (Test-Path $FilePath)) {
            return
        }

        $FilePathItem = Get-Item -Path $FilePath
        $myParameterData['local_file'] = $FilePathItem.FullName -replace '/', '\'

        if ($myParameters['InputSettings']) {
            $keys = 
                @(if ($myParameters['InputSettings'] -is [Collections.IDictionary]) {
                    $myParameters['InputSettings'].Keys
                } else {
                    foreach ($prop in $myParameters['InputSettings'].PSObject.Properties) {
                        $prop.Name
                    }
                })

            foreach ($key in $keys) {
                $myParameterData[$key] = $myParameters['InputSettings'].$key
            }

            $myParameterData.remove('inputSettings')
        }
 
        if (-not $Name) {
            $Name = $myParameters["Name"] = $FilePathItem.Name
        }

        $addSplat = [Ordered]@{
            sceneName = $myParameters["Scene"]
            inputKind = "ffmpeg_source"
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
        if ($outputAddedResult -isnot [Management.Automation.ErrorRecord]) {
            # get the input from the scene and optionally fit it to the screen.
            Get-OBSSceneItem -sceneName $myParameters["Scene"] |
                Where-Object SourceName -eq $name |
                OutputAndFitToScreen
        }
    }
}