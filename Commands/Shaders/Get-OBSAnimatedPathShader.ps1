function Get-OBSAnimatedPathShader {

[Alias('Set-OBSAnimatedPathShader','Add-OBSAnimatedPathShader')]
param(
# Set the ViewProj of OBSAnimatedPathShader
[ComponentModel.DefaultBindingProperty('ViewProj')]
[Single[][]]
$ViewProj,
# Set the image of OBSAnimatedPathShader
[ComponentModel.DefaultBindingProperty('image')]
[String]
$Image,
# Set the elapsed_time of OBSAnimatedPathShader
[Alias('elapsed_time')]
[ComponentModel.DefaultBindingProperty('elapsed_time')]
[Single]
$ElapsedTime,
# Set the uv_offset of OBSAnimatedPathShader
[Alias('uv_offset')]
[ComponentModel.DefaultBindingProperty('uv_offset')]
[Single[]]
$UvOffset,
# Set the uv_scale of OBSAnimatedPathShader
[Alias('uv_scale')]
[ComponentModel.DefaultBindingProperty('uv_scale')]
[Single[]]
$UvScale,
# Set the uv_pixel_interval of OBSAnimatedPathShader
[Alias('uv_pixel_interval')]
[ComponentModel.DefaultBindingProperty('uv_pixel_interval')]
[Single[]]
$UvPixelInterval,
# Set the rand_f of OBSAnimatedPathShader
[Alias('rand_f')]
[ComponentModel.DefaultBindingProperty('rand_f')]
[Single]
$RandF,
# Set the speed_percent of OBSAnimatedPathShader
[Alias('speed_percent')]
[ComponentModel.DefaultBindingProperty('speed_percent')]
[Int32]
$SpeedPercent,
# Set the path_map of OBSAnimatedPathShader
[Alias('path_map')]
[ComponentModel.DefaultBindingProperty('path_map')]
[String]
$PathMap,
# Set the reverse of OBSAnimatedPathShader
[ComponentModel.DefaultBindingProperty('reverse')]
[Management.Automation.SwitchParameter]
$Reverse,
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
$shaderName = 'animated_path'
$ShaderNoun = 'OBSAnimatedPathShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Path effect By Charles Fettinger (https://github.com/Oncorporation)  3/2019
//Converted to OpenGL by Q-mii & Exeldro February 24, 2022
uniform float4x4 ViewProj;
uniform texture2d image;

uniform float elapsed_time;
uniform float2 uv_offset;
uniform float2 uv_scale;
uniform float2 uv_pixel_interval;
uniform float rand_f;

uniform int speed_percent = 100;
uniform texture2d path_map;
uniform bool reverse = false;

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

float4 convert_pmalpha(float4 c)
{
	float4 ret = c;
	if (c.a >= 0.001)
		ret.xyz /= c.a;
	else
		ret = float4(0.0, 0.0, 0.0, 0.0);
	return ret;
}

VertData mainTransform(VertData v_in)
{
	VertData vert_out;
	float3 pos = v_in.pos.xyz;
	float3 current_pos;
	float speed = speed_percent * 0.01;
	//vert_out.pos = mul(float4(v_in.pos.xyz, 1.0), ViewProj);
	float t = 1.0 + sin(elapsed_time * speed) ;
	// combine luma texture and user defined shine color
	float luma = path_map.Sample(textureSampler, v_in.uv).x;
	if (reverse)
	{
		luma = 1.0 - luma;
	}

	float time = lerp(0.0f, 1.0f , t - 1.0);

	// set current position in time
	current_pos.x = 0;
	current_pos.y = 0;


	float2 offset = uv_offset;
	if (speed == 0.0f)
	{
		offset.x = 0.0f;
		offset.y = 0.0f;
	}
	else
	{
		offset.x = uv_offset.x + time * luma;
		offset.y = uv_offset.y + time * luma;
	}

	vert_out.pos = mul(float4(current_pos, 1), ViewProj);
	vert_out.uv  = v_in.uv * uv_scale + offset;
	return vert_out;
}

float4 mainImage(VertData v_in) : TARGET
{
	return image.Sample(textureSampler, v_in.uv);
}

technique Draw
{
	pass
	{
		vertex_shader = mainTransform(v_in);
		pixel_shader  = mainImage(v_in);
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

