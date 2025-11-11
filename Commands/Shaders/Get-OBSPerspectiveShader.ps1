function Get-OBSPerspectiveShader {

[Alias('Set-OBSPerspectiveShader','Add-OBSPerspectiveShader')]
param(
# Set the angle_x of OBSPerspectiveShader
[Alias('angle_x')]
[ComponentModel.DefaultBindingProperty('angle_x')]
[Single]
$AngleX,
# Set the angle_y of OBSPerspectiveShader
[Alias('angle_y')]
[ComponentModel.DefaultBindingProperty('angle_y')]
[Single]
$AngleY,
# Set the angle_z of OBSPerspectiveShader
[Alias('angle_z')]
[ComponentModel.DefaultBindingProperty('angle_z')]
[Single]
$AngleZ,
# Set the perspective of OBSPerspectiveShader
[ComponentModel.DefaultBindingProperty('perspective')]
[Single]
$Perspective,
# Set the border_color of OBSPerspectiveShader
[Alias('border_color')]
[ComponentModel.DefaultBindingProperty('border_color')]
[String]
$BorderColor,
# Set the show_border of OBSPerspectiveShader
[Alias('show_border')]
[ComponentModel.DefaultBindingProperty('show_border')]
[Management.Automation.SwitchParameter]
$ShowBorder,
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
$shaderName = 'perspective'
$ShaderNoun = 'OBSPerspectiveShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Perspective Transform Shader for OBS
// Allows adjustable 3D perspective effects
// Usage: Add as filter in OBS via ShaderFilter plugin

uniform float angle_x<
    string label = "X Rotation";
    string widget_type = "slider";
    float minimum = -180.0;
    float maximum = 180.0;
    float step = 1.0;
> = 0.0;

uniform float angle_y<
    string label = "Y Rotation";
    string widget_type = "slider";
    float minimum = -180.0;
    float maximum = 180.0;
    float step = 1.0;
> = 0.0;

uniform float angle_z<
    string label = "Z Rotation";
    string widget_type = "slider";
    float minimum = -180.0;
    float maximum = 180.0;
    float step = 1.0;
> = 0.0;

uniform float perspective<
    string label = "Perspective Strength";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.01;
> = 0.5;

uniform float4 border_color<
    string label = "Border Color";
> = {0.0, 0.0, 0.0, 1.0};

uniform bool show_border<
    string label = "Show Border";
> = true;

float4x4 rotationMatrix(float3 angles)
{
    float radX = radians(angles.x);
    float radY = radians(angles.y);
    float radZ = radians(angles.z);
    
    float sinX = sin(radX);
    float cosX = cos(radX);
    float sinY = sin(radY);
    float cosY = cos(radY);
    float sinZ = sin(radZ);
    float cosZ = cos(radZ);
    
    return float4x4(
        cosY*cosZ, -cosY*sinZ, sinY, 0,
        sinX*sinY*cosZ + cosX*sinZ, -sinX*sinY*sinZ + cosX*cosZ, -sinX*cosY, 0,
        -cosX*sinY*cosZ + sinX*sinZ, cosX*sinY*sinZ + sinX*cosZ, cosX*cosY, 0,
        0, 0, 0, 1
    );
}

float4 mainImage(VertData v_in) : TARGET
{
    float2 uv = v_in.uv;
    
    // Center coordinates
    float2 center = float2(0.5, 0.5);
    uv -= center;
    
    // Apply perspective
    float perspectiveFactor = 1.0 / (1.0 + perspective * length(uv));
    uv *= perspectiveFactor;
    
    // Create rotation matrix
    float3 angles = float3(angle_x, angle_y, angle_z);
    float4x4 rotMat = rotationMatrix(angles);
    
    // Apply transformation
    float4 transformed = mul(rotMat, float4(uv.x, uv.y, 0, 1));
    
    // Restore center position
    uv = transformed.xy + center;
    
    // Sample texture with border handling
    if (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0) {
        return show_border ? border_color : float4(0, 0, 0, 0);
    }
    
    return image.Sample(textureSampler, uv);
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

