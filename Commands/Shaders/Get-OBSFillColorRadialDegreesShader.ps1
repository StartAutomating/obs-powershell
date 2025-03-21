function Get-OBSFillColorRadialDegreesShader {

[Alias('Set-OBSFillColorRadialDegreesShader','Add-OBSFillColorRadialDegreesShader')]
param(
# Set the Fill_Direction of OBSFillColorRadialDegreesShader
[Alias('Fill_Direction')]
[ComponentModel.DefaultBindingProperty('Fill_Direction')]
[Int32]
$FillDirection,
# Set the Fill of OBSFillColorRadialDegreesShader
[ComponentModel.DefaultBindingProperty('Fill')]
[Single]
$Fill,
# Set the Start_Angle of OBSFillColorRadialDegreesShader
[Alias('Start_Angle')]
[ComponentModel.DefaultBindingProperty('Start_Angle')]
[Single]
$StartAngle,
# Set the Offset_X of OBSFillColorRadialDegreesShader
[Alias('Offset_X')]
[ComponentModel.DefaultBindingProperty('Offset_X')]
[Single]
$OffsetX,
# Set the Offset_Y of OBSFillColorRadialDegreesShader
[Alias('Offset_Y')]
[ComponentModel.DefaultBindingProperty('Offset_Y')]
[Single]
$OffsetY,
# Set the Fill_Color of OBSFillColorRadialDegreesShader
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
$shaderName = 'fill_color_radial_degrees'
$ShaderNoun = 'OBSFillColorRadialDegreesShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
#define PI 3.141592653589793238

uniform int Fill_Direction<
    string label = "Fill Direction";
    string widget_type = "select";
    int option_0_value = 0;
    string option_0_label = "Clockwise";
    int option_1_value = 1;
    string option_1_label = "Counter-Clockwise";
> = 0;

uniform float Fill<
    string label = "Fill";
    string widget_type = "slider";
    float minimum = 0;
    float maximum = 360;
    float step = 1.00000;
>;

uniform float Start_Angle<
    string label = "Start Angle";
    string widget_type = "slider";
    float minimum = 0;
    float maximum = 720;
    float step = 1.00000;
> = 360.0;

uniform float Offset_X<
    string label = "Offset X";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.01;
> = 0.0;

uniform float Offset_Y<
    string label = "Offset Y";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.01;
> = 0.0;

uniform float4 Fill_Color;

float4 mainImage(VertData v_in) : TARGET
{
    // Calculate the center of the screen based on aspect ratio
    float aspectRatioX = uv_size.x / uv_size.y;
    float2 center = float2(0.5 * aspectRatioX + Offset_X, 0.5 + Offset_Y);

    // Normalize the UV coordinates based on aspect ratio
    float2 normalizedUV = v_in.uv * float2(aspectRatioX, 1.0);

    // Calculate the direction vector from the center to the current pixel
    float2 dir = normalizedUV - center;

    // Calculate the angle in radians
    float angle = atan2(dir.y, dir.x);

    // Convert angle from radians to degrees
    angle = degrees(angle);

    // Offset the angle to start from the specified starting angle
    angle += Start_Angle + 90.0; // Subtract 90 degrees to start at 12 o''clock
    if (angle >= 360.0)
        angle -= 360.0;

    // Adjust the angle based on the selected fill direction
    if (Fill_Direction == 1) {
        // Counter-clockwise fill
        angle = 360.0 - angle;
    }

    // Ensure angle is within [0, 360] range
    if (angle < 0.0)
        angle += 360.0;
    else if (angle >= 360.0)
        angle -= 360.0;

    // Check if the angle is within the specified "fill width"
    bool is_inside_fill = angle < Fill;

    // If inside the "fill," make the pixel selected color; otherwise, use the original image color
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

