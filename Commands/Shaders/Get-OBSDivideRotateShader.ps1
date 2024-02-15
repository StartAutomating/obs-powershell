function Get-OBSDivideRotateShader {

[Alias('Set-OBSDivideRotateShader','Add-OBSDivideRotateShader')]
param(
# Set the iChannel0 of OBSDivideRotateShader
[ComponentModel.DefaultBindingProperty('iChannel0')]
[String]
$IChannel0,
# Set the speed_percentage of OBSDivideRotateShader
[Alias('speed_percentage')]
[ComponentModel.DefaultBindingProperty('speed_percentage')]
[Int32]
$SpeedPercentage,
# Set the alpha_percentage of OBSDivideRotateShader
[Alias('alpha_percentage')]
[ComponentModel.DefaultBindingProperty('alpha_percentage')]
[Int32]
$AlphaPercentage,
# Set the Apply_To_Alpha_Layer of OBSDivideRotateShader
[Alias('Apply_To_Alpha_Layer')]
[ComponentModel.DefaultBindingProperty('Apply_To_Alpha_Layer')]
[Management.Automation.SwitchParameter]
$ApplyToAlphaLayer,
# Set the notes of OBSDivideRotateShader
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
$shaderName = 'divide_rotate'
$ShaderNoun = 'OBSDivideRotateShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// divide and rotate shader for OBS Studio shaderfilter plugin
// originally from shadertoy (https://www.shadertoy.com/view/3sy3Dh)
// Modified by Charles Fettinger (https://github.com/Oncorporation)  10/2019
//Converted to OpenGL by Q-mii & Exeldro February 18, 2022
uniform texture2d iChannel0;
uniform int speed_percentage<
    string label = "Speed";
    string widget_type = "slider";
    int minimum = -10;
    int maximum = 10;
    int step = 1;
> = 5;
uniform int alpha_percentage<
    string label = "Opacity Percentage";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 50;
uniform bool Apply_To_Alpha_Layer = true;

uniform string notes<
    string widget_type = "info";
> = "add rotation and speed";


float2 cm(float2 a, float2 b) {
    return float2(a.x * b.x - a.y * b.y, a.x * b.y + a.y * b.x);
}

float2 iter(float2 uv, float2 rot, float scale) {
    float2 gv = frac(cm(uv, rot) * scale);
    float boundDist = 1. - max(abs(gv.x), abs(gv.y));
    float mask = step(.03, boundDist);
    gv *= mask;
    return gv;
}

float4 mainImage(VertData v_in) : TARGET
{
 	float alpha = clamp(alpha_percentage * 0.01, 0.0, 1.0);
 	float speed = clamp(speed_percentage * 0.01, -10.0, 10.0);

	// Normalize coords
	//float2 uv = (v_in.uv * uv_scale + uv_offset);
	float2 uv = (float2(v_in.uv.x, (1 - v_in.uv.y)) * uv_scale + uv_offset) - .5 * (v_in.uv * uv_scale + uv_offset);// / v_in.uv.y;
	float2 mouse = (v_in.uv.xy - .5 * v_in.uv.xy) / v_in.uv.y;

	// Add some time rotation and offset
    float t = elapsed_time * speed;
    float2 time = float2(sin(t), cos(t));
    uv += time;

    // Imaginary component has to be mirrored for natural feeling rotation
    mouse.y *= -1.0;

	// Draw few layers of this to bend space
    float2 rot = cm(mouse, time);
        for (float i=1.0; i<=3.0; i++) {
        uv = iter(uv, rot, 1.5);
    }

    // Combine background with new image
    float4 background_color = image.Sample(textureSampler, v_in.uv);
    float4 col = iChannel0.Sample(textureSampler, uv);

    // Border
    if (uv.x == 0.0 && uv.y == 0.0) {
        col = float4(0,0,0,alpha);    
    } 

    // if not appling to alpha layer, set output alpha
	if (Apply_To_Alpha_Layer == false)
		col.a = alpha;

    //output color is combined with background image
	col.rgb = lerp(background_color.rgb,col.rgb,clamp(alpha, 0.0, 1.0));

	return col;
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

