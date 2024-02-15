function Get-OBSDropShadowShader {

[Alias('Set-OBSDropShadowShader','Add-OBSDropShadowShader')]
param(
# Set the shadow_offset_x of OBSDropShadowShader
[Alias('shadow_offset_x')]
[ComponentModel.DefaultBindingProperty('shadow_offset_x')]
[Int32]
$ShadowOffsetX,
# Set the shadow_offset_y of OBSDropShadowShader
[Alias('shadow_offset_y')]
[ComponentModel.DefaultBindingProperty('shadow_offset_y')]
[Int32]
$ShadowOffsetY,
# Set the shadow_blur_size of OBSDropShadowShader
[Alias('shadow_blur_size')]
[ComponentModel.DefaultBindingProperty('shadow_blur_size')]
[Int32]
$ShadowBlurSize,
# Set the notes of OBSDropShadowShader
[ComponentModel.DefaultBindingProperty('notes')]
[String]
$Notes,
# Set the shadow_color of OBSDropShadowShader
[Alias('shadow_color')]
[ComponentModel.DefaultBindingProperty('shadow_color')]
[String]
$ShadowColor,
# Set the is_alpha_premultiplied of OBSDropShadowShader
[Alias('is_alpha_premultiplied')]
[ComponentModel.DefaultBindingProperty('is_alpha_premultiplied')]
[Management.Automation.SwitchParameter]
$IsAlphaPremultiplied,
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
$shaderName = 'drop_shadow'
$ShaderNoun = 'OBSDropShadowShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Drop Shadow shader modified by Charles Fettinger 
// impose a limiter to keep from crashing the system
//Converted to OpenGL by Exeldro February 19, 2022
uniform int shadow_offset_x<
    string label = "Shadow offset x";
    string widget_type = "slider";
    int minimum = -100;
    int maximum = 100;
    int step = 1;
> = 5;
uniform int shadow_offset_y<
    string label = "Shadow offset y";
    string widget_type = "slider";
    int minimum = -100;
    int maximum = 100;
    int step = 1;
> = 5;
uniform int shadow_blur_size<
    string label = "Shadow blur size";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 15;
    int step = 1;
> = 3;
uniform string notes<
    string widget_type = "info";
> = "blur size is limited to a max of 15 to ensure GPU";

uniform float4 shadow_color;

uniform bool is_alpha_premultiplied;

float4 mainImage(VertData v_in) : TARGET
{
    int shadow_blur_size_limited = max(0, min(15, shadow_blur_size));
    int shadow_blur_samples = int(pow(float(shadow_blur_size_limited * 2 + 1), 2.0));
    
    float4 color = image.Sample(textureSampler, v_in.uv);
    float2 shadow_uv = float2(v_in.uv.x - uv_pixel_interval.x * float(shadow_offset_x), 
                              v_in.uv.y - uv_pixel_interval.y * float(shadow_offset_y));
    
    float sampled_shadow_alpha = 0.0;
    
    for (int blur_x = -shadow_blur_size_limited; blur_x <= shadow_blur_size_limited; blur_x++)
    {
        for (int blur_y = -shadow_blur_size_limited; blur_y <= shadow_blur_size_limited; blur_y++)
        {
            float2 blur_uv = shadow_uv + float2(uv_pixel_interval.x * float(blur_x), uv_pixel_interval.y * float(blur_y));
            sampled_shadow_alpha += image.Sample(textureSampler, blur_uv).a / float(shadow_blur_samples);
        }
    }
    
    float4 final_shadow_color = float4(shadow_color.r, shadow_color.g, shadow_color.b, shadow_color.a * sampled_shadow_alpha);
    return final_shadow_color * (1.0-color.a) + color * (is_alpha_premultiplied?color.a:1.0);
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

