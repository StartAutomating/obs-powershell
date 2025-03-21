function Get-OBSRoundedStrokeShader {

[Alias('Set-OBSRoundedStrokeShader','Add-OBSRoundedStrokeShader')]
param(
# Set the corner_radius of OBSRoundedStrokeShader
[Alias('corner_radius')]
[ComponentModel.DefaultBindingProperty('corner_radius')]
[Int32]
$CornerRadius,
# Set the border_thickness of OBSRoundedStrokeShader
[Alias('border_thickness')]
[ComponentModel.DefaultBindingProperty('border_thickness')]
[Int32]
$BorderThickness,
# Set the minimum_alpha_percent of OBSRoundedStrokeShader
[Alias('minimum_alpha_percent')]
[ComponentModel.DefaultBindingProperty('minimum_alpha_percent')]
[Int32]
$MinimumAlphaPercent,
# Set the border_color of OBSRoundedStrokeShader
[Alias('border_color')]
[ComponentModel.DefaultBindingProperty('border_color')]
[String]
$BorderColor,
# Set the notes of OBSRoundedStrokeShader
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
$shaderName = 'rounded_stroke'
$ShaderNoun = 'OBSRoundedStrokeShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
//rounded rectange shader from https://raw.githubusercontent.com/exeldro/obs-lua/master/rounded_rect.shader
//modified slightly by Surn 
//Converted to OpenGl by Q-mii & Exeldro February 21, 2022
uniform int corner_radius<
    string label = "Corner radius";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 200;
    int step = 1;
>;
uniform int border_thickness<
    string label = "border thickness";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
>;
uniform int minimum_alpha_percent<
    string label = "Minimum alpha percent";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 50;
uniform float4 border_color;
uniform string notes<
    string widget_type = "info";
> = "Outlines the opaque areas with a rounded border. Default Minimum Alpha Percent is 50%, lowering will reveal more";

float4 mainImage(VertData v_in) : TARGET
{
    float min_alpha = clamp(minimum_alpha_percent * .01, -1.0, 101.0);
    float4 output_color = image.Sample(textureSampler, v_in.uv);
    if (output_color.a < min_alpha)
    {
        return float4(0.0, 0.0, 0.0, 0.0);
    }
    int closedEdgeX = 0;
    if (image.Sample(textureSampler, v_in.uv + float2(corner_radius * uv_pixel_interval.x, 0)).a < min_alpha)
    {
        closedEdgeX = corner_radius;
    }
    else if (image.Sample(textureSampler, v_in.uv + float2(-corner_radius * uv_pixel_interval.x, 0)).a < min_alpha)
    {
        closedEdgeX = corner_radius;
    }
    int closedEdgeY = 0;
    if (image.Sample(textureSampler, v_in.uv + float2(0, corner_radius * uv_pixel_interval.y)).a < min_alpha)
    {
        closedEdgeY = corner_radius;
    }
    else if (image.Sample(textureSampler, v_in.uv + float2(0, -corner_radius * uv_pixel_interval.y)).a < min_alpha)
    {
        closedEdgeY = corner_radius;
    }
    if (closedEdgeX == 0 && closedEdgeY == 0)
    {
        return float4(output_color);
    }
    if (closedEdgeX != 0)
    {
        [loop]
        for (int x = 1; x < corner_radius; x++)
        {
            if (image.Sample(textureSampler, v_in.uv + float2(x * uv_pixel_interval.x, 0)).a < min_alpha)
            {
                closedEdgeX = x;
                break;
            }
            if (image.Sample(textureSampler, v_in.uv + float2(-x * uv_pixel_interval.x, 0)).a < min_alpha)
            {
                closedEdgeX = x;
                break;
            }
        }
    }
    if (closedEdgeY != 0)
    {
        [loop]
        for (int y = 1; y < corner_radius; y++)
        {
            if (image.Sample(textureSampler, v_in.uv + float2(0, y * uv_pixel_interval.y)).a < min_alpha)
            {
                closedEdgeY = y;
                break;
            }
            if (image.Sample(textureSampler, v_in.uv + float2(0, -y * uv_pixel_interval.y)).a < min_alpha)
            {
                closedEdgeY = y;
                break;
            }
        }
    }
    if (closedEdgeX == 0)
    {
        if (closedEdgeY < border_thickness)
        {
            return border_color;
        }
        else
        {
            return float4(output_color);
        }
    }
    if (closedEdgeY == 0)
    {
        if (closedEdgeX < border_thickness)
        {
            return border_color;
        }
        else
        {
            return float4(output_color);
        }
    }

    float d = distance(float2(closedEdgeX, closedEdgeY), float2(corner_radius, corner_radius));
    if (d < corner_radius)
    {
        if (corner_radius - d < border_thickness)
        {
            return border_color;
        }
        else
        {
            return output_color;
        }
    }
    return float4(0.0, 0.0, 0.0, 0.0);
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

