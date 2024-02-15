function Get-OBSGaussianSimpleShader {

[Alias('Set-OBSGaussianSimpleShader','Add-OBSGaussianSimpleShader')]
param(
# Set the ViewProj of OBSGaussianSimpleShader
[ComponentModel.DefaultBindingProperty('ViewProj')]
[Single[][]]
$ViewProj,
# Set the image of OBSGaussianSimpleShader
[ComponentModel.DefaultBindingProperty('image')]
[String]
$Image,
# Set the elapsed_time of OBSGaussianSimpleShader
[Alias('elapsed_time')]
[ComponentModel.DefaultBindingProperty('elapsed_time')]
[Single]
$ElapsedTime,
# Set the uv_offset of OBSGaussianSimpleShader
[Alias('uv_offset')]
[ComponentModel.DefaultBindingProperty('uv_offset')]
[Single[]]
$UvOffset,
# Set the uv_scale of OBSGaussianSimpleShader
[Alias('uv_scale')]
[ComponentModel.DefaultBindingProperty('uv_scale')]
[Single[]]
$UvScale,
# Set the uv_pixel_interval of OBSGaussianSimpleShader
[Alias('uv_pixel_interval')]
[ComponentModel.DefaultBindingProperty('uv_pixel_interval')]
[Single[]]
$UvPixelInterval,
# Set the uv_size of OBSGaussianSimpleShader
[Alias('uv_size')]
[ComponentModel.DefaultBindingProperty('uv_size')]
[Single[]]
$UvSize,
# Set the rand_f of OBSGaussianSimpleShader
[Alias('rand_f')]
[ComponentModel.DefaultBindingProperty('rand_f')]
[Single]
$RandF,
# Set the rand_instance_f of OBSGaussianSimpleShader
[Alias('rand_instance_f')]
[ComponentModel.DefaultBindingProperty('rand_instance_f')]
[Single]
$RandInstanceF,
# Set the rand_activation_f of OBSGaussianSimpleShader
[Alias('rand_activation_f')]
[ComponentModel.DefaultBindingProperty('rand_activation_f')]
[Single]
$RandActivationF,
# Set the loops of OBSGaussianSimpleShader
[ComponentModel.DefaultBindingProperty('loops')]
[Int32]
$Loops,
# Set the local_time of OBSGaussianSimpleShader
[Alias('local_time')]
[ComponentModel.DefaultBindingProperty('local_time')]
[Single]
$LocalTime,
# Set the samples of OBSGaussianSimpleShader
[ComponentModel.DefaultBindingProperty('samples')]
[Int32]
$Samples,
# Set the LOD of OBSGaussianSimpleShader
[ComponentModel.DefaultBindingProperty('LOD')]
[Int32]
$LOD,
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
$shaderName = 'gaussian-simple'
$ShaderNoun = 'OBSGaussianSimpleShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Single-pass gaussian blur - fast shader modified by Charles Fettinger for use with obs-shaderfilter 7/2020 v.01
// https://github.com/Oncorporation/obs-shaderfilter
// https://www.shadertoy.com/view/ltScRG Converted inspiration

//Section to converting GLSL to HLSL - can delete
#define vec2 float2
#define vec3 float3
#define vec4 float4
#define ivec2 int2
#define ivec3 int3
#define ivec4 int4
#define mat2 float2x2
#define mat3 float3x3
#define mat4 float4x4
#define fract frac
#define mix lerp
#define iTime float

/*
**Shaders have these variables pre loaded by the plugin**
**this section can be deleted**

uniform float4x4 ViewProj;
uniform texture2d image;

uniform float elapsed_time;
uniform float2 uv_offset;
uniform float2 uv_scale;
uniform float2 uv_pixel_interval;
uniform float2 uv_size;
uniform float rand_f;
uniform float rand_instance_f;
uniform float rand_activation_f;
uniform int loops;
uniform float local_time;
*/

// 16x acceleration of https://www.shadertoy.com/view/4tSyzy
// by applying gaussian at intermediate MIPmap level.

uniform int samples<
    string label = "Samples";
    string widget_type = "slider";
    int minimum = 1;
    int maximum = 25;
    int step = 1;
> = 16;
uniform int LOD<
    string label = "LOD";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 25;
    int step = 1;
> = 2; // gaussian done on MIPmap at scale LOD

float gaussian(vec2 i)
{
	float sigma = (float(samples) * .25);
    return exp(-.5 * dot(i /= sigma, i)) / (6.28 * sigma * sigma);
}

vec4 blur(vec2 U, vec2 scale)
{
    vec4 O = vec4(0,0,0,0);
    int sLOD = (1 << LOD); // tile size = 2^LOD
    int s = samples / sLOD;
    
    for (int i = 0; i < s * s; i++)
    {
        vec2 d = vec2(i % s, i / s) * float(sLOD) - float(samples) * 0.5;
        O += gaussian(d) * image.SampleLevel(textureSampler, U + (scale * gaussian(d)), float(LOD));
        //O += gaussian(d) * image.Sample(textureSampler, U + i * d * float(LOD));
        //O += image.Sample(textureSampler, U + gaussian(d) * float(LOD));
    }
    
    return O / O.a;
}

float4 mainImage(VertData v_in) : TARGET
{
    float2 iResolution = uv_scale;//uv_size * uv_scale + uv_offset;
    //float2 iResolution = 1 - v_in.uv  +  1.0;
    //float4 rgba = image.SampleLevel(textureSampler, v_in.uv * uv_scale + uv_offset,4.0);
    return blur(v_in.uv / iResolution, 1.0 / iResolution);
    //return rgba;
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

