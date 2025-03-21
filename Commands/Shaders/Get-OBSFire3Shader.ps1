function Get-OBSFire3Shader {

[Alias('Set-OBSFire3Shader','Add-OBSFire3Shader')]
param(
# Set the ViewProj of OBSFire3Shader
[ComponentModel.DefaultBindingProperty('ViewProj')]
[Single[][]]
$ViewProj,
# Set the image of OBSFire3Shader
[ComponentModel.DefaultBindingProperty('image')]
[String]
$Image,
# Set the elapsed_time of OBSFire3Shader
[Alias('elapsed_time')]
[ComponentModel.DefaultBindingProperty('elapsed_time')]
[Single]
$ElapsedTime,
# Set the uv_offset of OBSFire3Shader
[Alias('uv_offset')]
[ComponentModel.DefaultBindingProperty('uv_offset')]
[Single[]]
$UvOffset,
# Set the uv_scale of OBSFire3Shader
[Alias('uv_scale')]
[ComponentModel.DefaultBindingProperty('uv_scale')]
[Single[]]
$UvScale,
# Set the uv_pixel_interval of OBSFire3Shader
[Alias('uv_pixel_interval')]
[ComponentModel.DefaultBindingProperty('uv_pixel_interval')]
[Single[]]
$UvPixelInterval,
# Set the uv_size of OBSFire3Shader
[Alias('uv_size')]
[ComponentModel.DefaultBindingProperty('uv_size')]
[Single[]]
$UvSize,
# Set the rand_f of OBSFire3Shader
[Alias('rand_f')]
[ComponentModel.DefaultBindingProperty('rand_f')]
[Single]
$RandF,
# Set the rand_instance_f of OBSFire3Shader
[Alias('rand_instance_f')]
[ComponentModel.DefaultBindingProperty('rand_instance_f')]
[Single]
$RandInstanceF,
# Set the rand_activation_f of OBSFire3Shader
[Alias('rand_activation_f')]
[ComponentModel.DefaultBindingProperty('rand_activation_f')]
[Single]
$RandActivationF,
# Set the loops of OBSFire3Shader
[ComponentModel.DefaultBindingProperty('loops')]
[Int32]
$Loops,
# Set the local_time of OBSFire3Shader
[Alias('local_time')]
[ComponentModel.DefaultBindingProperty('local_time')]
[Single]
$LocalTime,
# Set the Movement_Direction_Horizontal of OBSFire3Shader
[Alias('Movement_Direction_Horizontal')]
[ComponentModel.DefaultBindingProperty('Movement_Direction_Horizontal')]
[Single]
$MovementDirectionHorizontal,
# Set the Movement_Direction_Vertical of OBSFire3Shader
[Alias('Movement_Direction_Vertical')]
[ComponentModel.DefaultBindingProperty('Movement_Direction_Vertical')]
[Single]
$MovementDirectionVertical,
# Set the Alpha_Percentage of OBSFire3Shader
[Alias('Alpha_Percentage')]
[ComponentModel.DefaultBindingProperty('Alpha_Percentage')]
[Int32]
$AlphaPercentage,
# Set the Speed of OBSFire3Shader
[ComponentModel.DefaultBindingProperty('Speed')]
[Int32]
$Speed,
# Set the Invert of OBSFire3Shader
[ComponentModel.DefaultBindingProperty('Invert')]
[Management.Automation.SwitchParameter]
$Invert,
# Set the lumaMin of OBSFire3Shader
[ComponentModel.DefaultBindingProperty('lumaMin')]
[Single]
$LumaMin,
# Set the lumaMinSmooth of OBSFire3Shader
[ComponentModel.DefaultBindingProperty('lumaMinSmooth')]
[Single]
$LumaMinSmooth,
# Set the Apply_To_Image of OBSFire3Shader
[Alias('Apply_To_Image')]
[ComponentModel.DefaultBindingProperty('Apply_To_Image')]
[Management.Automation.SwitchParameter]
$ApplyToImage,
# Set the Replace_Image_Color of OBSFire3Shader
[Alias('Replace_Image_Color')]
[ComponentModel.DefaultBindingProperty('Replace_Image_Color')]
[Management.Automation.SwitchParameter]
$ReplaceImageColor,
# Set the Color_To_Replace of OBSFire3Shader
[Alias('Color_To_Replace')]
[ComponentModel.DefaultBindingProperty('Color_To_Replace')]
[String]
$ColorToReplace,
# Set the Apply_To_Specific_Color of OBSFire3Shader
[Alias('Apply_To_Specific_Color')]
[ComponentModel.DefaultBindingProperty('Apply_To_Specific_Color')]
[Management.Automation.SwitchParameter]
$ApplyToSpecificColor,
# Set the Full_Width of OBSFire3Shader
[Alias('Full_Width')]
[ComponentModel.DefaultBindingProperty('Full_Width')]
[Management.Automation.SwitchParameter]
$FullWidth,
# Set the Flame_Size of OBSFire3Shader
[Alias('Flame_Size')]
[ComponentModel.DefaultBindingProperty('Flame_Size')]
[Single]
$FlameSize,
# Set the Spark_Grid_Height of OBSFire3Shader
[Alias('Spark_Grid_Height')]
[ComponentModel.DefaultBindingProperty('Spark_Grid_Height')]
[Single]
$SparkGridHeight,
# Set the Flame_Modifier of OBSFire3Shader
[Alias('Flame_Modifier')]
[ComponentModel.DefaultBindingProperty('Flame_Modifier')]
[Single]
$FlameModifier,
# Set the Flame_Tongue_Size of OBSFire3Shader
[Alias('Flame_Tongue_Size')]
[ComponentModel.DefaultBindingProperty('Flame_Tongue_Size')]
[Single]
$FlameTongueSize,
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
$shaderName = 'fire-3'
$ShaderNoun = 'OBSFire3Shader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
//My effect modified by Me for use with obs-shaderfilter month/year v.02
//Converted to OpenGL by Q-mii & Exeldro February 22, 2022
uniform float4x4 ViewProj;
uniform texture2d image;

//Section to converting GLSL to HLSL - can delete
#define vec2 float2
#define vec3 float3
#define vec4 float4
#define ivec2 int2
#define ivec3 int3
#define ivec4 int4
#define mat2 float2x2
#define mat3 float3x3
#define mat4 float4x4
#define fract frac
#define mix lerp


uniform float elapsed_time;
uniform float2 uv_offset;
uniform float2 uv_scale;
uniform float2 uv_pixel_interval;
uniform float2 uv_size;
uniform float rand_f;
uniform float rand_instance_f;
uniform float rand_activation_f;
uniform int loops;
uniform float local_time;

uniform float Movement_Direction_Horizontal<
    string label = "Movement Direction Horizontal";
    string widget_type = "slider";
    float minimum = -100.0;
    float maximum = 100.0;
    float step = 0.01;
> = 0.0;
uniform float Movement_Direction_Vertical<
    string label = "Movement Direction Vertical";
    string widget_type = "slider";
    float minimum = -100.0;
    float maximum = 100.0;
    float step = 0.01;
> = 0.0;

#define iTime elapsed_time
#define iResolution float4(uv_size,uv_pixel_interval)
#define Movement_Direction float2(Movement_Direction_Horizontal, Movement_Direction_Vertical)

uniform int Alpha_Percentage<
    string label = "Alpha Percentage";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 90;
uniform int Speed<
    string label = "Speed";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 80;
uniform bool Invert = false;
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
> = 0.04;
uniform bool Apply_To_Image = true;
uniform bool Replace_Image_Color = true;
uniform float4 Color_To_Replace;
uniform bool Apply_To_Specific_Color = false;

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
	float2 uv = v_in.uv;
	if(Invert)
		uv = 1.0 - v_in.uv;	
	vert_out.uv  = v_in.uv * uv_scale + uv_offset;
	return vert_out;
}

int2 iMouse()
{
    return int2(Movement_Direction.x * uv_size.x, Movement_Direction.y * uv_size.y);
}


float mod(float x, float y)
{
	return x - y * floor(x / y);
}

float2 mod2(float2 x, float2 y)
{
	return x - y * floor(x / y);
}

/*ps start*/
#define PI 3.1415926535897932384626433832795
uniform bool Full_Width = false;

uniform float Flame_Size<
    string label = "Flame Size";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 10.0;
    float step = 0.01;
> = 1.0;

uniform float Spark_Grid_Height<
    string label = "Spark Grid Size";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 0.01;
> = 50.0;

uniform float Flame_Modifier<
    string label = "Flame Modifier";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 2.0;
    float step = 0.01;
> = 1.0;

uniform float Flame_Tongue_Size<
    string label = "Flame Tongue Size";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 2.0;
    float step = 0.01;
> = 8.5;

//
// Description : Array and textureless GLSL 2D/3D/4D simplex 
//							 noise functions.
//			Author : Ian McEwan, Ashima Arts.
//	Maintainer : ijm
//		 Lastmod : 20110822 (ijm)
//		 License : Copyright (C) 2011 Ashima Arts. All rights reserved.
//							 Distributed under the MIT License. See LICENSE file.
//							 https://github.com/ashima/webgl-noise
// 

vec3 mod2893(vec3 x)
{
    return x - floor(x * (1.0 / 289.0)) * 289.0;
}

vec4 mod289(vec4 x)
{
    return x - floor(x * (1.0 / 289.0)) * 289.0;
}

vec4 permute(vec4 x)
{
    return mod289(((x * 34.0) + 1.0) * x);
}

vec4 taylorInvSqrt(vec4 r)
{
    return 1.79284291400159 - 0.85373472095314 * r;
}

float snoise(vec3 v)
{
    const vec2 C = vec2(1.0 / 6.0, 1.0 / 3.0);
    const vec4 D = vec4(0.0, 0.5, 1.0, 2.0);

// First corner
	vec3 i = floor(v + dot(v, C.yyy));
	vec3 x0 = v - i + dot(i, C.xxx);

// Other corners
	vec3 g = step(x0.yzx, x0.xyz);
	vec3 l = 1.0 - g;
	vec3 i1 = min(g.xyz, l.zxy);
	vec3 i2 = max(g.xyz, l.zxy);

	//	 x0 = x0 - 0.0 + 0.0 * C.xxx;
	//	 x1 = x0 - i1	+ 1.0 * C.xxx;
	//	 x2 = x0 - i2	+ 2.0 * C.xxx;
	//	 x3 = x0 - 1.0 + 3.0 * C.xxx;
	vec3 x1 = x0 - i1 + C.xxx;
	vec3 x2 = x0 - i2 + C.yyy; // 2.0*C.x = 1/3 = C.y
	vec3 x3 = x0 - D.yyy; // -1.0+3.0*C.x = -0.5 = -D.y

// Permutations
    i = mod2893(i);
	vec4 p = permute(permute(permute(
					 i.z + vec4(0.0, i1.z, i2.z, 1.0))
					 + i.y + vec4(0.0, i1.y, i2.y, 1.0))
					 + i.x + vec4(0.0, i1.x, i2.x, 1.0));

// Gradients: 7x7 points over a square, mapped onto an octahedron.
// The ring size 17*17 = 289 is close to a multiple of 49 (49*6 = 294)
    float n_ = 0.142857142857; // 1.0/7.0
	vec3 ns = n_ * D.wyz - D.xzx;

	vec4 j = p - 49.0 * floor(p * ns.z * ns.z); //	mod(p,7*7)

	vec4 x_ = floor(j * ns.z);
	vec4 y_ = floor(j - 7.0 * x_); // mod(j,N)

	vec4 x = x_ * ns.x + ns.yyyy;
	vec4 y = y_ * ns.x + ns.yyyy;
	vec4 h = 1.0 - abs(x) - abs(y);

	vec4 b0 = vec4(x.xy, y.xy);
	vec4 b1 = vec4(x.zw, y.zw);

	//vec4 s0 = vec4(lessThan(b0,0.0))*2.0 - 1.0;
	//vec4 s1 = vec4(lessThan(b1,0.0))*2.0 - 1.0;
	vec4 s0 = floor(b0) * 2.0 + 1.0;
	vec4 s1 = floor(b1) * 2.0 + 1.0;
	vec4 sh = -step(h, vec4(0.0, 0.0, 0.0, 0.0));

	vec4 a0 = b0.xzyw + s0.xzyw * sh.xxyy;
	vec4 a1 = b1.xzyw + s1.xzyw * sh.zzww;

	vec3 p0 = vec3(a0.xy, h.x);
	vec3 p1 = vec3(a0.zw, h.y);
	vec3 p2 = vec3(a1.xy, h.z);
	vec3 p3 = vec3(a1.zw, h.w);

//Normalise gradients
	//vec4 norm = taylorInvSqrt(vec4(dot(p0,p0), dot(p1,p1), dot(p2, p2), dot(p3,p3)));
	vec4 norm = rsqrt(vec4(dot(p0, p0), dot(p1, p1), dot(p2, p2), dot(p3, p3)));
    p0 *= norm.x;
    p1 *= norm.y;
    p2 *= norm.z;
    p3 *= norm.w;

// Mix final noise value
	vec4 m = max(0.6 - vec4(dot(x0, x0), dot(x1, x1), dot(x2, x2), dot(x3, x3)), 0.0);
    m = m * m;
    return 42.0 * dot(m * m, vec4(dot(p0, x0), dot(p1, x1), dot(p2, x2), dot(p3, x3)));
}

//////////////////////////////////////////////////////////////

// PRNG
// From https://www.shadertoy.com/view/4djSRW
float prng(in vec2 seed)
{
    seed = fract(seed * vec2(5.3983, 5.4427));
    seed += dot(seed.yx, seed.xy + vec2(21.5351, 14.3137));
    return fract(seed.x * seed.y * 95.4337);
}

//////////////////////////////////////////////////////////////

float noiseStack(vec3 pos, int octaves, float falloff)
{
    float noise = snoise(vec3(pos));
    float off = 1.0;
    if (octaves > 1)
    {
        pos *= 2.0;
        off *= falloff;
        noise = (1.0 - off) * noise + off * snoise(vec3(pos));
    }
    if (octaves > 2)
    {
        pos *= 2.0;
        off *= falloff;
        noise = (1.0 - off) * noise + off * snoise(vec3(pos));
    }
    if (octaves > 3)
    {
        pos *= 2.0;
        off *= falloff;
        noise = (1.0 - off) * noise + off * snoise(vec3(pos));
    }
    return (1.0 + noise) / 2.0;
}

vec2 noiseStackUV(vec3 pos, int octaves, float falloff, float diff)
{
    float displaceA = noiseStack(pos, octaves, falloff);
    float displaceB = noiseStack(pos + vec3(3984.293, 423.21, 5235.19), octaves, falloff);
    return vec2(displaceA, displaceB);
}

float4 mainImage(VertData v_in) : TARGET
{
    float2 UV = (1.0 - v_in.uv) * uv_scale;
    if (Invert)
        UV = v_in.uv * uv_scale;
    float alpha = saturate(Alpha_Percentage * .01);
    float flame_size = clamp(Flame_Size * .01, 0.0, 4.0);
    
    vec2 resolution = (.25 * uv_scale * UV.xy) + (0.75 * uv_scale);
    if (Full_Width)
    {
        resolution = (2.0 * (UV.xy)) / 1.0; //iResolution.xy;
       
    }
    resolution.x = mul(resolution.x, 1 / 1);
    float time = iTime * (Speed * 0.01);
	//vec2 drag = iMouse().xy;
	vec2 offset = iMouse().xy;
	//
    float xpart = UV.x / resolution.x;
    float ypart = UV.y / resolution.y;
	//
	
    float ypartClip = UV.y / ( flame_size * 75.0);
    float ypartClippedFalloff = clamp(2.0 - ypartClip, 0.0, 1.0);
    float ypartClipped = min(ypartClip, 1.0);
    float ypartClippedn = (1 - ypartClipped);
	//
    float xfuel = pow(1.0 - abs(2.0 * xpart - 1.0), 0.5); //pow(1.0-abs(2.0*xpart-1.0),0.5);
	//
    float timeSpeed = 0.5 * (Speed * 0.01);
    float realTime = -1.0 * timeSpeed * time;
	//
	vec2 coordScaled = -1 * Flame_Tongue_Size * UV - 0.1 * offset;
	vec3 position = vec3(coordScaled, 0.0); //  +vec3(1223.0, 6434.0, 8425.0);
	vec3 flow = vec3(4.1 * (0.5 - xpart) * pow(ypartClippedn, 4.0), -2.0 * xfuel * pow(ypartClippedn, 64.0), 0.0);
	vec3 timing = realTime * vec3(0.0, -1.7, 1.1) + flow;
	//
	vec3 displacePos = vec3(1.0, 0.5, 1.0) * 2.4 * position + realTime * vec3(0.01, -0.7, 1.3);
	vec3 displace3 = vec3(noiseStackUV(displacePos, 2, 0.4, 0.1), 0.0);
	//
	vec3 noiseCoord = (vec3(2.0, 1.0, 1.0) * position + timing + 0.4 * displace3) / 1.0;
    float noise = noiseStack(noiseCoord, 3, 0.4);
	//
    float flames = pow(ypartClipped, 0.3 * xfuel) * pow(noise, 0.3 * xfuel);
	//
    float f = ypartClippedFalloff * pow(Flame_Modifier - flames * flames * flames, 8.0);
    float fff = f * f * f;
	vec3 fire = 1.5 * vec3(f, fff, fff * fff);
	//
	// smoke
    float smokeNoise = 0.5 + snoise(0.4 * position + timing * vec3(1.0, 1.0, 0.2)) / 2.0;
    float smokePart = 0.3 * pow(xfuel, 3.0) * pow(ypart, 2.0) * (smokeNoise + 0.4 * (1.0 - noise));
	vec3 smoke = vec3(smokePart, smokePart, smokePart);
	//
	// sparks
    float sparkGridSize = Spark_Grid_Height;
	vec2 sparkCoord = UV *uv_size - vec2(2.0 * offset.x, 190.0 * sin(realTime));
    sparkCoord -= 30.0 * noiseStackUV(0.01 * vec3(sparkCoord, 15.0 * time), 1, 0.4, 0.1);
    sparkCoord += 100.0 * flow.xy;
    if (mod(sparkCoord.y / sparkGridSize, 2.0) < 1.0)
        sparkCoord.x += 0.5 * sparkGridSize;
	vec2 sparkGridIndex = vec2(floor(sparkCoord / sparkGridSize));
    float sparkRandom = prng( sparkGridIndex);
    float sparkLife = min(10.0 * (1.0 - min((sparkGridIndex.y + (190.0 * realTime / sparkGridSize)) / (24.0 - 20.0 * sparkRandom), 1.0)), 1.0);
	vec3 sparks = vec3(0.0, 0.0, 0.0);
    if (sparkLife > 0.0)
    {
        float sparkSize = xfuel * xfuel * sparkRandom * 0.08;
        float sparkRadians = 999.0 * sparkRandom * 2.0 * PI + 2.0 * time;
		vec2 sparkCircular = vec2(sin(sparkRadians), cos(sparkRadians));
		vec2 sparkOffset = (0.5 - sparkSize) * sparkGridSize * sparkCircular;
		vec2 sparkModulus = mod2(sparkCoord + sparkOffset, float2(sparkGridSize, sparkGridSize)) - 0.5 * float2(sparkGridSize, sparkGridSize);
        float sparkLength = length(sparkModulus);
        float sparksGray = max(0.0, 1.0 - sparkLength / (sparkSize * sparkGridSize));
        sparks = sparkLife * sparksGray * vec3(1.0, 0.3, 0.0);
    }
	//
    float4 rgba = vec4(max(fire, sparks) + smoke, 1.0);
    
    // remove dark areas per user
    float luma_fire = dot(rgba.rgb, float3(0.299, 0.587, 0.114));
    float luma_min_fire = smoothstep(lumaMin, lumaMin + lumaMinSmooth, luma_fire);
    rgba.a = clamp(luma_min_fire, 0.0, alpha);
	
    float4 color;
    float4 original_color;
	if (Apply_To_Image)
    {
        float4 color = image.Sample(textureSampler, v_in.uv);
        float4 original_color = color;
        if (color.a > 0.0)
        {    
            float luma = color.r * 0.299 + color.g * 0.587 + color.b * 0.114;
            if (Replace_Image_Color)
                color = float4(luma, luma, luma, luma);            
            rgba = lerp(original_color, lerp(original_color,rgba * color,rgba.a), alpha);
        }
        else
        {
            rgba = color;
        }
		
    }
    if (Apply_To_Specific_Color)
    {
        color = image.Sample(textureSampler, v_in.uv);
        original_color = color;
        color = (distance(color.rgb, Color_To_Replace.rgb) <= 0.075) ? rgba : color;
        rgba = lerp(original_color, color, alpha);
    }
    
    return rgba;
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

