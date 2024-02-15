function Get-OBSGlitchAnalogShader {

[Alias('Set-OBSGlitchAnalogShader','Add-OBSGlitchAnalogShader')]
param(
# Set the scan_line_jitter_displacement of OBSGlitchAnalogShader
[Alias('scan_line_jitter_displacement')]
[ComponentModel.DefaultBindingProperty('scan_line_jitter_displacement')]
[Single]
$ScanLineJitterDisplacement,
# Set the scan_line_jitter_threshold_percent of OBSGlitchAnalogShader
[Alias('scan_line_jitter_threshold_percent')]
[ComponentModel.DefaultBindingProperty('scan_line_jitter_threshold_percent')]
[Int32]
$ScanLineJitterThresholdPercent,
# Set the vertical_jump_amount of OBSGlitchAnalogShader
[Alias('vertical_jump_amount')]
[ComponentModel.DefaultBindingProperty('vertical_jump_amount')]
[Single]
$VerticalJumpAmount,
# Set the vertical_speed of OBSGlitchAnalogShader
[Alias('vertical_speed')]
[ComponentModel.DefaultBindingProperty('vertical_speed')]
[Single]
$VerticalSpeed,
# Set the horizontal_shake of OBSGlitchAnalogShader
[Alias('horizontal_shake')]
[ComponentModel.DefaultBindingProperty('horizontal_shake')]
[Single]
$HorizontalShake,
# Set the color_drift_amount of OBSGlitchAnalogShader
[Alias('color_drift_amount')]
[ComponentModel.DefaultBindingProperty('color_drift_amount')]
[Single]
$ColorDriftAmount,
# Set the color_drift_speed of OBSGlitchAnalogShader
[Alias('color_drift_speed')]
[ComponentModel.DefaultBindingProperty('color_drift_speed')]
[Single]
$ColorDriftSpeed,
# Set the pulse_speed_percent of OBSGlitchAnalogShader
[Alias('pulse_speed_percent')]
[ComponentModel.DefaultBindingProperty('pulse_speed_percent')]
[Int32]
$PulseSpeedPercent,
# Set the alpha_percent of OBSGlitchAnalogShader
[Alias('alpha_percent')]
[ComponentModel.DefaultBindingProperty('alpha_percent')]
[Int32]
$AlphaPercent,
# Set the rotate_colors of OBSGlitchAnalogShader
[Alias('rotate_colors')]
[ComponentModel.DefaultBindingProperty('rotate_colors')]
[Management.Automation.SwitchParameter]
$RotateColors,
# Set the Apply_To_Alpha_Layer of OBSGlitchAnalogShader
[Alias('Apply_To_Alpha_Layer')]
[ComponentModel.DefaultBindingProperty('Apply_To_Alpha_Layer')]
[Management.Automation.SwitchParameter]
$ApplyToAlphaLayer,
# Set the Replace_Image_Color of OBSGlitchAnalogShader
[Alias('Replace_Image_Color')]
[ComponentModel.DefaultBindingProperty('Replace_Image_Color')]
[Management.Automation.SwitchParameter]
$ReplaceImageColor,
# Set the Apply_To_Specific_Color of OBSGlitchAnalogShader
[Alias('Apply_To_Specific_Color')]
[ComponentModel.DefaultBindingProperty('Apply_To_Specific_Color')]
[Management.Automation.SwitchParameter]
$ApplyToSpecificColor,
# Set the Color_To_Replace of OBSGlitchAnalogShader
[Alias('Color_To_Replace')]
[ComponentModel.DefaultBindingProperty('Color_To_Replace')]
[String]
$ColorToReplace,
# Set the notes of OBSGlitchAnalogShader
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
$shaderName = 'glitch_analog'
$ShaderNoun = 'OBSGlitchAnalogShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// analog glitch shader by Charles Fettinger for obs-shaderfilter plugin 3/2019
//https://github.com/Oncorporation/obs-shaderfilter
//Converted to OpenGL by Q-mii & Exeldro February 22, 2022
uniform float scan_line_jitter_displacement<
    string label = "Scan line jitter";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 0.01;
> = 33.0; // (displacement, threshold)
uniform int scan_line_jitter_threshold_percent<
    string label = "scan line jitter threshold percent";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 95;
uniform float vertical_jump_amount<
    string label = "Vertical jump amount";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 0.01;
>;
uniform float vertical_speed<
    string label = "Vertical speed";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 0.01;
>;// (amount, speed)
uniform float horizontal_shake<
    string label = "Horizontal shake";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 0.01;
>;
uniform float color_drift_amount<
    string label = "Color drift amount";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 0.01;
>;
uniform float color_drift_speed<
    string label = "Color drift speed";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 0.01;
>;// (amount, speed)
uniform int pulse_speed_percent<
    string label = "Pulse speed percent";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 0;
uniform int alpha_percent<
    string label = "Aplha percent";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 100;
uniform bool rotate_colors;
uniform bool Apply_To_Alpha_Layer = false;
uniform bool Replace_Image_Color;
uniform bool Apply_To_Specific_Color;
uniform float4 Color_To_Replace;
uniform string notes<
    string widget_type = "info";
> ="play with settings!";


float nrand(float x, float y)
{
	float value = dot(float2(x, y), float2(12.9898 , 78.233 ));
	return frac(sin(value) * 43758.5453);
}

float4 mainImage(VertData v_in) : TARGET
{
	float speed = pulse_speed_percent * 0.01;	
	float alpha = alpha_percent * 0.01;
	float scan_line_jitter_threshold = scan_line_jitter_threshold_percent * 0.01;
	float u = v_in.uv.x;
	float v = v_in.uv.y;
	float t = sin(elapsed_time * speed) * 2 - 1;
	float4 rgba = image.Sample(textureSampler, v_in.uv);

	// Scan line jitter
	float jitter = nrand(v, t) * 2 - 1;
	jitter *= step(scan_line_jitter_threshold, abs(jitter)) * scan_line_jitter_displacement;

	// Vertical jump
	float jump = lerp(v, frac(v +  (t * vertical_speed)), vertical_jump_amount);

	// Horizontal shake
	float shake = ((t * (u + rand_f)/2) - 0.5) * horizontal_shake;

	//// Color drift
	float drift = sin(jump + color_drift_speed) * color_drift_amount;

	float2 src1 = float2(rgba.x, rgba.z) * clamp(frac(float2(u + jitter + shake, jump)), -10.0, 10.0);
	float2 src2 = float2(rgba.y, rgba.w) * frac(float2(u + jitter + shake + drift, jump));
	
	if(rotate_colors)
	{
		// get general time number between 0 and 4
		float tx = (t + 1) * 2;
		// 3 steps  c1->c2, c2->c3, c3->c1
		//when between 0 - 1 only c1 rises then falls
		//(min(tx, 2.0) * 0.5)  range between 0-2 converted to 0-1-0
		src1.x = lerp(src1.x, rgba.x, clamp((min(tx, 2.0) * 0.5),0.0,0.5));
		//((min(max(1.0, tx),3.0) - 1) * 0.5)   range between 1-3 converted to 0-1-0
		src2.x = lerp(src2.x, rgba.y, clamp(((min(max(1.0, tx),3.0) - 1) * 0.5),0.0,0.5));
		//((min(2.0, tx) -2) * 0.5)  range between 2 and 4  converted to 0-1-0
		src1.y = lerp(src1.y, rgba.z, clamp(((min(2.0, tx) -2) * 0.5),0.0,0.5));
		
	}

    float4 color = rgba;
    float4 original_color = color;
    rgba = float4(src1.x, src2.x, src1.y, alpha);

    if (Apply_To_Alpha_Layer)
    {
        float luma = color.r * 0.299 + color.g * 0.587 + color.b * 0.114;
        if (Replace_Image_Color)
            color = float4(luma, luma, luma, luma); 
        rgba = lerp(original_color, rgba * color, alpha);
    }
	
    if (Apply_To_Specific_Color)
    {
        color = original_color;
        color = (distance(color.rgb, Color_To_Replace.rgb) <= 0.075) ? rgba : color;
        rgba = lerp(original_color, color, alpha);
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

