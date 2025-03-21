function Get-OBSBlendOpacityShader {

[Alias('Set-OBSBlendOpacityShader','Add-OBSBlendOpacityShader')]
param(
# Set the Vertical of OBSBlendOpacityShader
[ComponentModel.DefaultBindingProperty('Vertical')]
[Management.Automation.SwitchParameter]
$Vertical,
# Set the Rotational of OBSBlendOpacityShader
[ComponentModel.DefaultBindingProperty('Rotational')]
[Management.Automation.SwitchParameter]
$Rotational,
# Set the Rotation_Offset of OBSBlendOpacityShader
[Alias('Rotation_Offset')]
[ComponentModel.DefaultBindingProperty('Rotation_Offset')]
[Single]
$RotationOffset,
# Set the Opacity_Start_Percent of OBSBlendOpacityShader
[Alias('Opacity_Start_Percent')]
[ComponentModel.DefaultBindingProperty('Opacity_Start_Percent')]
[Single]
$OpacityStartPercent,
# Set the Opacity_End_Percent of OBSBlendOpacityShader
[Alias('Opacity_End_Percent')]
[ComponentModel.DefaultBindingProperty('Opacity_End_Percent')]
[Single]
$OpacityEndPercent,
# Set the Spread of OBSBlendOpacityShader
[ComponentModel.DefaultBindingProperty('Spread')]
[Single]
$Spread,
# Set the Speed of OBSBlendOpacityShader
[ComponentModel.DefaultBindingProperty('Speed')]
[Single]
$Speed,
# Set the Apply_To_Alpha_Layer of OBSBlendOpacityShader
[Alias('Apply_To_Alpha_Layer')]
[ComponentModel.DefaultBindingProperty('Apply_To_Alpha_Layer')]
[Management.Automation.SwitchParameter]
$ApplyToAlphaLayer,
# Set the Notes of OBSBlendOpacityShader
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
$shaderName = 'blend_opacity'
$ShaderNoun = 'OBSBlendOpacityShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// opacity blend shader by Charles Fettinger for obs-shaderfilter plugin 3/2019
//https://github.com/Oncorporation/obs-shaderfilter
//Converted to OpenGL by Exeldro February 14, 2022
uniform bool Vertical;
uniform bool Rotational;
uniform float Rotation_Offset<
    string label = "Rotation Offset";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 6.28318531;
    float step = 0.01;
> = 0.0;
uniform float Opacity_Start_Percent<
    string label = "Opacity Start Percent";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 1.0;
> = 0.0;
uniform float Opacity_End_Percent<
    string label = "Opacity End Percent";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 1.0;
> = 100.0;
uniform float Spread<
    string label = "Spread";
    string widget_type = "slider";
    float minimum = 0.25;
    float maximum = 10.0;
    float step = 0.01;
> = 0.5;
uniform float Speed<
    string label = "Speed";
    string widget_type = "slider";
    float minimum = -10.0;
    float maximum = 10.0;
    float step = 0.01;
> = 0.0;
uniform bool Apply_To_Alpha_Layer = true;
uniform string Notes<
    string widget_type = "info";
> = "Spread is wideness of opacity blend and is limited between .25 and 10. Edit at your own risk. Invert Start and End to Reverse effect.";

float4 mainImage(VertData v_in) : TARGET
{
	float4 point_color = image.Sample(textureSampler, v_in.uv);
	float luminance = 0.299*point_color.r+0.587*point_color.g+0.114*point_color.b;
	float4 gray = float4(luminance,luminance,luminance, 1);

	float2 lPos = (v_in.uv * uv_scale + uv_offset) / clamp(Spread, 0.25, 10.0);
	float time = (elapsed_time * clamp(Speed, -5.0, 5.0)) / clamp(Spread, 0.25, 10.0);
	float dist = distance(v_in.uv , (float2(0.99, 0.99) * uv_scale + uv_offset));

	if (point_color.a > 0.0 || Apply_To_Alpha_Layer == false)
	{
		//set opacity and direction
		float opacity = (-1 * lPos.x) * 0.5;

		if (Rotational && (Vertical == false))
		{
			float timeWithOffset = time + Rotation_Offset;
			float sine = sin(timeWithOffset);
			float cosine = cos(timeWithOffset);
			opacity = (lPos.x * cosine + lPos.y * sine) * 0.5;
		}

		if (Vertical && (Rotational == false))
		{
			opacity = (-1 * lPos.y) * 0.5;
		}

		opacity += time;
		opacity = frac(opacity);
		point_color.a = lerp(Opacity_Start_Percent * 0.01, Opacity_End_Percent * 0.01, clamp(opacity, 0.0, 1.0));
	}
	return point_color;
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

