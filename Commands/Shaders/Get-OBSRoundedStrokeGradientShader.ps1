function Get-OBSRoundedStrokeGradientShader {

[Alias('Set-OBSRoundedStrokeGradientShader','Add-OBSRoundedStrokeGradientShader')]
param(
# Set the corner_radius of OBSRoundedStrokeGradientShader
[Alias('corner_radius')]
[ComponentModel.DefaultBindingProperty('corner_radius')]
[Int32]
$CornerRadius,
# Set the border_thickness of OBSRoundedStrokeGradientShader
[Alias('border_thickness')]
[ComponentModel.DefaultBindingProperty('border_thickness')]
[Int32]
$BorderThickness,
# Set the minimum_alpha_percent of OBSRoundedStrokeGradientShader
[Alias('minimum_alpha_percent')]
[ComponentModel.DefaultBindingProperty('minimum_alpha_percent')]
[Int32]
$MinimumAlphaPercent,
# Set the rotation_speed of OBSRoundedStrokeGradientShader
[Alias('rotation_speed')]
[ComponentModel.DefaultBindingProperty('rotation_speed')]
[Int32]
$RotationSpeed,
# Set the border_colorL of OBSRoundedStrokeGradientShader
[Alias('border_colorL')]
[ComponentModel.DefaultBindingProperty('border_colorL')]
[String]
$BorderColorL,
# Set the border_colorR of OBSRoundedStrokeGradientShader
[Alias('border_colorR')]
[ComponentModel.DefaultBindingProperty('border_colorR')]
[String]
$BorderColorR,
# Set the center_width of OBSRoundedStrokeGradientShader
[Alias('center_width')]
[ComponentModel.DefaultBindingProperty('center_width')]
[Int32]
$CenterWidth,
# Set the center_height of OBSRoundedStrokeGradientShader
[Alias('center_height')]
[ComponentModel.DefaultBindingProperty('center_height')]
[Int32]
$CenterHeight,
# Set the notes of OBSRoundedStrokeGradientShader
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
$shaderName = 'rounded_stroke_gradient'
$ShaderNoun = 'OBSRoundedStrokeGradientShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
//rounded rectange shader from https://raw.githubusercontent.com/exeldro/obs-lua/master/rounded_rect.shader
//modified slightly by Surn 
uniform int corner_radius<
    string label = "Corner radius";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 200;
    int step = 1;
>;
uniform int border_thickness<
    string label = "Border thickness";
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
uniform int rotation_speed<
    string label = "rotation speed";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
>;
uniform float4 border_colorL;
uniform float4 border_colorR;
//uniform float color_spread = 2.0;
uniform int center_width<
    string label = "center width";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 50;
uniform int center_height<
    string label = "center height";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 50;
uniform string notes<
    string widget_type = "info";
> = "Outlines the opaque areas with a rounded border. Default Minimum Alpha Percent is 50%, lowering will reveal more";

// float3 hsv2rgb(float3 c)
// {
//     float4 K = float4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
//     float3 p = abs(frac(c.xxx + K.xyz) * 6.0 - K.www);
//     return c.z * lerp(K.xxx, saturate(p - K.xxx), c.y);
// }

float mod(float x, float y)
{
    return x - y * floor(x/y);
}

float4 gradient(float c) {
    c = mod(c , 2.0);
    if(c < 0.0f){
        c = c * -1.0;
    }
    if(c > 1.0){
        c = 1.0 - c;
        if(c < 0.0f){
            c = c + 1.0;
        }
    }
    return lerp(border_colorL, border_colorR, c);
}

float4 getBorderColor(float2 toCenter){
    float angle = atan2(toCenter.y ,toCenter.x );
	float angleMod = (elapsed_time * mod(float(rotation_speed) , 18.0)) / 9;
	return gradient((angle / 3.14159265f) + angleMod);
}

float4 mainImage(VertData v_in) : TARGET
{
    float2 st = v_in.uv * uv_scale;
    float2 center_pixel_coordinates = float2((float(center_width) * 0.01), (float(center_height) * 0.01) );
    float2 toCenter = center_pixel_coordinates - st;

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
        return output_color;
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
            return getBorderColor(toCenter);
        }
        else
        {
            return output_color;
        }
    }
    if (closedEdgeY == 0)
    {
        if (closedEdgeX < border_thickness)
        {
            return getBorderColor(toCenter);
        }
        else
        {
            return output_color;
        }
    }

    float d = distance(float2(closedEdgeX, closedEdgeY), float2(corner_radius, corner_radius));
    if (d < corner_radius)
    {
        if (corner_radius - d < border_thickness)
        {
            return getBorderColor(toCenter);
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

