function Get-OBSEmbersShader {

[Alias('Set-OBSEmbersShader','Add-OBSEmbersShader')]
param(
# Set the ViewProj of OBSEmbersShader
[ComponentModel.DefaultBindingProperty('ViewProj')]
[Single[][]]
$ViewProj,
# Set the image of OBSEmbersShader
[ComponentModel.DefaultBindingProperty('image')]
[String]
$Image,
# Set the elapsed_time of OBSEmbersShader
[Alias('elapsed_time')]
[ComponentModel.DefaultBindingProperty('elapsed_time')]
[Single]
$ElapsedTime,
# Set the uv_offset of OBSEmbersShader
[Alias('uv_offset')]
[ComponentModel.DefaultBindingProperty('uv_offset')]
[Single[]]
$UvOffset,
# Set the uv_scale of OBSEmbersShader
[Alias('uv_scale')]
[ComponentModel.DefaultBindingProperty('uv_scale')]
[Single[]]
$UvScale,
# Set the uv_size of OBSEmbersShader
[Alias('uv_size')]
[ComponentModel.DefaultBindingProperty('uv_size')]
[Single[]]
$UvSize,
# Set the uv_pixel_interval of OBSEmbersShader
[Alias('uv_pixel_interval')]
[ComponentModel.DefaultBindingProperty('uv_pixel_interval')]
[Single[]]
$UvPixelInterval,
# Set the rand_f of OBSEmbersShader
[Alias('rand_f')]
[ComponentModel.DefaultBindingProperty('rand_f')]
[Single]
$RandF,
# Set the rand_instance_f of OBSEmbersShader
[Alias('rand_instance_f')]
[ComponentModel.DefaultBindingProperty('rand_instance_f')]
[Single]
$RandInstanceF,
# Set the rand_activation_f of OBSEmbersShader
[Alias('rand_activation_f')]
[ComponentModel.DefaultBindingProperty('rand_activation_f')]
[Single]
$RandActivationF,
# Set the loops of OBSEmbersShader
[ComponentModel.DefaultBindingProperty('loops')]
[Int32]
$Loops,
# Set the local_time of OBSEmbersShader
[Alias('local_time')]
[ComponentModel.DefaultBindingProperty('local_time')]
[Single]
$LocalTime,
# Set the notes of OBSEmbersShader
[ComponentModel.DefaultBindingProperty('notes')]
[String]
$Notes,
# Set the Animation_Speed of OBSEmbersShader
[Alias('Animation_Speed')]
[ComponentModel.DefaultBindingProperty('Animation_Speed')]
[Single]
$AnimationSpeed,
# Set the Movement_Direction_Horizontal of OBSEmbersShader
[Alias('Movement_Direction_Horizontal')]
[ComponentModel.DefaultBindingProperty('Movement_Direction_Horizontal')]
[Single]
$MovementDirectionHorizontal,
# Set the Movement_Direction_Vertical of OBSEmbersShader
[Alias('Movement_Direction_Vertical')]
[ComponentModel.DefaultBindingProperty('Movement_Direction_Vertical')]
[Single]
$MovementDirectionVertical,
# Set the Movement_Speed_Percent of OBSEmbersShader
[Alias('Movement_Speed_Percent')]
[ComponentModel.DefaultBindingProperty('Movement_Speed_Percent')]
[Int32]
$MovementSpeedPercent,
# Set the Layers_Count of OBSEmbersShader
[Alias('Layers_Count')]
[ComponentModel.DefaultBindingProperty('Layers_Count')]
[Int32]
$LayersCount,
# Set the lumaMin of OBSEmbersShader
[ComponentModel.DefaultBindingProperty('lumaMin')]
[Single]
$LumaMin,
# Set the lumaMinSmooth of OBSEmbersShader
[ComponentModel.DefaultBindingProperty('lumaMinSmooth')]
[Single]
$LumaMinSmooth,
# Set the Alpha_Percentage of OBSEmbersShader
[Alias('Alpha_Percentage')]
[ComponentModel.DefaultBindingProperty('Alpha_Percentage')]
[Single]
$AlphaPercentage,
# Set the Apply_To_Alpha_Layer of OBSEmbersShader
[Alias('Apply_To_Alpha_Layer')]
[ComponentModel.DefaultBindingProperty('Apply_To_Alpha_Layer')]
[Management.Automation.SwitchParameter]
$ApplyToAlphaLayer,
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
$shaderName = 'embers'
$ShaderNoun = 'OBSEmbersShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Embers effect by Charles Fettinger for obs-shaderfilter plugin 8/2020 v.1
// https://github.com/Oncorporation/obs-shaderfilter
// https://www.shadertoy.com/view/wl2Gzc - coverted from and updated

uniform float4x4 ViewProj;
uniform texture2d image;

uniform float elapsed_time;
uniform float2 uv_offset;
uniform float2 uv_scale;
uniform float2 uv_size;
uniform float2 uv_pixel_interval;
uniform float rand_f;
uniform float rand_instance_f;
uniform float rand_activation_f;
uniform int loops;
uniform float local_time;
uniform string notes<
    string widget_type = "info";
> = "luma is applied with Apply to Alpha Layer. Movement Speed and Direction can be negatives";

#ifndef OPENGL
#define mat2 float2x2
#define fract frac
#define mix lerp
#endif

sampler_state textureSampler {
	Filter    = Linear;
	AddressU  = Clamp;
	AddressV  = Clamp;
};

uniform float Animation_Speed <
	string label = "Animation Speed";
	string widget_type = "slider";
	float minimum = 0.1;
	float maximum = 10.0;
	float step = 0.01;
	float scale = 1.;
> = 1.5;

uniform float Movement_Direction_Horizontal<
    string label = "Movement Direction Horizontal";
    string widget_type = "slider";
    float minimum = -100.0;
    float maximum = 100.0;
    float step = 1.0;
> = 5.0;
uniform float Movement_Direction_Vertical<
    string label = "Movement Direction Vertical";
    string widget_type = "slider";
    float minimum = -100.0;
    float maximum = 100.0;
    float step = 1.0;
> = 10.0;

uniform int Movement_Speed_Percent<
    string label = "Movement Speed Percent";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 5;

uniform int Layers_Count <
	string label = "Layers";
    string widget_type = "slider";
    int minimum = 1.0;
    int maximum = 100.0;
    int step = 1;
> = 15;
/* ps start
*/


uniform float lumaMin<
    string label = "Luma Min";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.01;
> = 0.01;
uniform float lumaMinSmooth<
    string label = "Luma Min Smooth";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.01;
> = 0.01;
uniform float Alpha_Percentage<
    string label = "Alpha Percentage";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 0.1;
> = 100.0;
uniform bool Apply_To_Alpha_Layer = true;

#define PI 3.1415927
#define TWO_PI 6.283185

#define PARTICLE_SIZE 0.009

#define PARTICLE_SCALE float2(0.5, 1.6)
#define PARTICLE_SCALE_VAR float2(0.25, 0.2)

#define PARTICLE_BLOOM_SCALE float2(0.5, 0.8)
#define PARTICLE_BLOOM_SCALE_VAR float2(0.3, 0.1)

#define SPARK_COLOR float3(1.0, 0.4, 0.05) * 1.5
#define BLOOM_COLOR float3(1.0, 0.4, 0.05) * 0.8
#define SMOKE_COLOR float3(1.0, 0.43, 0.1) * 0.8

#define SIZE_MOD 1.05
#define ALPHA_MOD 0.9
#define Movement_Direction float2(Movement_Direction_Horizontal, Movement_Direction_Vertical)
#define Movement_Speed Movement_Speed_Percent * 0.01
#define UV float2(fragCoord.xy / uv_size)

float hash1_2(float2 x)
{
    return fract(sin(dot(x, float2(52.127, 61.2871))) * 521.582);
}

float2 hash2_2(float2 x)
{
    mat2 m = mat2(20.52, 24.1994, 70.291, 80.171);
    float2 y = mul(x, m);
    return fract(sin(y) * 492.194);
}

//Simple interpolated noise
float2 noise2_2(float2 uv)
{
    //float2 f = fract(uv);
    float2 f = smoothstep(0.0, 1.0, fract(uv));
    
    float2 uv00 = floor(uv);
    float2 uv01 = uv00 + float2(0, 1);
    float2 uv10 = uv00 + float2(1, 0);
    float2 uv11 = uv00 + 1.0;
    float2 v00 = hash2_2(uv00);
    float2 v01 = hash2_2(uv01);
    float2 v10 = hash2_2(uv10);
    float2 v11 = hash2_2(uv11);
    
    float2 v0 = mix(v00, v01, f.y);
    float2 v1 = mix(v10, v11, f.y);
    float2 v = mix(v0, v1, f.x);
    
    return v;
}

//Simple interpolated noise
float noise1_2(float2 uv)
{
    float2 f = fract(uv);
    
    float2 uv00 = floor(uv);
    float2 uv01 = uv00 + float2(0, 1);
    float2 uv10 = uv00 + float2(1, 0);
    float2 uv11 = uv00 + 1.0;
    
    float v00 = hash1_2(uv00);
    float v01 = hash1_2(uv01);
    float v10 = hash1_2(uv10);
    float v11 = hash1_2(uv11);
    
    float v0 = mix(v00, v01, f.y);
    float v1 = mix(v10, v11, f.y);
    float v = mix(v0, v1, f.x);
    
    return v;
}

float layeredNoise1_2(float2 uv, float sizeMod, float alphaMod, int layers, float animation)
{
    float noise = 0.0;
    float alpha = 1.0;
    float size = 1.0;
    float2 offset;
    for (int i = 0; i < layers; i++)
    {
        offset += hash2_2(float2(alpha, size)) * 10.0;
        
        //Adding noise with movement
        noise += noise1_2(uv * size + elapsed_time * animation * 8.0 * Movement_Direction * Movement_Speed + offset) * alpha;
        alpha *= alphaMod;
        size *= sizeMod;
    }
    
    noise *= (1.0 - alphaMod) / (1.0 - pow(alphaMod, float(layers)));
    return noise;
}

//Rotates point around 0,0
float2 rotate(float2 vpoint, float deg)
{
    float s = sin(deg);
    float c = cos(deg);
    mat2 m = mat2(s, c, -c, s);
    return mul(vpoint, m);
}

//Cell center from point on the grid
float2 voronoiPointFromRoot(float2 root, float deg)
{
    float2 vpoint = hash2_2(root) - 0.5;
    float s = sin(deg);
    float c = cos(deg);
    mat2 m = mat2(s, c, -c, s);
    vpoint = mul(vpoint, m) * 0.66;
    vpoint += root + 0.5;
    return vpoint;
}

//Voronoi cell point rotation degrees
float degFromRootUV(in float2 uv)
{
    return elapsed_time * Animation_Speed * (hash1_2(uv) - 0.5) * 2.0;
}

float2 randomAround2_2(in float2 vpoint, in float2 range, in float2 uv)
{
    return vpoint + (hash2_2(uv) - 0.5) * range;
}


float3 fireParticles(in float2 uv, in float2 originalUV)
{
    float3 particles = float3(0.0, 0.0, 0.0);
    float2 rootUV = floor(uv);
    float deg = degFromRootUV(rootUV);
    float2 pointUV = voronoiPointFromRoot(rootUV, deg);
    float dist = 2.0;
    float distBloom = 0.0;
   
   	//UV manipulation for the faster particle movement
    float2 tempUV = uv + (noise2_2(uv * 2.0) - 0.5) * 0.1;
    tempUV += -(noise2_2(uv * 3.0 + elapsed_time) - 0.5) * 0.07;

    //Sparks sdf
    dist = length(rotate(tempUV - pointUV, 0.7) * randomAround2_2(PARTICLE_SCALE, PARTICLE_SCALE_VAR, rootUV));
    
    //Bloom sdf
    distBloom = length(rotate(tempUV - pointUV, 0.7) * randomAround2_2(PARTICLE_BLOOM_SCALE, PARTICLE_BLOOM_SCALE_VAR, rootUV));

    //Add sparks
    particles += (1.0 - smoothstep(PARTICLE_SIZE * 0.6, PARTICLE_SIZE * 3.0, dist)) * SPARK_COLOR;
    
    //Add bloom
    particles += pow((1.0 - smoothstep(0.0, PARTICLE_SIZE * 6.0, distBloom)) * 1.0, 3.0) * BLOOM_COLOR;

    //Upper disappear curve randomization
    float border = (hash1_2(rootUV) - 0.5) * 2.0;
    float disappear = 1.0 - smoothstep(border, border + 0.5, originalUV.y);
	
    //Lower appear curve randomization
    border = (hash1_2(rootUV + 0.214) - 1.8) * 0.7;
    float appear = smoothstep(border, border + 0.4, originalUV.y);
    
    return particles * disappear * appear;
}


//Layering particles to imitate 3D view
float3 layeredParticles(in float2 uv, in float sizeMod, in float alphaMod, in int layers, in float smoke)
{
    float3 particles = float3(0.0, 0.0, 0.0);
    float size = 1.0;
    float alpha = 1.0;
    float2 offset = float2(0.0, 0.0);
    float2 noiseOffset;
    float2 bokehUV;
    
    for (int i = 0; i < layers; i++)
    {
        //Particle noise movement
        noiseOffset = (noise2_2(uv * size * 2.0 + 0.5) - 0.5) * 0.15;
        
        //UV with applied movement
        bokehUV = (uv * size + elapsed_time * Movement_Direction * Movement_Speed) + offset + noiseOffset;
        
        //Adding particles								if there is more smoke, remove smaller particles
        particles += fireParticles(bokehUV, uv) * alpha * (1.0 - smoothstep(0.0, 1.0, smoke) * (float(i) / float(layers)));
        
        //Moving uv origin to avoid generating the same particles
        offset += hash2_2(float2(alpha, alpha)) * 10.0;
        
        alpha *= alphaMod;
        size *= sizeMod;
    }
    
    return particles;
}


void mainImage(out float4 fragColor, in float2 fragCoord)
{
    float2 uv = (2.0 * fragCoord - uv_size.xy) / uv_size.x;
    float vignette = 1.0 - smoothstep(0.4, 1.4, length(uv + float2(0.0, 0.3)));
       
    uv *= 1.8;
    float alpha = clamp(Alpha_Percentage * .01, 0, 1.0);
    
    float smokeIntensity = layeredNoise1_2(uv * 10.0 + elapsed_time * 4.0 * Movement_Direction * Movement_Speed, 1.7, 0.7, 6, 0.2);
    smokeIntensity *= pow(1.0 - smoothstep(-1.0, 1.6, uv.y), 2.0);
    float3 smoke = smokeIntensity * SMOKE_COLOR * 0.8 * vignette;
    
    //Cutting holes in smoke
    smoke *= pow(layeredNoise1_2(uv * 4.0 + elapsed_time * 0.5 * Movement_Direction * Movement_Speed, 1.8, 0.5, 3, 0.2),
    2.0) * 1.5;
    
    float3 particles = layeredParticles(uv, SIZE_MOD, ALPHA_MOD, Layers_Count, smokeIntensity);
    
    float4 col = float4(particles + smoke + SMOKE_COLOR * 0.02, alpha);   
    col.rgb *= vignette;    
    col.rgb = smoothstep(-0.08, 1.0, col.rgb);
    
    if (Apply_To_Alpha_Layer)
    {    
        float4 original_color = image.Sample(textureSampler, UV);
 
        float luma = dot(col.rgb, float3(0.299, 0.587, 0.114));
        float luma_min = smoothstep(lumaMin, lumaMin + lumaMinSmooth, luma);
        col.a = clamp(luma_min, 0.0, 1.0);
		
        col.rgb = lerp(original_color.rgb, col.rgb, alpha); //apply alpha slider
        col = lerp(original_color, col, col.a); //remove black background color
    }

    fragColor = col;
}

/*ps end*/

struct VertFragData {
	float4 pos : POSITION;
	float2 uv  : TEXCOORD0;
};

VertFragData VSDefault(VertFragData vtx) {
	vtx.pos = mul(float4(vtx.pos.xyz, 1.0), ViewProj);
	return vtx;
}

float4 PSDefault(VertFragData vtx) : TARGET {
	float4 col = float4(1., 1., 1., 1.);
	mainImage(col, vtx.uv * uv_size);
	return col;
}

technique Draw 
{
	pass
	{
		vertex_shader = VSDefault(vtx);
		pixel_shader  = PSDefault(vtx); 
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

