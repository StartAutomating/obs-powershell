function Get-OBSRgbvisibilityShader {

[Alias('Set-OBSRgbvisibilityShader','Add-OBSRgbvisibilityShader')]
param(
# Set the Red of OBSRgbvisibilityShader
[ComponentModel.DefaultBindingProperty('Red')]
[Single]
$Red,
# Set the Green of OBSRgbvisibilityShader
[ComponentModel.DefaultBindingProperty('Green')]
[Single]
$Green,
# Set the Blue of OBSRgbvisibilityShader
[ComponentModel.DefaultBindingProperty('Blue')]
[Single]
$Blue,
# Set the RedVisibility of OBSRgbvisibilityShader
[ComponentModel.DefaultBindingProperty('RedVisibility')]
[Single]
$RedVisibility,
# Set the GreenVisibility of OBSRgbvisibilityShader
[ComponentModel.DefaultBindingProperty('GreenVisibility')]
[Single]
$GreenVisibility,
# Set the BlueVisibility of OBSRgbvisibilityShader
[ComponentModel.DefaultBindingProperty('BlueVisibility')]
[Single]
$BlueVisibility,
# Set the notes of OBSRgbvisibilityShader
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
$shaderName = 'rgbvisibility'
$ShaderNoun = 'OBSRgbvisibilityShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// RGB visibility separation filter, created by EposVox

uniform float Red<
    string label = "Red";
    string widget_type = "slider";
    float minimum = 0.1;
    float maximum = 10.0;
    float step = 0.01;
> = 2.2;

uniform float Green<
    string label = "Green";
    string widget_type = "slider";
    float minimum = 0.1;
    float maximum = 10.0;
    float step = 0.01;
> = 2.2;

uniform float Blue<
    string label = "Blue";
    string widget_type = "slider";
    float minimum = 0.1;
    float maximum = 10.0;
    float step = 0.01;
> = 2.2;

uniform float RedVisibility<
    string label = "Red Visibility";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.01;
> = 1.0;

uniform float GreenVisibility<
    string label = "Green Visibility";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.01;
> = 1.0;

uniform float BlueVisibility<
    string label = "Blue Visibility";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.01;
> = 1.0;

uniform string notes<
    string widget_type = "info";
> = "Modify Colors to correct for gamma, use equal values for general correction.";

float4 mainImage(VertData v_in) : TARGET
{
    float4 c = image.Sample(textureSampler, v_in.uv);
    float redChannel = pow(c.r, Red) * RedVisibility;
    float greenChannel = pow(c.g, Green) * GreenVisibility;
    float blueChannel = pow(c.b, Blue) * BlueVisibility;
    
    return float4(redChannel, greenChannel, blueChannel, c.a);
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

