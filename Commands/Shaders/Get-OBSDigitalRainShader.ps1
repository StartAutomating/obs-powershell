function Get-OBSDigitalRainShader {

[Alias('Set-OBSDigitalRainShader','Add-OBSDigitalRainShader')]
param(
# Set the font of OBSDigitalRainShader
[ComponentModel.DefaultBindingProperty('font')]
[String]
$Font,
# Set the noise of OBSDigitalRainShader
[ComponentModel.DefaultBindingProperty('noise')]
[String]
$Noise,
# Set the base_color of OBSDigitalRainShader
[Alias('base_color')]
[ComponentModel.DefaultBindingProperty('base_color')]
[String]
$BaseColor,
# Set the rain_speed of OBSDigitalRainShader
[Alias('rain_speed')]
[ComponentModel.DefaultBindingProperty('rain_speed')]
[Single]
$RainSpeed,
# Set the char_speed of OBSDigitalRainShader
[Alias('char_speed')]
[ComponentModel.DefaultBindingProperty('char_speed')]
[Single]
$CharSpeed,
# Set the glow_contrast of OBSDigitalRainShader
[Alias('glow_contrast')]
[ComponentModel.DefaultBindingProperty('glow_contrast')]
[Single]
$GlowContrast,
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
$shaderName = 'digital-rain'
$ShaderNoun = 'OBSDigitalRainShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// based on https://www.shadertoy.com/view/ldccW4 by WillKirkby


#ifndef OPENGL
#define fract frac
#define mix lerp
#endif

uniform texture2d font = "font.png";
uniform texture2d noise = "noise.png";
uniform float4 base_color = {.1, 1.0, .35, 1.0};
uniform float rain_speed<
    string label = "Rain Speed";
    string widget_type = "slider";
    float minimum = 0.001;
    float maximum = 2.0;
    float step = .001;
> = 1.0;

uniform float char_speed<
    string label = "Character Speed";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 2.0;
    float step = .001;
> = 1.0;

uniform float glow_contrast<
    string label = "Glow contrast";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 2.5;
    float step = .001;
> = 1.0;


float mod(float x, float y)
{
  return x - y * floor(x/y);
}

float2 mod2(float2 x, float2 y)
{
  return x - y * floor(x/y);
}

float text(float2 fragCoord)
{
    float2 uv = mod2(fragCoord, float2(16.0, 16.0) )/16.0;
    float2 block = (fragCoord*.0625 - uv)/uv_size*16.0;
    uv = uv*.8+.1; // scale the letters up a bit
    block += elapsed_time*.002*char_speed;
    uv += floor(noise.Sample(textureSampler, fract(block)).xy * 16.); // randomize letters
    uv *= .0625; // bring back into 0-1 range
    return font.Sample(textureSampler, uv).r;
}

float3 rain(float2 fragCoord)
{
	fragCoord.x -= mod(fragCoord.x, 16.);   
    float offset=sin(fragCoord.x*15.);
    float speed=(cos(fragCoord.x*3.)*.3+.7)*rain_speed;
   
    float y = fract(fragCoord.y/uv_size.y + elapsed_time*speed + offset);
    return base_color.rgb / pow(y*20.0, glow_contrast);
}

float4 mainImage(VertData v_in) : TARGET
{
    return mix(image.Sample(textureSampler, v_in.uv),float4(rain(float2(v_in.uv.x,1.0-v_in.uv.y)*uv_size),1.0), text(v_in.uv*uv_size));
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

