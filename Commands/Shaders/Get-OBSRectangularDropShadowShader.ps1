function Get-OBSRectangularDropShadowShader {

[Alias('Set-OBSRectangularDropShadowShader','Add-OBSRectangularDropShadowShader')]
param(
# Set the shadow_offset_x of OBSRectangularDropShadowShader
[Alias('shadow_offset_x')]
[ComponentModel.DefaultBindingProperty('shadow_offset_x')]
[Int32]
$ShadowOffsetX,
# Set the shadow_offset_y of OBSRectangularDropShadowShader
[Alias('shadow_offset_y')]
[ComponentModel.DefaultBindingProperty('shadow_offset_y')]
[Int32]
$ShadowOffsetY,
# Set the shadow_blur_size of OBSRectangularDropShadowShader
[Alias('shadow_blur_size')]
[ComponentModel.DefaultBindingProperty('shadow_blur_size')]
[Int32]
$ShadowBlurSize,
# Set the shadow_color of OBSRectangularDropShadowShader
[Alias('shadow_color')]
[ComponentModel.DefaultBindingProperty('shadow_color')]
[String]
$ShadowColor,
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
$shaderName = 'rectangular_drop_shadow'
$ShaderNoun = 'OBSRectangularDropShadowShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
//Converted to OpenGL by Exeldro February 22, 2022
uniform int shadow_offset_x<
    string label = "shadow offset x";
    string widget_type = "slider";
    int minimum = -100;
    int maximum = 100;
    int step = 1;
>;
uniform int shadow_offset_y<
    string label = "shadow offset y";
    string widget_type = "slider";
    int minimum = -100;
    int maximum = 100;
    int step = 1;
>;
uniform int shadow_blur_size<
    string label = "shadow blur size";
    string widget_type = "slider";
    int minimum = 1;
    int maximum = 100;
    int step = 1;
> = 1;

uniform float4 shadow_color;

float4 mainImage(VertData v_in) : TARGET
{
    int shadow_blur_samples = int(pow(shadow_blur_size * 2 + 1, 2));
    
    float4 color = image.Sample(textureSampler, v_in.uv);
    float2 shadow_uv = float2(v_in.uv.x - uv_pixel_interval.x * int(shadow_offset_x), 
                              v_in.uv.y - uv_pixel_interval.y * int(shadow_offset_y));
                              
    float start_of_overlap_x = max(0, shadow_uv.x - shadow_blur_size * uv_pixel_interval.x);
    float end_of_overlap_x = min(1, shadow_uv.x + shadow_blur_size * uv_pixel_interval.x);
    float x_proportion = (end_of_overlap_x - start_of_overlap_x) / (2 * shadow_blur_size * uv_pixel_interval.x);
    
    float start_of_overlap_y = max(0, shadow_uv.y - shadow_blur_size * uv_pixel_interval.y);
    float end_of_overlap_y = min(1, shadow_uv.y + shadow_blur_size * uv_pixel_interval.y);
    float y_proportion = (end_of_overlap_y - start_of_overlap_y) / (2 * shadow_blur_size * uv_pixel_interval.y);
    
    float4 final_shadow_color = float4(shadow_color.r, shadow_color.g, shadow_color.b, shadow_color.a * x_proportion * y_proportion);
    
    return final_shadow_color * (1-color.a) + color;
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

