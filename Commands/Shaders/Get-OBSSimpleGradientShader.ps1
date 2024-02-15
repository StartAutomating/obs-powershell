function Get-OBSSimpleGradientShader {

[Alias('Set-OBSSimpleGradientShader','Add-OBSSimpleGradientShader')]
param(
# Set the speed_percentage of OBSSimpleGradientShader
[Alias('speed_percentage')]
[ComponentModel.DefaultBindingProperty('speed_percentage')]
[Int32]
$SpeedPercentage,
# Set the alpha_percentage of OBSSimpleGradientShader
[Alias('alpha_percentage')]
[ComponentModel.DefaultBindingProperty('alpha_percentage')]
[Int32]
$AlphaPercentage,
# Set the Lens_Flair of OBSSimpleGradientShader
[Alias('Lens_Flair')]
[ComponentModel.DefaultBindingProperty('Lens_Flair')]
[Management.Automation.SwitchParameter]
$LensFlair,
# Set the Animate_Lens_Flair of OBSSimpleGradientShader
[Alias('Animate_Lens_Flair')]
[ComponentModel.DefaultBindingProperty('Animate_Lens_Flair')]
[Management.Automation.SwitchParameter]
$AnimateLensFlair,
# Set the Apply_To_Alpha_Layer of OBSSimpleGradientShader
[Alias('Apply_To_Alpha_Layer')]
[ComponentModel.DefaultBindingProperty('Apply_To_Alpha_Layer')]
[Management.Automation.SwitchParameter]
$ApplyToAlphaLayer,
# Set the Apply_To_Specific_Color of OBSSimpleGradientShader
[Alias('Apply_To_Specific_Color')]
[ComponentModel.DefaultBindingProperty('Apply_To_Specific_Color')]
[Management.Automation.SwitchParameter]
$ApplyToSpecificColor,
# Set the Color_To_Replace of OBSSimpleGradientShader
[Alias('Color_To_Replace')]
[ComponentModel.DefaultBindingProperty('Color_To_Replace')]
[String]
$ColorToReplace,
# Set the notes of OBSSimpleGradientShader
[ComponentModel.DefaultBindingProperty('notes')]
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
$shaderName = 'simple_gradient'
$ShaderNoun = 'OBSSimpleGradientShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Simple Gradient shader by Charles Fettinger for obs-shaderfilter plugin 3/2019
// https://github.com/Oncorporation/obs-shaderfilter

//lots of room to play here
//Converted to OpenGL by Q-mii & Exeldro February 25, 2022
uniform int speed_percentage<
    string label = "speed percentage";
    string widget_type = "slider";
    int minimum = -500;
    int maximum = 500;
    int step = 1;
> = 240; //<Range(-100.0, 100.0)>
uniform int alpha_percentage<
    string label = "aplha percentage";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 90;
uniform bool Lens_Flair = false;
uniform bool Animate_Lens_Flair = false;
uniform bool Apply_To_Alpha_Layer = false;
uniform bool Apply_To_Specific_Color;
uniform float4 Color_To_Replace;
uniform string notes<
    string widget_type = "info";
> = "This gradient is very basic from the top left corner. Red on horizontal, Green vertical, Blue Diagonal. Apply To Alpha Layer will add the gradient colors to the background. Lens Flair will brighten the scene from the bottom right. There is also a lot of unused code to play with in the shader file, delimted by /* ... */";

float4 mainImage(VertData v_in) : TARGET
{

	float4 background_color = image.Sample(textureSampler, v_in.uv);
	int no_colors = 4;
 	float3 colors[4];
     colors[0] = float3(1.0,0.0,0.0);
     colors[1] = float3(0.0,1.0,0.0);
     colors[2] = float3(0.0,0.0,1.0);
     colors[3] = float3(1.0,1.0,1.0);
 	float alpha = float(alpha_percentage) * 0.01;
 	float speed = float(speed_percentage) * 0.01;

	float mx = max(uv_size.x , uv_size.y);
	//float2 uv = v_in.uv / mx;
	float3 rgb = background_color.rgb;

	// skip if (alpha is zero and only apply to alpha layer is true) 
	if (!(background_color.a <= 0.0 && Apply_To_Alpha_Layer == true))
	{
		rgb = float3(v_in.uv.x, v_in.uv.y, 0.10 + 0.85 * sin(elapsed_time * speed));
	}

	//create lens flare like effect
	if (Lens_Flair)
	{
		float2 lens_flair_coordinates = float2(0.95 ,0.95);
		if (Animate_Lens_Flair)
			lens_flair_coordinates *= float2(sin(elapsed_time * speed) ,cos(elapsed_time * speed));

		float dist = distance(v_in.uv, ( lens_flair_coordinates * uv_scale + uv_offset));
		for (int i = 0; i < no_colors; ++i) {
			rgb += lerp(rgb, colors[i], dist * 1.5) * 0.25;
		}
	}


	//float3 col = colors[0];
/*	for (int i = 1; i < no_colors; ++i) {
		float3 hole = float3(
			sin(1.5 - distance(v_in.uv.x / mx, colors[i].x / mx)  * 2.5 * speed),
			sin(1.5 - distance(v_in.uv.y / mx, colors[i].y / mx)  * 2.5 * speed),
			colors[i].z);
		rgb = lerp(rgb, hole, 0.1);
*/
/*		float3 hole = lerp(colors[i-1], colors[i], sin(elapsed_time * speed));
		col = lerp(col, hole, v_in.uv.x);
*/		
	//}
//	rgb = fflerp(rgb, col, 0.5);



	//try prepositioned colors with colors[] array timing
	//creates an animated color spotlight
/*	int color_index = int(sin(elapsed_time * speed) * no_colors);
	float3 start_color = colors[color_index];
	float3 end_color;
	if (color_index >= 0)
	{
		end_color = colors[color_index - 1];
	}
	else
	{
		end_color = colors[no_colors - 1];
	}

	rgb = smoothstep(start_color, end_color, distance(v_in.uv , sin(elapsed_time * speed * no_colors) * (float2(1.0,1.0) * uv_scale + uv_offset)));
*/
    float4 rgba;
	if (Apply_To_Alpha_Layer == false)
	{
		rgba = lerp(background_color,float4(rgb, 1.0),alpha);
	}
	else
	{
		rgba =  lerp(background_color,background_color * float4(rgb,1.0), alpha);
	}
    if (Apply_To_Specific_Color)
    {
        float4 original_color = background_color;
        background_color = (distance(background_color.rgb, Color_To_Replace.rgb) <= 0.075) ? rgba : background_color;
        rgba = lerp(original_color, background_color, clamp(alpha, 0, 1.0));
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

