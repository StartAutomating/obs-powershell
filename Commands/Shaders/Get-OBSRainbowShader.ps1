function Get-OBSRainbowShader {

[Alias('Set-OBSRainbowShader','Add-OBSRainbowShader')]
param(
# Set the Saturation of OBSRainbowShader
[ComponentModel.DefaultBindingProperty('Saturation')]
[Single]
$Saturation,
# Set the Luminosity of OBSRainbowShader
[ComponentModel.DefaultBindingProperty('Luminosity')]
[Single]
$Luminosity,
# Set the Spread of OBSRainbowShader
[ComponentModel.DefaultBindingProperty('Spread')]
[Single]
$Spread,
# Set the Speed of OBSRainbowShader
[ComponentModel.DefaultBindingProperty('Speed')]
[Single]
$Speed,
# Set the Alpha_Percentage of OBSRainbowShader
[Alias('Alpha_Percentage')]
[ComponentModel.DefaultBindingProperty('Alpha_Percentage')]
[Single]
$AlphaPercentage,
# Set the Vertical of OBSRainbowShader
[ComponentModel.DefaultBindingProperty('Vertical')]
[Management.Automation.SwitchParameter]
$Vertical,
# Set the Rotational of OBSRainbowShader
[ComponentModel.DefaultBindingProperty('Rotational')]
[Management.Automation.SwitchParameter]
$Rotational,
# Set the Rotation_Offset of OBSRainbowShader
[Alias('Rotation_Offset')]
[ComponentModel.DefaultBindingProperty('Rotation_Offset')]
[Single]
$RotationOffset,
# Set the Apply_To_Image of OBSRainbowShader
[Alias('Apply_To_Image')]
[ComponentModel.DefaultBindingProperty('Apply_To_Image')]
[Management.Automation.SwitchParameter]
$ApplyToImage,
# Set the Replace_Image_Color of OBSRainbowShader
[Alias('Replace_Image_Color')]
[ComponentModel.DefaultBindingProperty('Replace_Image_Color')]
[Management.Automation.SwitchParameter]
$ReplaceImageColor,
# Set the Apply_To_Specific_Color of OBSRainbowShader
[Alias('Apply_To_Specific_Color')]
[ComponentModel.DefaultBindingProperty('Apply_To_Specific_Color')]
[Management.Automation.SwitchParameter]
$ApplyToSpecificColor,
# Set the Color_To_Replace of OBSRainbowShader
[Alias('Color_To_Replace')]
[ComponentModel.DefaultBindingProperty('Color_To_Replace')]
[String]
$ColorToReplace,
# Set the Notes of OBSRainbowShader
[ComponentModel.DefaultBindingProperty('Notes')]
[String]
$Notes,
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
$shaderName = 'rainbow'
$ShaderNoun = 'OBSRainbowShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Rainbow shader by Charles Fettinger for obs-shaderfilter plugin 3/2019
// https://github.com/Oncorporation/obs-shaderfilter
//Converted to OpenGL by Exeldro February 13, 2022
uniform float Saturation<
    string label = "Saturation";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.8; //<Range(0.0, 1.0)>
uniform float Luminosity<
    string label = "Luminosity";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.5; //<Range(0.0, 1.0)>
uniform float Spread<
    string label = "Spread";
    string widget_type = "slider";
    float minimum = 0.5;
    float maximum = 10.0;
    float step = 0.01;
> = 3.8; //<Range(0.5, 10.0)>
uniform float Speed<
    string label = "Speed";
    string widget_type = "slider";
    float minimum = -10.0;
    float maximum = 10.0;
    float step = 0.01;
> = 2.4; //<Range(-10.0, 10.0)>
uniform float Alpha_Percentage<
    string label = "Rotation Offset";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 0.1;
> = 100.0; //<Range(0.0,100.0)>
uniform bool Vertical;
uniform bool Rotational;
uniform float Rotation_Offset<
    string label = "Rotation Offset";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 6.28318531;
    float step = 0.001;
> = 0.0; //<Range(0.0, 6.28318531)>
uniform bool Apply_To_Image;
uniform bool Replace_Image_Color;
uniform bool Apply_To_Specific_Color;
uniform float4 Color_To_Replace;
uniform string Notes<
    string widget_type = "info";
> = "Spread is wideness of color and is limited between .25 and 10. Edit at your own risk";

float hueToRGB(float v1, float v2, float vH) {
	vH = frac(vH);
	if ((6.0 * vH) < 1.0) return (v1 + (v2 - v1) * 6.0 * vH);
	if ((2.0 * vH) < 1.0) return (v2);
	if ((3.0 * vH) < 2.0) return (v1 + (v2 - v1) * ((0.6666666666666667) - vH) * 6.0);
	return clamp(v1, 0.0, 1.0);
}

float4 HSLtoRGB(float4 hsl) {
	float4 rgb = float4(0.0, 0.0, 0.0, hsl.w);
	float v1 = 0.0;
	float v2 = 0.0;
	
	if (hsl.y == 0) {
		rgb.xyz = hsl.zzz;
	}
	else {
		
		if (hsl.z < 0.5) {
			v2 = hsl.z * (1 + hsl.y);
		}
		else {
			v2 = (hsl.z + hsl.y) - (hsl.y * hsl.z);
		}
		
		v1 = 2.0 * hsl.z - v2;
		
		rgb.x = hueToRGB(v1, v2, hsl.x + (0.3333333333333333));
		rgb.y = hueToRGB(v1, v2, hsl.x);
		rgb.z = hueToRGB(v1, v2, hsl.x - (0.3333333333333333));
		
	}
	
	return rgb;
}

float4 mainImage(VertData v_in) : TARGET
{
	float2 lPos = (v_in.uv * uv_scale + uv_offset)/ clamp(Spread, 0.25, 10.0);
	float time = (elapsed_time * clamp(Speed, -5.0, 5.0)) / clamp(Spread, 0.25, 10.0);	

	//set colors and direction
	float hue = (-1 * lPos.x) / 2.0;

	if (Rotational && (Vertical == false))
	{
		float timeWithOffset = time + Rotation_Offset;
		float sine = sin(timeWithOffset);
		float cosine = cos(timeWithOffset);
		hue = (lPos.x * cosine + lPos.y * sine) * 0.5;
	}

	if (Vertical && (Rotational == false))
	{
		hue = (-1 * lPos.y) * 0.5;
	}	

	hue += time;
	hue = frac(hue);
	float4 hsl = float4(hue, clamp(Saturation, 0.0, 1.0), clamp(Luminosity, 0.0, 1.0), 1.0);
	float4 rgba = HSLtoRGB(hsl);
	
    float4 color;
    float4 original_color;
	if (Apply_To_Image)
	{
		color = image.Sample(textureSampler, v_in.uv);
		original_color = color;
		float luma = 0.30*color.r+0.59*color.g+0.11*color.b+1.0*color.a;
		float4 luma_color = float4(luma, luma, luma, luma);
		if (Replace_Image_Color)
			color = luma_color;
		rgba = lerp(original_color, rgba * color,clamp(Alpha_Percentage *.01 ,0,1.0));
		
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

