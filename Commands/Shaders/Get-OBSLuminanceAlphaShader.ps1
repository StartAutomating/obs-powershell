function Get-OBSLuminanceAlphaShader {

[Alias('Set-OBSLuminanceAlphaShader','Add-OBSLuminanceAlphaShader')]
param(
# Set the ViewProj of OBSLuminanceAlphaShader
[ComponentModel.DefaultBindingProperty('ViewProj')]
[Single[][]]
$ViewProj,
# Set the image of OBSLuminanceAlphaShader
[ComponentModel.DefaultBindingProperty('image')]
[String]
$Image,
# Set the elapsed_time of OBSLuminanceAlphaShader
[Alias('elapsed_time')]
[ComponentModel.DefaultBindingProperty('elapsed_time')]
[Single]
$ElapsedTime,
# Set the uv_offset of OBSLuminanceAlphaShader
[Alias('uv_offset')]
[ComponentModel.DefaultBindingProperty('uv_offset')]
[Single[]]
$UvOffset,
# Set the uv_scale of OBSLuminanceAlphaShader
[Alias('uv_scale')]
[ComponentModel.DefaultBindingProperty('uv_scale')]
[Single[]]
$UvScale,
# Set the uv_pixel_interval of OBSLuminanceAlphaShader
[Alias('uv_pixel_interval')]
[ComponentModel.DefaultBindingProperty('uv_pixel_interval')]
[Single[]]
$UvPixelInterval,
# Set the rand_f of OBSLuminanceAlphaShader
[Alias('rand_f')]
[ComponentModel.DefaultBindingProperty('rand_f')]
[Single]
$RandF,
# Set the uv_size of OBSLuminanceAlphaShader
[Alias('uv_size')]
[ComponentModel.DefaultBindingProperty('uv_size')]
[Single[]]
$UvSize,
# Set the color_matrix of OBSLuminanceAlphaShader
[Alias('color_matrix')]
[ComponentModel.DefaultBindingProperty('color_matrix')]
[Single[][]]
$ColorMatrix,
# Set the color of OBSLuminanceAlphaShader
[ComponentModel.DefaultBindingProperty('color')]
[String]
$Color,
# Set the mul_val of OBSLuminanceAlphaShader
[Alias('mul_val')]
[ComponentModel.DefaultBindingProperty('mul_val')]
[Single]
$MulVal,
# Set the add_val of OBSLuminanceAlphaShader
[Alias('add_val')]
[ComponentModel.DefaultBindingProperty('add_val')]
[Single]
$AddVal,
# Set the level of OBSLuminanceAlphaShader
[ComponentModel.DefaultBindingProperty('level')]
[Single]
$Level,
# Set the invertAlphaChannel of OBSLuminanceAlphaShader
[ComponentModel.DefaultBindingProperty('invertAlphaChannel')]
[Management.Automation.SwitchParameter]
$InvertAlphaChannel,
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
$shaderName = 'luminance_alpha'
$ShaderNoun = 'OBSLuminanceAlphaShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Luminance Alpha Effect By Charles Fettinger (https://github.com/Oncorporation)  2/2019
//Converted to OpenGL by Q-mii & Exeldro February 22, 2022
uniform float4x4 ViewProj;
uniform texture2d image;

uniform float elapsed_time;
uniform float2 uv_offset;
uniform float2 uv_scale;
uniform float2 uv_pixel_interval;
uniform float rand_f;
uniform float2 uv_size;

uniform float4x4 color_matrix;
uniform float4 color;
uniform float mul_val<
    string label = "Mulitply";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 10.0;
    float step = 0.001;
> = 1.0;
uniform float add_val<
    string label = "Add";
    string widget_type = "slider";
    float minimum = -10.0;
    float maximum = 10.0;
    float step = 0.001;
> = 0.0;
uniform float level<
    string label = "Level";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 10.0;
    float step = 0.001;
> =1.0;
uniform bool invertAlphaChannel;

sampler_state textureSampler {
	Filter    = Linear;
	AddressU  = Border;
	AddressV  = Border;
	BorderColor = 00000000;
};

struct VertDataIn {
	float4 pos : POSITION;
	float2 uv  : TEXCOORD0;
};

struct VertDataOut {
	float4 pos : POSITION;
	float2 uv  : TEXCOORD0;
	float2 uv2 : TEXCOORD1;
};

VertDataOut mainTransform(VertDataIn v_in)
{
	VertDataOut vert_out;
	vert_out.pos = mul(float4(v_in.pos.xyz, 1.0 ), ViewProj);
	vert_out.uv  = v_in.uv * mul_val + add_val;
	vert_out.uv2 = v_in.uv ;
	return vert_out;
}

/*float3 GetLuminance(float4 rgba)
{
	float red = rbga.r;
	float green = rgba.g;
	float blue = rgba.b;
	return (.299 * red) + (.587 * green) + (.114 * blue);
}*/

float4 PSAlphaMaskRGBA(VertDataOut v_in) : TARGET
{
	float4 rgba = image.Sample(textureSampler, v_in.uv) ;
    if (rgba.a > 0.0)
    {
    
    float intensity = rgba.r * color.r * 0.299 + rgba.g * color.g * 0.587 + rgba.b * color.b * 0.114;
    if (invertAlphaChannel)
    {
        intensity = 1.0 - intensity;
    }
    rgba *= color;
    rgba.a = clamp((intensity * level), 0.0, 1.0);
	
    }
	return rgba;
}

technique Draw
{
	pass
	{
		vertex_shader = mainTransform(v_in);
		pixel_shader  = PSAlphaMaskRGBA(v_in);
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

