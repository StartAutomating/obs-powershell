function Get-OBSAudioShader {

[Alias('Set-OBSAudioShader','Add-OBSAudioShader')]
param(
# Set the audio_peak of OBSAudioShader
[Alias('audio_peak')]
[ComponentModel.DefaultBindingProperty('audio_peak')]
[Single]
$AudioPeak,
# Set the audio_magnitude of OBSAudioShader
[Alias('audio_magnitude')]
[ComponentModel.DefaultBindingProperty('audio_magnitude')]
[Single]
$AudioMagnitude,
# Set the intensity of OBSAudioShader
[ComponentModel.DefaultBindingProperty('intensity')]
[Single]
$Intensity,
# The name of the source.  This must be provided when adding an item for the first time
[Parameter(ValueFromPipelineByPropertyName)]
[Alias('SceneItemName')]
[String]
$SourceName,
# The name of the filter.  If this is not provided, this will default to the shader name.
[Parameter(ValueFromPipelineByPropertyName)]
[String]
$FilterName,
# The inline value of the shader.  This will normally be provided as a default parameter, based off of the name.
[Alias('ShaderContent')]
[String]
$ShaderText,
# If set, will force the recreation of a shader that already exists
[Management.Automation.SwitchParameter]
$Force,
# If set, will pass thru the commands that would be sent to OBS (these can be sent at any time with Send-OBS)
[Management.Automation.SwitchParameter]
$PassThru,
# If set, will not wait for a response from OBS (this will be faster, but will not return anything)
[Management.Automation.SwitchParameter]
$NoResponse,
# If set, use the shader elapsed time, instead of the OBS system elapsed time
[ComponentModel.DefaultBindingProperty('use_shader_elapsed_time')]
[Management.Automation.SwitchParameter]
$UseShaderTime
)


process {
$shaderName = 'audio'
$ShaderNoun = 'OBSAudioShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Audio shader example showing the difference between audio_peak and audio_magnitude.
// Left half uses audio_peak (red), right half uses audio_magnitude (blue).
uniform float audio_peak;
uniform float audio_magnitude;

uniform float intensity <
  string label = "Audio intensity";
  string widget_type = "slider";
  float minimum = 0.1;
  float maximum = 3.0;
  float step = 0.1;
> = 1.0;

float4 mainImage(VertData v_in) : TARGET {
  float4 color = image.Sample(textureSampler, v_in.uv);
  
  // Split screen based on UV coordinate
  if (v_in.uv.x < 0.5) {
    // Left half: audio_peak (instantaneous spikes, more reactive)
    // Tint with red to show peak activity.
    float peak_strength = audio_peak * intensity;
    float3 peak_color = color.rgb + float3(peak_strength, 0, 0);
    return float4(peak_color, color.a);
  } else {
    // Right half: audio_magnitude (RMS/averaged levels, smoother)
    // Tint with blue to show magnitude activity.
    float mag_strength = audio_magnitude * intensity;
    float3 mag_color = color.rgb + float3(0, 0, mag_strength);
    return float4(mag_color, color.a);
  }
}

/*
EXPLANATION:
- audio_peak: Shows instantaneous maximum levels, very responsive to drums/percussion.
- audio_magnitude: Shows RMS (Root Mean Square) levels, smoother and represents sustained audio.

TYPICAL BEHAVIOR:
- With music containing drums: Left side (peak) will flash more dramatically on beats.
- With sustained tones: Right side (magnitude) will show more consistent levels.
- Peak reacts faster to sudden sounds, magnitude is more stable for smooth effects.
*/

'
}
$MyVerb, $myNoun = $MyInvocation.InvocationName -split '-',2
if (-not $myNoun) {
    $myNoun = $myVerb
    $myVerb = 'Get'    
}
switch -regex ($myVerb) {
    Get {
        $FilterNamePattern = "(?>$(
            if ($FilterName) {
                [Regex]::Escape($FilterName)
            }
            else {
                [Regex]::Escape($ShaderNoun -replace '^OBS' -replace 'Shader$'),[Regex]::Escape($shaderName) -join '|'
            }
        ))"
        if ($SourceName) {
            Get-OBSInput | 
                Where-Object InputName -eq $SourceName |
                Get-OBSSourceFilterList |
                Where-Object FilterName -Match $FilterNamePattern
        } else {
            $obs.Inputs |
                Get-OBSSourceFilterList |
                Where-Object FilterName -Match $FilterNamePattern
        }        
    }
    'Remove' {
        if ($SourceName) {
            Get-OBSInput | 
                Where-Object InputName -eq $SourceName |
                Get-OBSSourceFilterList |
                Where-Object FilterName -Match $FilterNamePattern |
                Remove-OBSSourceFilter
        }
    }
    '(?>Add|Set)' {
        $ShaderSettings = [Ordered]@{}
        :nextParameter foreach ($parameterMetadata in $MyInvocation.MyCommand.Parameters[@($psBoundParameters.Keys)]) {
            foreach ($parameterAttribute in $parameterMetadata.Attributes) {
                if ($parameterAttribute -isnot [ComponentModel.DefaultBindingPropertyAttribute]) { continue }
                $ShaderSettings[$parameterAttribute.Name] = $PSBoundParameters[$parameterMetadata.Name]
                if ($ShaderSettings[$parameterAttribute.Name] -is [switch]) {
                    $ShaderSettings[$parameterAttribute.Name] = $ShaderSettings[$parameterAttribute.Name] -as [bool]
                }
                continue nextParameter
            }            
        }

        if (-not $PSBoundParameters['FilterName']) {
            $filterName = $PSBoundParameters['FilterName'] = $shaderName
        }

        $ShaderFilterSplat = [Ordered]@{
            ShaderSetting = $ShaderSettings
            FilterName = $FilterName
            SourceName = $SourceName
        }        

        foreach ($CarryOnParameter in "PassThru", "NoResponse","Force") {
            if ($PSBoundParameters.ContainsKey($CarryOnParameter)) {
                $ShaderFilterSplat[$CarryOnParameter] = $PSBoundParameters[$CarryOnParameter]
            }
        }

        if (-not $script:CachedShaderFilesFromCommand) {
            $script:CachedShaderFilesFromCommand = @{}
        }

        if ($Home -and -not $script:CachedShaderFilesFromCommand[$shaderName]) {
            $MyObsPowerShellPath = Join-Path $home ".obs-powershell"
            $ThisShaderPath = Join-Path $MyObsPowerShellPath "$shaderName.shader"
            $shaderText | Set-Content -LiteralPath $ThisShaderPath
            $script:CachedShaderFilesFromCommand[$shaderName] = Get-Item -LiteralPath $ThisShaderPath
        }
        if ($script:CachedShaderFilesFromCommand[$shaderName]) {
            $ShaderFilterSplat.ShaderFile = $script:CachedShaderFilesFromCommand[$shaderName].FullName
        } else {
            $ShaderFilterSplat.ShaderText = $shaderText
        }        

        if ($myVerb -eq 'Add') {                        
            Add-OBSShaderFilter @ShaderFilterSplat
        } else {
            Set-OBSShaderFilter @ShaderFilterSplat
        }
    }
}

}


} 

