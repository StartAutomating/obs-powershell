function Get-OBSFillColorLinearShader {

[Alias('Set-OBSFillColorLinearShader','Add-OBSFillColorLinearShader')]
param(
# Set the Fill of OBSFillColorLinearShader
[ComponentModel.DefaultBindingProperty('Fill')]
[Single]
$Fill,
# Set the Fill_Direction of OBSFillColorLinearShader
[Alias('Fill_Direction')]
[ComponentModel.DefaultBindingProperty('Fill_Direction')]
[Int32]
$FillDirection,
# Set the Fill_Color of OBSFillColorLinearShader
[Alias('Fill_Color')]
[ComponentModel.DefaultBindingProperty('Fill_Color')]
[String]
$FillColor,
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
$shaderName = 'fill_color_linear'
$ShaderNoun = 'OBSFillColorLinearShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
uniform float Fill<
    string label = "Fill";
    string widget_type = "slider";
    float minimum = 0;
    float maximum = 1;
    float step = 0.005;
>;
uniform int Fill_Direction<
  string label = "Fill from:";
  string widget_type = "select";
  int    option_0_value = 0;
  string option_0_label = "Left";
  int    option_1_value = 1;
  string option_1_label = "Right";  
  int    option_2_value = 2;
  string option_2_label = "Top";  
  int    option_3_value = 3;
  string option_3_label = "Bottom";
> = 0;
uniform float4 Fill_Color;

float4 mainImage(VertData v_in) : TARGET
{
    bool is_inside_fill = true;  
    
    // Check if the pixel is within the specified "fill width" on the left side
    if(Fill_Direction == 0){
        is_inside_fill = v_in.uv.x > Fill;
    }
    if(Fill_Direction == 1)
    {
        is_inside_fill = v_in.uv.x < (1.0 - Fill);
    }
    if(Fill_Direction == 2)
    {
        is_inside_fill = v_in.uv.y > Fill;
    }   
    if(Fill_Direction == 3)
    {
        is_inside_fill = v_in.uv.y < (1.0 - Fill);
    }
    
    // Invert is_inside_fill
    is_inside_fill = !is_inside_fill;
    
    // If inside the "fill," make the pixel selected colour; otherwise, use the original image color
    return is_inside_fill ? Fill_Color : image.Sample(textureSampler, v_in.uv);
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

