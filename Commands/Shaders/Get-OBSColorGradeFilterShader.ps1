function Get-OBSColorGradeFilterShader {

[Alias('Set-OBSColorGradeFilterShader','Add-OBSColorGradeFilterShader')]
param(
# Set the notes of OBSColorGradeFilterShader
[ComponentModel.DefaultBindingProperty('notes')]
[String]
$Notes,
# Set the lut of OBSColorGradeFilterShader
[ComponentModel.DefaultBindingProperty('lut')]
[String]
$Lut,
# Set the lut_amount_percent of OBSColorGradeFilterShader
[Alias('lut_amount_percent')]
[ComponentModel.DefaultBindingProperty('lut_amount_percent')]
[Int32]
$LutAmountPercent,
# Set the lut_scale_percent of OBSColorGradeFilterShader
[Alias('lut_scale_percent')]
[ComponentModel.DefaultBindingProperty('lut_scale_percent')]
[Int32]
$LutScalePercent,
# Set the lut_offset_percent of OBSColorGradeFilterShader
[Alias('lut_offset_percent')]
[ComponentModel.DefaultBindingProperty('lut_offset_percent')]
[Int32]
$LutOffsetPercent,
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
$shaderName = 'color_grade_filter'
$ShaderNoun = 'OBSColorGradeFilterShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Color Grade Filter by Charles Fettinger for obs-shaderfilter plugin 4/2020
//https://github.com/Oncorporation/obs-shaderfilter
//OBS messed up the LUT system, this is basically the old LUT system
//Converted to OpenGL by Q-mii & Exeldro February 25, 2022
uniform string notes<
    string widget_type = "info";
> = "Choose LUT, Default LUT amount is 100, scale = 100, offset = 0. Valid values: -200 to 200";

uniform texture2d lut<
    string label = "LUT";
>;
uniform int lut_amount_percent<
    string label = "LUT amount percentage";
    string widget_type = "slider";
    int minimum = -200;
    int maximum = 200;
    int step = 1;
> = 100;
uniform int lut_scale_percent<
    string label = "LUT scale percentage";
    string widget_type = "slider";
    int minimum = -200;
    int maximum = 200;
    int step = 1;
> = 100;
uniform int lut_offset_percent<
    string label = "LUT offset percentage";
    string widget_type = "slider";
    int minimum = -200;
    int maximum = 200;
    int step = 1;
> = 0;


float4 mainImage(VertData v_in) : TARGET
{
	float lut_amount = clamp(lut_amount_percent *.01, -2.0, 2.0);
	float lut_scale = clamp(lut_scale_percent *.01,-2.0, 2.0);
	float lut_offset = clamp(lut_offset_percent *.01,-2.0, 2.0);

	float4 textureColor = image.Sample(textureSampler, v_in.uv);
	float lumaLevel = textureColor.r * 0.2126 +  textureColor.g * 0.7152 + textureColor.b * 0.0722;
	float blueColor = float(lumaLevel);//textureColor.b * 63.0

	float2 quad1;
	quad1.y = floor(floor(float(blueColor)) / 8.0);
	quad1.x = floor(float(blueColor)) - (quad1.y * 8.0);

	float2 quad2;
	quad2.y = floor(ceil(float(blueColor)) / 8.0);
	quad2.x = ceil(float(blueColor)) - (quad2.y * 8.0);

	float2 texPos1;
	texPos1.x = (quad1.x * 0.125) + 0.5/512.0 + ((0.125 - 1.0/512.0) * textureColor.r);
	texPos1.y = (quad1.y * 0.125) + 0.5/512.0 + ((0.125 - 1.0/512.0) * textureColor.g);

	float2 texPos2;
	texPos2.x = (quad2.x * 0.125) + 0.5/512.0 + ((0.125 - 1.0/512.0) * textureColor.r);
	texPos2.y = (quad2.y * 0.125) + 0.5/512.0 + ((0.125 - 1.0/512.0) * textureColor.g);

	float4 newColor1 = lut.Sample(textureSampler, texPos1);
	newColor1.rgb = newColor1.rgb * lut_scale + lut_offset;
	float4 newColor2 = lut.Sample(textureSampler, texPos2);
	newColor2.rgb = newColor2.rgb * lut_scale + lut_offset;
	float4 luttedColor = lerp(newColor1, newColor2, frac(float(blueColor)));

	float4 final_color = lerp(textureColor, luttedColor, lut_amount);
	return float4(final_color.rgb, textureColor.a);
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

