function Get-OBSTwoPassDropShadowShader {

[Alias('Set-OBSTwoPassDropShadowShader','Add-OBSTwoPassDropShadowShader')]
param(
# Set the ViewProj of OBSTwoPassDropShadowShader
[ComponentModel.DefaultBindingProperty('ViewProj')]
[Single[][]]
$ViewProj,
# Set the image of OBSTwoPassDropShadowShader
[ComponentModel.DefaultBindingProperty('image')]
[String]
$Image,
# Set the elapsed_time of OBSTwoPassDropShadowShader
[Alias('elapsed_time')]
[ComponentModel.DefaultBindingProperty('elapsed_time')]
[Single]
$ElapsedTime,
# Set the uv_offset of OBSTwoPassDropShadowShader
[Alias('uv_offset')]
[ComponentModel.DefaultBindingProperty('uv_offset')]
[Single[]]
$UvOffset,
# Set the uv_scale of OBSTwoPassDropShadowShader
[Alias('uv_scale')]
[ComponentModel.DefaultBindingProperty('uv_scale')]
[Single[]]
$UvScale,
# Set the uv_pixel_interval of OBSTwoPassDropShadowShader
[Alias('uv_pixel_interval')]
[ComponentModel.DefaultBindingProperty('uv_pixel_interval')]
[Single[]]
$UvPixelInterval,
# Set the rand_f of OBSTwoPassDropShadowShader
[Alias('rand_f')]
[ComponentModel.DefaultBindingProperty('rand_f')]
[Single]
$RandF,
# Set the uv_size of OBSTwoPassDropShadowShader
[Alias('uv_size')]
[ComponentModel.DefaultBindingProperty('uv_size')]
[Single[]]
$UvSize,
# Set the shadow_offset_x of OBSTwoPassDropShadowShader
[Alias('shadow_offset_x')]
[ComponentModel.DefaultBindingProperty('shadow_offset_x')]
[Int32]
$ShadowOffsetX,
# Set the shadow_offset_y of OBSTwoPassDropShadowShader
[Alias('shadow_offset_y')]
[ComponentModel.DefaultBindingProperty('shadow_offset_y')]
[Int32]
$ShadowOffsetY,
# Set the shadow_blur_size of OBSTwoPassDropShadowShader
[Alias('shadow_blur_size')]
[ComponentModel.DefaultBindingProperty('shadow_blur_size')]
[Int32]
$ShadowBlurSize,
# Set the shadow_color of OBSTwoPassDropShadowShader
[Alias('shadow_color')]
[ComponentModel.DefaultBindingProperty('shadow_color')]
[String]
$ShadowColor,
# Set the is_alpha_premultiplied of OBSTwoPassDropShadowShader
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
$shaderName = 'two-pass-drop-shadow'
$ShaderNoun = 'OBSTwoPassDropShadowShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
//Converted to OpenGL by Q-mii & Exeldro February 22, 2022
uniform float4x4 ViewProj;
uniform texture2d image;

uniform float elapsed_time;
uniform float2 uv_offset;
uniform float2 uv_scale;
uniform float2 uv_pixel_interval;
uniform float rand_f;
uniform float2 uv_size;

sampler_state textureSampler {
	Filter    = Linear;
	AddressU  = Border;
	AddressV  = Border;
	BorderColor = 00000000;
};

struct VertData {
	float4 pos : POSITION;
	float2 uv  : TEXCOORD0;
};

VertData mainTransform(VertData v_in)
{
	VertData vert_out;
	vert_out.pos = mul(float4(v_in.pos.xyz, 1.0), ViewProj);
	vert_out.uv = v_in.uv * uv_scale + uv_offset;
	return vert_out;
}

uniform int shadow_offset_x<
    string label = "shadow offset x";
    string widget_type = "slider";
    int minimum = -1000;
    int maximum = 1000;
    int step = 1;
>;
uniform int shadow_offset_y<
    string label = "shadow offset y";
    string widget_type = "slider";
    int minimum = -1000;
    int maximum = 1000;
    int step = 1;
>;
uniform int shadow_blur_size<
    string label = "shadow blur size";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
>;

uniform float4 shadow_color;

uniform bool is_alpha_premultiplied;

float4 mainImage(VertData v_in) : TARGET
{
    int shadow_blur_samples = int(shadow_blur_size + 1);//pow(shadow_blur_size * 2 + 1, 2);
    
    float4 color = image.Sample(textureSampler, v_in.uv);
    float2 shadow_uv = float2(v_in.uv.x - uv_pixel_interval.x * int(shadow_offset_x), 
                              v_in.uv.y - uv_pixel_interval.y * int(shadow_offset_y));
    
    float sampled_shadow_alpha = 0;
    
    for (int blur_x = -shadow_blur_size; blur_x <= shadow_blur_size; blur_x++)
    {
		float2 blur_uv = shadow_uv + float2(uv_pixel_interval.x * blur_x, 0);
		sampled_shadow_alpha += image.Sample(textureSampler, blur_uv).a;
    }
	
	sampled_shadow_alpha /= shadow_blur_samples;
    
    float4 final_shadow_color = float4(shadow_color.rgb, shadow_color.a * sampled_shadow_alpha);
    
    return final_shadow_color * (1-color.a) + color * (is_alpha_premultiplied?1.0:color.a);
}

float4 mainImage_2_end(VertData v_in) : TARGET
{
    int shadow_blur_samples = shadow_blur_size + 1;//pow(shadow_blur_size * 2 + 1, 2);
    
    float4 color = image.Sample(textureSampler, v_in.uv);
    float2 shadow_uv = float2(v_in.uv.x - uv_pixel_interval.x * shadow_offset_x, 
                              v_in.uv.y - uv_pixel_interval.y * shadow_offset_y);
    
    float sampled_shadow_alpha = 0;
    
    for (int blur_y = -shadow_blur_size; blur_y <= shadow_blur_size; blur_y++)
    {
		float2 blur_uv = shadow_uv + float2(0, uv_pixel_interval.y * blur_y);
		sampled_shadow_alpha += image.Sample(textureSampler, blur_uv).a;
    }
	
	sampled_shadow_alpha /= shadow_blur_samples;
    
    float4 final_shadow_color = float4(shadow_color.rgb, shadow_color.a * sampled_shadow_alpha);
    
    return final_shadow_color * (1-color.a) + color * (is_alpha_premultiplied?1.0:color.a);
}

technique Draw
{
	pass p0
	{
		vertex_shader = mainTransform(v_in);
		pixel_shader = mainImage(v_in);
	}
	
	pass p1
	{
		vertex_shader = mainTransform(v_in);
		pixel_shader = mainImage_2_end(v_in);
	}
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

