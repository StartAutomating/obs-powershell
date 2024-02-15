function Get-OBSShakeShader {

[Alias('Set-OBSShakeShader','Add-OBSShakeShader')]
param(
# Set the ViewProj of OBSShakeShader
[ComponentModel.DefaultBindingProperty('ViewProj')]
[Single[][]]
$ViewProj,
# Set the image of OBSShakeShader
[ComponentModel.DefaultBindingProperty('image')]
[String]
$Image,
# Set the elapsed_time of OBSShakeShader
[Alias('elapsed_time')]
[ComponentModel.DefaultBindingProperty('elapsed_time')]
[Single]
$ElapsedTime,
# Set the uv_offset of OBSShakeShader
[Alias('uv_offset')]
[ComponentModel.DefaultBindingProperty('uv_offset')]
[Single[]]
$UvOffset,
# Set the uv_scale of OBSShakeShader
[Alias('uv_scale')]
[ComponentModel.DefaultBindingProperty('uv_scale')]
[Single[]]
$UvScale,
# Set the uv_pixel_interval of OBSShakeShader
[Alias('uv_pixel_interval')]
[ComponentModel.DefaultBindingProperty('uv_pixel_interval')]
[Single[]]
$UvPixelInterval,
# Set the rand_f of OBSShakeShader
[Alias('rand_f')]
[ComponentModel.DefaultBindingProperty('rand_f')]
[Single]
$RandF,
# Set the uv_size of OBSShakeShader
[Alias('uv_size')]
[ComponentModel.DefaultBindingProperty('uv_size')]
[Single[]]
$UvSize,
# Set the local_time of OBSShakeShader
[Alias('local_time')]
[ComponentModel.DefaultBindingProperty('local_time')]
[Single]
$LocalTime,
# Set the random_scale of OBSShakeShader
[Alias('random_scale')]
[ComponentModel.DefaultBindingProperty('random_scale')]
[Single]
$RandomScale,
# Set the worble of OBSShakeShader
[ComponentModel.DefaultBindingProperty('worble')]
[Management.Automation.SwitchParameter]
$Worble,
# Set the speed of OBSShakeShader
[ComponentModel.DefaultBindingProperty('speed')]
[Single]
$Speed,
# Set the min_growth_pixels of OBSShakeShader
[Alias('min_growth_pixels')]
[ComponentModel.DefaultBindingProperty('min_growth_pixels')]
[Single]
$MinGrowthPixels,
# Set the max_growth_pixels of OBSShakeShader
[Alias('max_growth_pixels')]
[ComponentModel.DefaultBindingProperty('max_growth_pixels')]
[Single]
$MaxGrowthPixels,
# Set the randomize_movement of OBSShakeShader
[Alias('randomize_movement')]
[ComponentModel.DefaultBindingProperty('randomize_movement')]
[Management.Automation.SwitchParameter]
$RandomizeMovement,
# Set the notes of OBSShakeShader
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
$shaderName = 'shake'
$ShaderNoun = 'OBSShakeShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Shake Effect By Charles Fettinger (https://github.com/Oncorporation)  2/2019
// Added some randomization based upon random_scale input  
// updated for latest version of obs-shaderfilter

uniform float4x4 ViewProj;
uniform texture2d image;

uniform float elapsed_time;
uniform float2 uv_offset;
uniform float2 uv_scale;
uniform float2 uv_pixel_interval;
uniform float rand_f;
uniform float2 uv_size;
uniform float local_time;


uniform float random_scale<
    string label = "random scale";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 10.0;
    float step = 0.001;
> = 0.25;
uniform bool worble = false;
uniform float speed<
    string label = "Speed";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 10.0;
    float step = 0.001;
> = 1.0;
uniform float min_growth_pixels<
    string label = "min growth pixels";
    string widget_type = "slider";
    float minimum = -10.0;
    float maximum = 10.0;
    float step = 0.001;
> = -2.0;
uniform float max_growth_pixels<
    string label = "max growth pixels";
    string widget_type = "slider";
    float minimum = -10.0;
    float maximum = 10.0;
    float step = 0.001;
> = 2.0;
uniform bool randomize_movement = false;

uniform string notes<
    string widget_type = "info";
> =''keep the random_scale low for small (0.2-1) for small jerky movements and larger for less often big jumps'';

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

//noise values in range if 0.0 to 1.0

float noise3D(float x, float y, float z) {
    float ptr = 0.0f;
    return frac(sin(x*112.9898f + y*179.233f + z*237.212f) * 43758.5453f);
}

VertData mainTransform(VertData v_in)
{
	VertData vert_out;

	float3 pos = v_in.pos.xyz;
	float t;
	float s;
	float noise;
	if (randomize_movement)
	{
		t = (rand_f * 2) - 1.0f;
        s = (1 - rand_f * 2) - 1.0f;;
		noise = clamp( rand_f * random_scale,-0.99, 0.99);
	}
	else
	{
		t = (1 + sin(elapsed_time * speed)) / 2;
		s = (1 + cos(elapsed_time * speed)) / 2;
		noise = clamp(noise3D(t,s,100) * random_scale,-0.99, 0.99);
	}

	float3 direction_from_center = float3((v_in.uv.x - 0.5 + noise) * uv_pixel_interval.y / uv_pixel_interval.x, v_in.uv.y - 0.5 + noise, 1);
	float3 min_pos;
	float3 max_pos;
    if (worble)
    {
        min_pos = pos + direction_from_center * min_growth_pixels * 0.5;
        max_pos = pos + direction_from_center * max_growth_pixels * 0.5;
    }
    else
    {
    	min_pos = pos + direction_from_center * 0.5;
		max_pos = min_pos;
    }

	float3 current_pos = min_pos * (1 - t) + max_pos * t;
	//current_pos.x = v_in.pos.x + (t * min_pos.x);
	current_pos.y = (min_pos.y * (1 - s) + max_pos.y * s);
	//current_pos.y = v_in.pos.y + (s * min_pos.y);
	//current_pos.z = min_pos.z * (1 - s) + max_pos.z * s;

	float2 offset = uv_offset;
	offset.x = uv_offset.x * (1 - t + noise);
	offset.y = uv_offset.y * (1 - s + noise);

	vert_out.pos = mul(float4(current_pos, 1), ViewProj);
	
	//float2 scale = uv_scale;
	//scale += dot(pos - current_pos, 1);

	vert_out.uv = v_in.uv * uv_scale  + offset;
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

