function Get-OBSLuminance2Shader {

[Alias('Set-OBSLuminance2Shader','Add-OBSLuminance2Shader')]
param(
# Set the color of OBSLuminance2Shader
[ComponentModel.DefaultBindingProperty('color')]
[String]
$Color,
# Set the lumaMax of OBSLuminance2Shader
[ComponentModel.DefaultBindingProperty('lumaMax')]
[Single]
$LumaMax,
# Set the lumaMin of OBSLuminance2Shader
[ComponentModel.DefaultBindingProperty('lumaMin')]
[Single]
$LumaMin,
# Set the lumaMaxSmooth of OBSLuminance2Shader
[ComponentModel.DefaultBindingProperty('lumaMaxSmooth')]
[Single]
$LumaMaxSmooth,
# Set the lumaMinSmooth of OBSLuminance2Shader
[ComponentModel.DefaultBindingProperty('lumaMinSmooth')]
[Single]
$LumaMinSmooth,
# Set the invertImageColor of OBSLuminance2Shader
[ComponentModel.DefaultBindingProperty('invertImageColor')]
[Management.Automation.SwitchParameter]
$InvertImageColor,
# Set the invertAlphaChannel of OBSLuminance2Shader
[ComponentModel.DefaultBindingProperty('invertAlphaChannel')]
[Management.Automation.SwitchParameter]
$InvertAlphaChannel,
# Set the notes of OBSLuminance2Shader
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
$shaderName = 'luminance2'
$ShaderNoun = 'OBSLuminance2Shader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
//Converted to OpenGL by Q-mii & Exeldro February 25, 2022
uniform float4 color;
uniform float lumaMax<
    string label = "Luma Max";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 10.0;
    float step = 0.001;
> = 1.05;
uniform float lumaMin<
    string label = "Luma Min";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 10.0;
    float step = 0.001;
> = 0.01;
uniform float lumaMaxSmooth<
    string label = "Luma Max Smooth";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 10.0;
    float step = 0.001;
> = 0.10;
uniform float lumaMinSmooth<
    string label = "Luma Min Smooth";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 10.0;
    float step = 0.001;
> = 0.01;
uniform bool invertImageColor;
uniform bool invertAlphaChannel;
uniform string notes<
    string widget_type = "info";
> = "''luma max'' - anything above will be transparent. ''luma min'' - anything below will be transparent. ''luma(min or max)Smooth - make the transparency fade in or out by a distance. ''invert color'' - inverts the color of the screen. ''invert alpha channel'' - flips all settings on thier head, which is excellent for testing.";

float4 InvertColor(float4 rgba_in)
{	
	rgba_in.r = 1.0 - rgba_in.r;
	rgba_in.g = 1.0 - rgba_in.g;
	rgba_in.b = 1.0 - rgba_in.b;
	rgba_in.a = 1.0 - rgba_in.a;
	return rgba_in;
}

float4 mainImage(VertData v_in) : TARGET
{

	float4 rgba = image.Sample(textureSampler, v_in.uv);
    if (rgba.a > 0.0)
    {
    
    if (invertImageColor)
    {
        rgba = InvertColor(rgba);
    }
    float luminance = rgba.r * color.r * 0.299 + rgba.g * color.g * 0.587 + rgba.b * color.b * 0.114;

	//intensity = min(max(intensity,minIntensity),maxIntensity);
    float clo = smoothstep(lumaMin, lumaMin + lumaMinSmooth, luminance);
    float chi = 1. - smoothstep(lumaMax - lumaMaxSmooth, lumaMax, luminance);

    float amask = clo * chi;

    if (invertAlphaChannel)
    {
        amask = 1.0 - amask;
    }
    rgba *= color;
    rgba.a = clamp(amask, 0.0, 1.0);
        
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

