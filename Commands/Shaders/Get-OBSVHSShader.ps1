function Get-OBSVHSShader {

[Alias('Set-OBSVHSShader','Add-OBSVHSShader')]
param(
# Set the range of OBSVHSShader
[ComponentModel.DefaultBindingProperty('range')]
[Single]
$Range,
# Set the offsetIntensity of OBSVHSShader
[ComponentModel.DefaultBindingProperty('offsetIntensity')]
[Single]
$OffsetIntensity,
# Set the noiseQuality of OBSVHSShader
[ComponentModel.DefaultBindingProperty('noiseQuality')]
[Int32]
$NoiseQuality,
# Set the noiseIntensity of OBSVHSShader
[ComponentModel.DefaultBindingProperty('noiseIntensity')]
[Single]
$NoiseIntensity,
# Set the colorOffsetIntensity of OBSVHSShader
[ComponentModel.DefaultBindingProperty('colorOffsetIntensity')]
[Single]
$ColorOffsetIntensity,
# Set the Alpha_Percentage of OBSVHSShader
[Alias('Alpha_Percentage')]
[ComponentModel.DefaultBindingProperty('Alpha_Percentage')]
[Single]
$AlphaPercentage,
# Set the Apply_To_Image of OBSVHSShader
[Alias('Apply_To_Image')]
[ComponentModel.DefaultBindingProperty('Apply_To_Image')]
[Management.Automation.SwitchParameter]
$ApplyToImage,
# Set the Replace_Image_Color of OBSVHSShader
[Alias('Replace_Image_Color')]
[ComponentModel.DefaultBindingProperty('Replace_Image_Color')]
[Management.Automation.SwitchParameter]
$ReplaceImageColor,
# Set the Color_To_Replace of OBSVHSShader
[Alias('Color_To_Replace')]
[ComponentModel.DefaultBindingProperty('Color_To_Replace')]
[String]
$ColorToReplace,
# Set the Apply_To_Specific_Color of OBSVHSShader
[Alias('Apply_To_Specific_Color')]
[ComponentModel.DefaultBindingProperty('Apply_To_Specific_Color')]
[Management.Automation.SwitchParameter]
$ApplyToSpecificColor,
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
$shaderName = 'VHS'
$ShaderNoun = 'OBSVHSShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
//based on https://www.shadertoy.com/view/Ms3XWH converted by Exeldro  v 1.0
//updated by Charles ''Surn'' Fettinger for obs-shaderfilter 9/2020
//Converted to OpenGL by Exeldro February 19, 2022
//Use improved input fields by Exeldro April 15, 2023
uniform float range<
    string label = "Wave size (0.05)";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 0.20;
    float step = 0.01;
> = 0.05;
uniform float offsetIntensity<
    string label = "Offset intensity (0.02)";
    string widget_type = "slider";
    float minimum = 0.01;
    float maximum = 0.20;
    float step = 0.01;
> = 0.02;
uniform int noiseQuality<
    string label = "Noise number of lines (250)";
    string widget_type = "slider";
    int minimum = 1.0;
    float maximum = 1000.0;
    float step = 10.0;
> = 250.0;
uniform float noiseIntensity<
    string label = "Noise intensity (0.88)";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 10.0;
    float step = 0.01;
> = 0.88;
uniform float colorOffsetIntensity<
    string label = "Color offset intensity (1.3)";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 10.0;
    float step = 0.1;
> = 1.3;
uniform float Alpha_Percentage<
    string label = "Aplha percentage (100.0)";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 1.0;
> = 100.0; 
uniform bool Apply_To_Image;
uniform bool Replace_Image_Color;
uniform float4 Color_To_Replace;
uniform bool Apply_To_Specific_Color;

float dot2(float2 a,float2 b){
    return a.x*b.x+a.y*b.y;
}

float rand(float2 co)
{
    return frac(sin(dot2(co.xy ,float2(12.9898,78.233))) * 43758.5453);
}

float verticalBar(float pos, float uvY, float offset)
{
    float edge0 = (pos - range);
    float edge1 = (pos + range);

    float x = smoothstep(edge0, pos, uvY) * offset;
    x -= smoothstep(pos, edge1, uvY) * offset;
    return x;
}

float modu(float x, float y)
{
	return (x / y) - floor(x / y);
}

float dot4(float4 a,float4 b){
    return a.r*b.r+a.g*b.g+a.b*b.b+a.a*b.a;
}

float4 mainImage(VertData v_in) : TARGET
{
    float2 uv = v_in.uv;
    for (float i = 0.0; i < 0.71; i += 0.1313)
    {
        float d = modu(elapsed_time * i, 1.7);
        float o = sin(1.0 - tan(elapsed_time * 0.24 * i));
    	o *= offsetIntensity;
        uv.x += verticalBar(d, uv.y, o);
    }
    float uvY = uv.y;
    uvY *= noiseQuality;
    uvY = float(int(uvY)) * (1.0 / noiseQuality);
    float noise = rand(float2(elapsed_time * 0.00001, uvY));
    uv.x += noise * noiseIntensity / 100.0;

    float2 offsetR = float2(0.006 * sin(elapsed_time), 0.0) * colorOffsetIntensity;
    float2 offsetG = float2(0.0073 * (cos(elapsed_time * 0.97)), 0.0) * colorOffsetIntensity;

    float4 rgba = image.Sample(textureSampler, uv);
    float r = image.Sample(textureSampler, uv + offsetR).r;
    float g = image.Sample(textureSampler, uv + offsetG).g;
    float b = rgba.b;

    rgba = float4(r, g, b, rgba.a);
    
    float4 color;
    float4 original_color;
    if (Apply_To_Image)
    {
        color = image.Sample(textureSampler, v_in.uv);
        original_color = color;
        float luma = dot4(color, float4(0.30, 0.59, 0.11, 1.0));
        if (Replace_Image_Color)
            color = float4(luma,luma,luma,luma);
        rgba = lerp(original_color, rgba * color, clamp(Alpha_Percentage * .01, 0, 1.0));
		
    }
    if (Apply_To_Specific_Color)
    {
        color = image.Sample(textureSampler, v_in.uv);
        original_color = color;
        color = (distance(color.rgb, Color_To_Replace.rgb) <= 0.075) ? rgba : color;
        rgba = lerp(original_color, color, clamp(Alpha_Percentage * .01, 0, 1.0));
    }

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

