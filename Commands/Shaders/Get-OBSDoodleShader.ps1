function Get-OBSDoodleShader {

[Alias('Set-OBSDoodleShader','Add-OBSDoodleShader')]
param(
# Set the ViewProj of OBSDoodleShader
[ComponentModel.DefaultBindingProperty('ViewProj')]
[Single[][]]
$ViewProj,
# Set the image of OBSDoodleShader
[ComponentModel.DefaultBindingProperty('image')]
[String]
$Image,
# Set the elapsed_time of OBSDoodleShader
[Alias('elapsed_time')]
[ComponentModel.DefaultBindingProperty('elapsed_time')]
[Single]
$ElapsedTime,
# Set the uv_offset of OBSDoodleShader
[Alias('uv_offset')]
[ComponentModel.DefaultBindingProperty('uv_offset')]
[Single[]]
$UvOffset,
# Set the uv_scale of OBSDoodleShader
[Alias('uv_scale')]
[ComponentModel.DefaultBindingProperty('uv_scale')]
[Single[]]
$UvScale,
# Set the uv_pixel_interval of OBSDoodleShader
[Alias('uv_pixel_interval')]
[ComponentModel.DefaultBindingProperty('uv_pixel_interval')]
[Single[]]
$UvPixelInterval,
# Set the rand_f of OBSDoodleShader
[Alias('rand_f')]
[ComponentModel.DefaultBindingProperty('rand_f')]
[Single]
$RandF,
# Set the uv_size of OBSDoodleShader
[Alias('uv_size')]
[ComponentModel.DefaultBindingProperty('uv_size')]
[Single[]]
$UvSize,
# Set the Doodle_Scale_Percent of OBSDoodleShader
[Alias('Doodle_Scale_Percent')]
[ComponentModel.DefaultBindingProperty('Doodle_Scale_Percent')]
[Single]
$DoodleScalePercent,
# Set the Snap_Percent of OBSDoodleShader
[Alias('Snap_Percent')]
[ComponentModel.DefaultBindingProperty('Snap_Percent')]
[Single]
$SnapPercent,
# Set the Notes of OBSDoodleShader
[ComponentModel.DefaultBindingProperty('Notes')]
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
$shaderName = 'doodle'
$ShaderNoun = 'OBSDoodleShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// doodle effect by Charles Fettinger (https://github.com/Oncorporation)  5/2019
// for use with obs-shaderfilter 1.0
uniform float4x4 ViewProj;
uniform texture2d image;

uniform float elapsed_time;
uniform float2 uv_offset;
uniform float2 uv_scale;
uniform float2 uv_pixel_interval;
uniform float rand_f;
uniform float2 uv_size;

uniform float Doodle_Scale_Percent<
    string label = "Doodle Scale Percent";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 0.1;
> = 2.5;
uniform float Snap_Percent<
    string label = "Snap Percent";
    string widget_type = "slider";
    float minimum = 1.0;
    float maximum = 100.0;
    float step = 0.1;
> = 7.5;
uniform string Notes<
    string widget_type = "info";
> = "Doodle skews the image by the Scale Percent, Snap Percent controls the number of doodles per second.";

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

float3 rand3(float3 co)
{
	float j = 4096.0*sin(dot(co, float3(17.0, 59.4, 15.0)));
	float3 result;
	result.z = frac(512.0*j);
	j *= .125;
	result.x = frac(512.0*j);
	j *= .125;
	result.y = frac(512.0*j);
	return result - 0.5;
}

float snap(float x, float snap)
{
	return snap * round(x / max(0.01,snap));
}

VertData mainTransform(VertData v_in)
{
	VertData vert_out;
	vert_out.pos = mul(float4(v_in.pos.xyz, 1.0), ViewProj);
	vert_out.uv = v_in.uv * uv_scale + uv_offset;
	float time = snap((1 + sin(elapsed_time)) * 0.5, Snap_Percent * .01);
	float rand = snap(rand_f, Snap_Percent *.01);
	float2 noise = rand3(v_in.pos.xyz + float3(time,0.0,0.0)).xy * (Doodle_Scale_Percent * .01);
	vert_out.uv.xy += noise;

	return vert_out;
}

float4 mainImage(VertData v_in) : TARGET
{
	return image.Sample(textureSampler, v_in.uv);
}

technique Draw
{
	pass p0
	{
		vertex_shader = mainTransform(v_in);
		pixel_shader = mainImage(v_in);
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

