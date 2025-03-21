function Get-OBSLuminanceShader {

[Alias('Set-OBSLuminanceShader','Add-OBSLuminanceShader')]
param(
# Set the color of OBSLuminanceShader
[ComponentModel.DefaultBindingProperty('color')]
[String]
$Color,
# Set the level of OBSLuminanceShader
[ComponentModel.DefaultBindingProperty('level')]
[Single]
$Level,
# Set the invertImageColor of OBSLuminanceShader
[ComponentModel.DefaultBindingProperty('invertImageColor')]
[Management.Automation.SwitchParameter]
$InvertImageColor,
# Set the invertAlphaChannel of OBSLuminanceShader
[ComponentModel.DefaultBindingProperty('invertAlphaChannel')]
[Management.Automation.SwitchParameter]
$InvertAlphaChannel,
# Set the notes of OBSLuminanceShader
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
$shaderName = 'Luminance'
$ShaderNoun = 'OBSLuminanceShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
//Converted to OpenGL by Exeldro February 22, 2022
uniform float4 color;
uniform float level<
    string label = "Level";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 10.0;
    float step = 0.01;
> = 1.0;
uniform bool invertImageColor;
uniform bool invertAlphaChannel;

uniform string notes<
    string widget_type = "info";
> = "''color'' - the color to add to the original image. Multiplies the color against the original color giving it a tint. White represents no tint. ''invertImageColor'' - - inverts the color of the screen, great for testing and fine tuning. ''level'' - transparency amount modifier where 1.0 = base luminance  (recommend 0.00 - 10.00). ''invertAlphaChannel'' - flip what is transparent from darks (default) to lights";

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
    float intensity = rgba.r * color.r * 0.299 + rgba.g * color.g * 0.587 + rgba.b * color.b * 0.114;

    //intensity = min(max(intensity,minIntensity),maxIntensity);


    if (invertAlphaChannel)
    {
        intensity = 1.0 - intensity;
    }
    rgba *= color;
    rgba.a = clamp((intensity * level), 0.0, 1.0);
	
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

