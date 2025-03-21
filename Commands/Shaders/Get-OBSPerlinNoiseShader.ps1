function Get-OBSPerlinNoiseShader {

[Alias('Set-OBSPerlinNoiseShader','Add-OBSPerlinNoiseShader')]
param(
# Set the speed of OBSPerlinNoiseShader
[ComponentModel.DefaultBindingProperty('speed')]
[Single]
$Speed,
# Set the animated of OBSPerlinNoiseShader
[ComponentModel.DefaultBindingProperty('animated')]
[Management.Automation.SwitchParameter]
$Animated,
# Set the apply_to_channel of OBSPerlinNoiseShader
[Alias('apply_to_channel')]
[ComponentModel.DefaultBindingProperty('apply_to_channel')]
[Management.Automation.SwitchParameter]
$ApplyToChannel,
# Set the inverted of OBSPerlinNoiseShader
[ComponentModel.DefaultBindingProperty('inverted')]
[Management.Automation.SwitchParameter]
$Inverted,
# Set the multiply of OBSPerlinNoiseShader
[ComponentModel.DefaultBindingProperty('multiply')]
[Management.Automation.SwitchParameter]
$Multiply,
# Set the speed_horizonal of OBSPerlinNoiseShader
[Alias('speed_horizonal')]
[ComponentModel.DefaultBindingProperty('speed_horizonal')]
[Single]
$SpeedHorizonal,
# Set the speed_vertical of OBSPerlinNoiseShader
[Alias('speed_vertical')]
[ComponentModel.DefaultBindingProperty('speed_vertical')]
[Single]
$SpeedVertical,
# Set the iterations of OBSPerlinNoiseShader
[ComponentModel.DefaultBindingProperty('iterations')]
[Int32]
$Iterations,
# Set the white_noise of OBSPerlinNoiseShader
[Alias('white_noise')]
[ComponentModel.DefaultBindingProperty('white_noise')]
[Single]
$WhiteNoise,
# Set the black_noise of OBSPerlinNoiseShader
[Alias('black_noise')]
[ComponentModel.DefaultBindingProperty('black_noise')]
[Single]
$BlackNoise,
# Set the notes of OBSPerlinNoiseShader
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
$shaderName = 'perlin_noise'
$ShaderNoun = 'OBSPerlinNoiseShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
//
// Noise Shader Library for Unity - https://github.com/keijiro/NoiseShader
// Modified and improved my Charles Fettinger (https://github.com/Oncorporation)  1/2019
//
// Original work (webgl-noise) Copyright (C) 2011 Stefan Gustavson
// Translation and modification was made by Keijiro Takahashi.
// Conversion for OBS by Charles Fettinger.
//
// This shader is based on the webgl-noise GLSL shader. For further details
// of the original shader, please see the following description from the
// original source code.
//
 //
// GLSL textureless classic 2D noise "cnoise", (white_noise)
// with an RSL-style periodic variant "pnoise" (black_noise).
// Author:  Stefan Gustavson (stefan.gustavson@liu.se)
// Version: 2011-08-22
//
// Many thanks to Ian McEwan of Ashima Arts for the
// ideas for permutation and gradient selection.
//
// Copyright (c) 2011 Stefan Gustavson. All rights reserved.
// Distributed under the MIT license. See LICENSE file.
// https://github.com/ashima/webgl-noise
//Converted to OpenGL by Q-mii & Exeldro March 8, 2022
 float4 mod(float4 x, float4 y)
{
  return x - y * floor(x / y);
}
 float4 mod289(float4 x)
{
  return x - floor(x / 289.0) * 289.0;
}
 float4 permute(float4 x)
{
  return mod289(((x*34.0)+1.0)*x);
}
 float4 taylorInvSqrt(float4 r)
{
  return 1.79284291400159 - r * 0.85373472095314;
}
 float2 fade(float2 t) {
  return t*t*t*(t*(t*6.0-15.0)+10.0);
}
 // Classic Perlin noise
float cnoise(float2 P)
{
  float4 Pi = floor(P.xyxy) + float4(0.0, 0.0, 1.0, 1.0);
  float4 Pf = frac (P.xyxy) - float4(0.0, 0.0, 1.0, 1.0);
  Pi = mod289(Pi); // To avoid truncation effects in permutation
  float4 ix = Pi.xzxz;
  float4 iy = Pi.yyww;
  float4 fx = Pf.xzxz;
  float4 fy = Pf.yyww;
   float4 i = permute(permute(ix) + iy);
   float4 gx = frac(i / 41.0) * 2.0 - 1.0 ;
  float4 gy = abs(gx) - 0.5 ;
  float4 tx = floor(gx + 0.5);
  gx = gx - tx;
   float2 g00 = float2(gx.x,gy.x);
  float2 g10 = float2(gx.y,gy.y);
  float2 g01 = float2(gx.z,gy.z);
  float2 g11 = float2(gx.w,gy.w);
   float4 norm = taylorInvSqrt(float4(dot(g00, g00), dot(g01, g01), dot(g10, g10), dot(g11, g11)));
  g00 *= norm.x;
  g01 *= norm.y;
  g10 *= norm.z;
  g11 *= norm.w;
   float n00 = dot(g00, float2(fx.x, fy.x));
  float n10 = dot(g10, float2(fx.y, fy.y));
  float n01 = dot(g01, float2(fx.z, fy.z));
  float n11 = dot(g11, float2(fx.w, fy.w));
   float2 fade_xy = fade(Pf.xy);
  float2 n_x = lerp(float2(n00, n01), float2(n10, n11), fade_xy.x);
  float n_xy = lerp(n_x.x, n_x.y, fade_xy.y);
  return 2.3 * n_xy;
}
 // Classic Perlin noise, periodic variant
float pnoise(float2 P, float2 rep)
{
  float4 Pi = floor(P.xyxy) + float4(0.0, 0.0, 1.0, 1.0);
  float4 Pf = frac (P.xyxy) - float4(0.0, 0.0, 1.0, 1.0);
  Pi = mod(Pi, rep.xyxy); // To create noise with explicit period
  Pi = mod289(Pi);        // To avoid truncation effects in permutation
  float4 ix = Pi.xzxz;
  float4 iy = Pi.yyww;
  float4 fx = Pf.xzxz;
  float4 fy = Pf.yyww;
   float4 i = permute(permute(ix) + iy);
   float4 gx = frac(i / 41.0) * 2.0 - 1.0 ;
  float4 gy = abs(gx) - 0.5 ;
  float4 tx = floor(gx + 0.5);
  gx = gx - tx;
   float2 g00 = float2(gx.x,gy.x);
  float2 g10 = float2(gx.y,gy.y);
  float2 g01 = float2(gx.z,gy.z);
  float2 g11 = float2(gx.w,gy.w);
   float4 norm = taylorInvSqrt(float4(dot(g00, g00), dot(g01, g01), dot(g10, g10), dot(g11, g11)));
  g00 *= norm.x;
  g01 *= norm.y;
  g10 *= norm.z;
  g11 *= norm.w;
   float n00 = dot(g00, float2(fx.x, fy.x));
  float n10 = dot(g10, float2(fx.y, fy.y));
  float n01 = dot(g01, float2(fx.z, fy.z));
  float n11 = dot(g11, float2(fx.w, fy.w));
   float2 fade_xy = fade(Pf.xy);
  float2 n_x = lerp(float2(n00, n01), float2(n10, n11), fade_xy.x);
  float n_xy = lerp(n_x.x, n_x.y, fade_xy.y);
  return 2.3 * n_xy;
}
 //The good bits~ adapting the noise generator for the plugin and giving some control over the shader
 //todo: pseudorandom number generator w/ seed
uniform float speed<
    string label = "Speed";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 10.0;
    float step = 0.001;
> = 0.5;
uniform bool animated;
uniform bool apply_to_channel;
uniform bool inverted;
uniform bool multiply;
uniform float speed_horizonal<
    string label = "Speed horizontal";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 10.0;
    float step = 0.001;
> = 0.5;
uniform float speed_vertical<
    string label = "Speed vertical";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 10.0;
    float step = 0.001;
> = 0;
uniform int iterations<
    string label = "Iterations";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 20;
    int step = 1;
> = 4;
//how much c_noise do we want? white
uniform float white_noise<
    string label = "White noise";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 10.0;
    float step = 0.001;
> = 0.5;
//how much p_noise do we want? black
uniform float black_noise<
    string label = "Black noise";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 10.0;
    float step = 0.001;
> = 0.5;
uniform string notes<
    string widget_type = "info";
> = "white noise and black noise and iterations.. enjoy!";

 float2 noisePosition(float t){
	return float2(sin(2.2 * t) - cos(1.4 * t), cos(1.3 * t) + sin(-1.9 *t));
}
 float4 mainImage(VertData v_in) : TARGET
{
	float4 color = image.Sample(textureSampler, v_in.uv);
	float t = elapsed_time * speed;
	float2 dir = float2(speed_horizonal,speed_vertical);
	
	if(!animated){
		float o = 0.5;
		float scale = 1.0;
		float w = 0.5;
		for(int i = 0; i < iterations; i++){
			float2 coord = v_in.uv * scale;
			float2 period = float2(scale * 2.0, scale * 2.0);
			
			if(white_noise == 0.0 && black_noise == 0.0){
				o += pnoise(coord, period) * w;
			} else {				
				if(white_noise != 0.0){
					o += cnoise(coord) * w * white_noise;
				}
				if(black_noise != 0.0){
					o += pnoise(coord, period) * w * black_noise;
				}
			}
			
			//o += pnoise(coord, period) * w;
			
			scale *= 2.0;
			w *= 0.5;
		}
		if(inverted){
			o = 1 - o;
		}
		if(apply_to_channel){
			if(multiply){
				return float4(color.r,color.g,color.b,color.a*o);
			} else {
				return float4(color.r,color.g,color.b,o);
			}
		} else {
			return float4(o,o,o,1.0);
		}
	} else {
		float o = 0.5;
		float scale = 1.0;
		float w = 0.5;
		for(int i = 0; i < iterations; i++){
			float2 coord = (v_in.uv + t*dir) * scale;
			float2 period = float2(scale * 2.0, scale * 2.0);
			
			if(white_noise == 0.0 && black_noise == 0.0){
				o += pnoise(coord, period) * w;
			} else {				
				if(white_noise != 0.0){
					o += cnoise(coord) * w * white_noise;
				}
				if(black_noise != 0.0){
					o += pnoise(coord, period) * w * black_noise;
				}
			}
			
			scale *= 2.0;
			w *= 0.5;
		}
		if(inverted){
			o = 1 - o;
		}
		if(apply_to_channel){
			if(multiply){
				return float4(color.r,color.g,color.b,color.a*o);
			} else {
				return float4(color.r,color.g,color.b,o);
			}
		} else {
			return float4(o,o,o,1.0);
		}
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

