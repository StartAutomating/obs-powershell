function Set-OBSWaveformSource
{
    <#
    .SYNOPSIS
        OBS Waveform Source
    .DESCRIPTION
        Gets, Sets, or Adds a waveform source in OBS.

        Waveform sources require the [Waveform Plugin](https://obsproject.com/forum/resources/waveform.1423/)
    .EXAMPLE
        Add-OBSWaveformSource -Name "SpeakerWaveform"
    #>
    [inherit(Command={
        Import-Module ..\..\obs-powershell.psd1 -Global
        "Add-OBSInput"
    }, Dynamic, Abstract, ExcludeParameter='inputKind','sceneName','inputName')]
    [Alias('Add-OBSWaveformSource','Get-OBSWaveformSource')]
    param(
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

    # The audio source for the waveform.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("audio_source")]
    [string]
    $AudioSource,

    # The display mode for the waveform.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("display_mode")]
    [ValidateSet("curve","bars","stepped_bars","level_meter","stepped_level_meter")]
    [string]
    $DisplayMode,

    # The render mode for the waveform.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("render_mode")]
    [ValidateSet("line","solid","gradient")]
    [string]
    $RenderMode,

    # The windowing mode for the waveform.
    # This is the mathematical function used to determine the current "window" of audio data.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("render_mode")]
    [ValidateSet("hann","hamming","blackman","blackman_harris","none")]
    [string]
    $WindowMode,

    # The color used for the waveform.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("color_base")]
    [PSObject]
    $Color,

    # The crest color used for the waveform.
    # This will be ignored if the render mode is not "gradient".
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("color_crest")]
    [PSObject]
    $CrestColor,

    # The channel mode for the waveform.
    # This can be either mono or stereo.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("channel_mode")]
    [ValidateSet("mono","stereo")]
    [string]
    $ChannelMode,

    # The number of pixels between each channel in stereo mode     
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("channel_spacing")]
    [int]
    $ChannelSpacing,

    # If set, will use a radial layout for the waveform
    # Radial layouts will ignore the desired height of the source and instead create a square.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("radial_layout")]
    [switch]
    $RadialLayout,

    # If set, will invert the direction for a radial waveform.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("invert_direction")]
    [switch]
    $InvertRadialDirection,

    # If set, will normalize the volume displayed in the waveform.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("normalize_volume")]
    [switch]
    $NoramlizeVolume,

    # If set, will automatically declare an FFTSize
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("auto_fft_size")]    
    [switch]
    $AutoFftSize,

    # If set, will attempt to make audio peaks render faster.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("fast_peaks")]    
    [switch]
    $FastPeak,

    # The width of the waveform bar.
    # This is only valid when -DisplayMode is 'bars' or 'stepped_bars'
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("bar_width")]
    [int]
    $BarWidth,

    # The gap between waveform bars.
    # This is only valid when -DisplayMode is 'bars' or 'stepped_bars'
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("bar_gap")]
    [int]
    $BarGap,

    # The width of waveform bar step.
    # This is only valid when -DisplayMode is 'stepped_bars'
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("step_width")]
    [int]
    $StepWidth,

    # The gap between waveform bar steps.
    # This is only valid when -DisplayMode is 'stepped_bars'
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("step_gap")]
    [int]
    $StepGap,

    # The low-frequency cutoff of the waveform.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("cutoff_low")]
    [int]
    $LowCutoff,

    # The high-frequency cutoff of the waveform.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("cutoff_high")]
    [int]
    $HighCutoff,

    # The floor of the waveform.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("floor")]
    [int]
    $Floor,

    # The ceiling of the waveform.
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("ceiling")]
    [int]
    $Ceiling,

    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("slope")]
    [double]
    $Slope,

    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("rolloff_q")]
    [Alias('RollOffOctaves')]
    [double]
    $RollOffOctave,

    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("rolloff_rate")]    
    [double]
    $RollOffRate,

    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("grad_ratio")]    
    [double]
    $GradientRatio,
    
    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("deadzone")]
    [double]
    $Deadzone,

    [Parameter(ValueFromPipelineByPropertyName)]
    [ComponentModel.DefaultBindingProperty("temporal_smoothing")]
    [ValidateSet("none","exp_moving_avg")]
    [string]
    $TemporalSmoothing,
    

    # The name of the scene.
    # If no scene name is provided, the current program scene will be used.
    [Parameter(ValueFromPipelineByPropertyName)]
    [Alias('SceneName')]
    [string]
    $Scene,

    # The name of the input.
    # If no name is provided, the last segment of the URI or file path will be the input name.
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
    
    begin {
        $inputKind = "phandasm_waveform_source"
        filter ToOBSColor {
            if ($_ -is [uint32]) { $_ }
            elseif ($_ -is [string]) {
                if ($_ -match '^\#[a-f0-9]{3,4}$') {
                    $_ = $_ -replace '[a-f0-9]','$0$0'
                }

                if ($_ -match '^#[a-f0-9]{8}$') {
                    (
                        '0x' + 
                            (($_ -replace '#').ToCharArray()[0,1,-1,-2,-3,-4,-5,-6] -join '')
                    ) -as [UInt32]
                }
                elseif ($_ -match '^#[a-f0-9]{6}$') {
                    
                    (
                        '0xff' + 
                            (($_ -replace '#').ToCharArray()[-1..-6] -join '')
                    ) -as [UInt32]
                }
            }
        }
    }
    process {
        $myParameters = [Ordered]@{} + $PSBoundParameters

        $MyInvocationName  = "$($MyInvocation.InvocationName)"
        $myVerb, $myNoun   = $MyInvocationName -split '-'
        $myScriptBlock     = $MyInvocation.MyCommand.ScriptBlock
        $IsGet             = $myVerb -eq "Get"
        $NoVerb            = $MyInvocationName -match '^[^\.\&][^-]+$'
        $NonNameParameters = @($PSBoundParameters.Keys) -ne 'Name'

        if (
            $IsGet -or 
            $NoVerb
        ) {
            $inputsOfKind =
                Get-OBSInput -InputKind $InputKind |
                    Where-Object {
                        if ($Name) {
                            $_.InputName -like $Name
                        } else {
                            $_
                        }
                    }
            if ($NonNameParameters -and -not $IsGet) {
                $paramCopy = [Ordered]@{} + $PSBoundParameters
                if ($paramCopy.Name) { $paramCopy.Remove('Name') }
                $inputsOfKind | & $myScriptBlock @paramCopy
            } else {
                $inputsOfKind
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


        
        if (-not $Name) {
            $Name = $myParameters['Name'] =
                if ($AudioSource) {
                    "$($AudioSource)-Waveform"
                } else {
                    "Waveform"
                }
        }
        
        if ($myParameterData.color_base) {
            $myParameterData.color_base = $myParameterData.color_base | ToOBSColor
        }

        if ($myParameterData.color_crest) {
            $myParameterData.color_crest = $myParameterData.color_crest | ToOBSColor
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