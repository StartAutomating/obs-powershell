function Get-OBSZoomBlurTransitionShader {

[Alias('Set-OBSZoomBlurTransitionShader','Add-OBSZoomBlurTransitionShader')]
param(
# Set the image_a of OBSZoomBlurTransitionShader
[Alias('image_a')]
[ComponentModel.DefaultBindingProperty('image_a')]
[String]
$ImageA,
# Set the image_b of OBSZoomBlurTransitionShader
[Alias('image_b')]
[ComponentModel.DefaultBindingProperty('image_b')]
[String]
$ImageB,
# Set the transition_time of OBSZoomBlurTransitionShader
[Alias('transition_time')]
[ComponentModel.DefaultBindingProperty('transition_time')]
[Single]
$TransitionTime,
# Set the convert_linear of OBSZoomBlurTransitionShader
[Alias('convert_linear')]
[ComponentModel.DefaultBindingProperty('convert_linear')]
[Management.Automation.SwitchParameter]
$ConvertLinear,
# Set the strength of OBSZoomBlurTransitionShader
[ComponentModel.DefaultBindingProperty('strength')]
[Single]
$Strength,
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
$shaderName = 'zoom_blur_transition'
$ShaderNoun = 'OBSZoomBlurTransitionShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
//based on https://www.shadertoy.com/view/Ml3XR2

uniform texture2d image_a;
uniform texture2d image_b;
uniform float transition_time = 0.5;
uniform bool convert_linear = true;

//modified zoom blur from http://transitions.glsl.io/transition/b86b90161503a0023231
uniform float strength<
    string label = "Strength (0.3)";
    string widget_type = "slider";
    float minimum = 0.00;
    float maximum = 1.50;
    float step = 0.01;
> = 0.3;
#define PI 3.141592653589793

float Linear_ease(in float begin, in float change, in float duration, in float time) {
    return change * time / duration + begin;
}

float Exponential_easeInOut(in float begin, in float change, in float duration, in float time) {
    if (time == 0.0)
        return begin;
    else if (time == duration)
        return begin + change;
    time = time / (duration / 2.0);
    if (time < 1.0)
        return change / 2.0 * pow(2.0, 10.0 * (time - 1.0)) + begin;
    return change / 2.0 * (-pow(2.0, -10.0 * (time - 1.0)) + 2.0) + begin;
}

float Sinusoidal_easeInOut(in float begin, in float change, in float duration, in float time) {
    return -change / 2.0 * (cos(PI * time / duration) - 1.0) + begin;
}

float random(in float3 scale, in float seed) {
    return frac(sin(dot(float3(seed, seed, seed), scale)) * 43758.5453 + seed);
}

float3 crossFade(in float2 uv, in float dissolve) {
    return lerp(image_a.Sample(textureSampler, uv).rgb, image_b.Sample(textureSampler, uv).rgb, dissolve);
}

float4 mainImage(VertData v_in) : TARGET {
    float2 texCoord = v_in.uv;
	float progress = transition_time;
    // Linear interpolate center across center half of the image
    float2 center = float2(Linear_ease(0.5, 0.0, 1.0, progress),0.5);
    float dissolve = Exponential_easeInOut(0.0, 1.0, 1.0, progress);

    // Mirrored sinusoidal loop. 0->strength then strength->0
    float strength2 = Sinusoidal_easeInOut(0.0, strength, 0.5, progress);

    float3 color = float3(0.0,0.0,0.0);
    float total = 0.0;
    float2 toCenter = center - texCoord;

    /* randomize the lookup values to hide the fixed float of samples */
    float offset = random(float3(12.9898, 78.233, 151.7182), 0.0)*0.5;

    for (float t = 0.0; t <= 20.0; t++) {
        float percent = (t + offset) / 20.0;
        float weight = 1.0 * (percent - percent * percent);
        color += crossFade(texCoord + toCenter * percent * strength2, dissolve) * weight;
        total += weight;
    }
    float4 rgba = float4(color / total, 1.0);
	if (convert_linear)
		rgba.rgb = srgb_nonlinear_to_linear(rgba.rgb);
	return rgba;
}
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

