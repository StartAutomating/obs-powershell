function Get-OBSGlassShader {

[Alias('Set-OBSGlassShader','Add-OBSGlassShader')]
param(
# Set the Alpha_Percent of OBSGlassShader
[Alias('Alpha_Percent')]
[ComponentModel.DefaultBindingProperty('Alpha_Percent')]
[Single]
$AlphaPercent,
# Set the Offset_Amount of OBSGlassShader
[Alias('Offset_Amount')]
[ComponentModel.DefaultBindingProperty('Offset_Amount')]
[Single]
$OffsetAmount,
# Set the xSize of OBSGlassShader
[ComponentModel.DefaultBindingProperty('xSize')]
[Int32]
$XSize,
# Set the ySize of OBSGlassShader
[ComponentModel.DefaultBindingProperty('ySize')]
[Int32]
$YSize,
# Set the Reflection_Offset of OBSGlassShader
[Alias('Reflection_Offset')]
[ComponentModel.DefaultBindingProperty('Reflection_Offset')]
[Int32]
$ReflectionOffset,
# Set the Horizontal_Border of OBSGlassShader
[Alias('Horizontal_Border')]
[ComponentModel.DefaultBindingProperty('Horizontal_Border')]
[Management.Automation.SwitchParameter]
$HorizontalBorder,
# Set the Border_Offset of OBSGlassShader
[Alias('Border_Offset')]
[ComponentModel.DefaultBindingProperty('Border_Offset')]
[Single]
$BorderOffset,
# Set the Border_Color of OBSGlassShader
[Alias('Border_Color')]
[ComponentModel.DefaultBindingProperty('Border_Color')]
[String]
$BorderColor,
# Set the Glass_Color of OBSGlassShader
[Alias('Glass_Color')]
[ComponentModel.DefaultBindingProperty('Glass_Color')]
[String]
$GlassColor,
# Set the notes of OBSGlassShader
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
$shaderName = 'glass'
$ShaderNoun = 'OBSGlassShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Glass shader by Charles Fettinger for obs-shaderfilter plugin 4/2019
//https://github.com/Oncorporation/obs-shaderfilter
//Converted to OpenGl by Q-mii & Exeldro February 25, 2022
uniform float Alpha_Percent<
    string label = "Alpha Percent";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 0.1;
> = 100.0;
uniform float Offset_Amount<
    string label = "Offset Amount";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 10.0;
    float step = 0.01;
> = 0.8;
uniform int xSize<
    string label = "x Size";
    string widget_type = "slider";
    int minimum = 1;
    int maximum = 100;
    int step = 1;
> = 8;
uniform int ySize<
    string label = "y Size";
    string widget_type = "slider";
    int minimum = 1;
    int maximum = 100;
    int step = 1;
> = 8;
uniform int Reflection_Offset<
    string label = "Reflection Offset";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 2;
uniform bool Horizontal_Border;
uniform float Border_Offset<
    string label = "Border Offset";
    string widget_type = "slider";
    float minimum = -0.01;
    float maximum = 1.01;
    float step = 0.01;
> = 0.5;
uniform float4 Border_Color = {.8,.5,1.0,1.0};
uniform float4 Glass_Color;
uniform string notes<
    string widget_type = "info";
> = "xSize, ySize are for distortion. Offset Amount and Reflection Offset change glass properties. Alpha is Opacity of overlay.";

float mod(float a, float b){
	float d = a / b;
	return (d-floor(d))*b;
}

float4 mainImage(VertData v_in) : TARGET
{
	

	int xSubPixel = int(mod((v_in.uv.x * uv_size.x) , float(clamp(xSize,1,100))));
	int ySubPixel = int(mod((v_in.uv.y * uv_size.y) , float(clamp(ySize,1,100))));
	float2 offsets = float2(Offset_Amount * xSubPixel / uv_size.x, Offset_Amount * ySubPixel / uv_size.y);
	float2 uv = v_in.uv + offsets;
	float2 uv2 = float2(uv.x + (Reflection_Offset / uv_size.x),uv.y + (Reflection_Offset / uv_size.y));

	float4 rgba = image.Sample(textureSampler, v_in.uv);
	float4 rgba_output = float4(rgba.rgb * Border_Color.rgb, rgba.a);
	rgba = image.Sample(textureSampler, uv);
	float4 rgba_glass = image.Sample(textureSampler, uv2);
	
	float uv_compare = v_in.uv.x;
	if (Horizontal_Border)
		uv_compare = v_in.uv.y;

	if (uv_compare < (Border_Offset - 0.005))
	{
			rgba_output = (rgba + rgba_glass) *.5 * Glass_Color;
	}
	else if (uv_compare >= (Border_Offset + 0.005))
	{
		rgba_output = image.Sample(textureSampler, v_in.uv);
	}
	return lerp(rgba,rgba_output,(Alpha_Percent * 0.01));
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

