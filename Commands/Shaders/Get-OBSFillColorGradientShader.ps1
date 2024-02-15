function Get-OBSFillColorGradientShader {

[Alias('Set-OBSFillColorGradientShader','Add-OBSFillColorGradientShader')]
param(
# Set the Fill of OBSFillColorGradientShader
[ComponentModel.DefaultBindingProperty('Fill')]
[Single]
$Fill,
# Set the Gradient_Width of OBSFillColorGradientShader
[Alias('Gradient_Width')]
[ComponentModel.DefaultBindingProperty('Gradient_Width')]
[Single]
$GradientWidth,
# Set the Gradient_Offset of OBSFillColorGradientShader
[Alias('Gradient_Offset')]
[ComponentModel.DefaultBindingProperty('Gradient_Offset')]
[Single]
$GradientOffset,
# Set the Fill_Direction of OBSFillColorGradientShader
[Alias('Fill_Direction')]
[ComponentModel.DefaultBindingProperty('Fill_Direction')]
[Int32]
$FillDirection,
# Set the Fill_Color of OBSFillColorGradientShader
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
$shaderName = 'fill_color_gradient'
$ShaderNoun = 'OBSFillColorGradientShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
uniform float Fill<
    string label = "Fill";
    string widget_type = "slider";
    float minimum = 0;
    float maximum = 1;
    float step = 0.005;
> = 0.500;

uniform float Gradient_Width<
    string label = "Gradient Width";
    string widget_type = "slider";
    float minimum = 0;
    float maximum = 0.15;  // Adjust the maximum value as needed
    float step = 0.01;
> = 0.05;

uniform float Gradient_Offset<
    string label = "Gradient Offset";
    string widget_type = "slider";
    float minimum = 0;
    float maximum = 0.100;  // Adjust the maximum value as needed
    float step = 0.005;
> = 0.00;

uniform int Fill_Direction<
    string label = "Fill from:";
    string widget_type = "select";
    int option_0_value = 0;
    string option_0_label = "Left";
    int option_1_value = 1;
    string option_1_label = "Right";  
    int option_2_value = 2;
    string option_2_label = "Bottom";  
    int option_3_value = 3;
    string option_3_label = "Top";
> = 0;

uniform float4 Fill_Color;

float4 mainImage(VertData v_in) : TARGET
{
    float distanceToEdge = 0.0;

    // Calculate distance to the fill edge based on the selected direction
    if (Fill_Direction == 0)
        distanceToEdge = Fill - v_in.uv.x;
    else if (Fill_Direction == 1)
        distanceToEdge = v_in.uv.x - (1.0 - Fill);
    else if (Fill_Direction == 2)
        distanceToEdge = v_in.uv.y - (1.0 - Fill);
    else if (Fill_Direction == 3)
        distanceToEdge = Fill - v_in.uv.y;

    // Calculate the gradient factor based on the distance to the edge and the gradient width
    float gradientOffset = (Fill == 0.0) ? 0.0 : (Fill == 1.0 ? 0.0 : Gradient_Offset);
    float gradientWidth = (Fill == 0.0 || Fill == 1.0) ? 0.0 : Gradient_Width;

    // Adjust distanceToEdge by the Gradient_Offset
    distanceToEdge += gradientOffset;

    // Normalize the distance to be between 0 and 1
    distanceToEdge = saturate(distanceToEdge);

    // float gradientWidth = Fill < 1.0 ? Gradient_Width : Gradient_Width * (1.0 - Fill);
    // float gradientFactor = smoothstep(0.0, gradientWidth, distanceToEdge);
    float gradientFactor = clamp(distanceToEdge / gradientWidth, 0.0, 1.0);

    // Blend between the fill color and the original image color using the gradient factor
    float4 finalColor = lerp(image.Sample(textureSampler, v_in.uv), Fill_Color, gradientFactor);

    return finalColor;
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

