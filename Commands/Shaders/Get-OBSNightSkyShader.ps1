function Get-OBSNightSkyShader {

[Alias('Set-OBSNightSkyShader','Add-OBSNightSkyShader')]
param(
# Set the speed of OBSNightSkyShader
[ComponentModel.DefaultBindingProperty('speed')]
[Single]
$Speed,
# Set the Include_Clouds of OBSNightSkyShader
[Alias('Include_Clouds')]
[ComponentModel.DefaultBindingProperty('Include_Clouds')]
[Management.Automation.SwitchParameter]
$IncludeClouds,
# Set the Include_Moon of OBSNightSkyShader
[Alias('Include_Moon')]
[ComponentModel.DefaultBindingProperty('Include_Moon')]
[Management.Automation.SwitchParameter]
$IncludeMoon,
# Set the center_width_percentage of OBSNightSkyShader
[Alias('center_width_percentage')]
[ComponentModel.DefaultBindingProperty('center_width_percentage')]
[Int32]
$CenterWidthPercentage,
# Set the center_height_percentage of OBSNightSkyShader
[Alias('center_height_percentage')]
[ComponentModel.DefaultBindingProperty('center_height_percentage')]
[Int32]
$CenterHeightPercentage,
# Set the Alpha_Percentage of OBSNightSkyShader
[Alias('Alpha_Percentage')]
[ComponentModel.DefaultBindingProperty('Alpha_Percentage')]
[Single]
$AlphaPercentage,
# Set the Apply_To_Image of OBSNightSkyShader
[Alias('Apply_To_Image')]
[ComponentModel.DefaultBindingProperty('Apply_To_Image')]
[Management.Automation.SwitchParameter]
$ApplyToImage,
# Set the Replace_Image_Color of OBSNightSkyShader
[Alias('Replace_Image_Color')]
[ComponentModel.DefaultBindingProperty('Replace_Image_Color')]
[Management.Automation.SwitchParameter]
$ReplaceImageColor,
# Set the number_stars of OBSNightSkyShader
[Alias('number_stars')]
[ComponentModel.DefaultBindingProperty('number_stars')]
[Int32]
$NumberStars,
# Set the SKY_COLOR of OBSNightSkyShader
[Alias('SKY_COLOR')]
[ComponentModel.DefaultBindingProperty('SKY_COLOR')]
[String]
$SKYCOLOR,
# Set the STAR_COLOR of OBSNightSkyShader
[Alias('STAR_COLOR')]
[ComponentModel.DefaultBindingProperty('STAR_COLOR')]
[String]
$STARCOLOR,
# Set the LIGHT_SKY of OBSNightSkyShader
[Alias('LIGHT_SKY')]
[ComponentModel.DefaultBindingProperty('LIGHT_SKY')]
[String]
$LIGHTSKY,
# Set the SKY_LIGHTNESS of OBSNightSkyShader
[Alias('SKY_LIGHTNESS')]
[ComponentModel.DefaultBindingProperty('SKY_LIGHTNESS')]
[Single]
$SKYLIGHTNESS,
# Set the MOON_COLOR of OBSNightSkyShader
[Alias('MOON_COLOR')]
[ComponentModel.DefaultBindingProperty('MOON_COLOR')]
[String]
$MOONCOLOR,
# Set the moon_size of OBSNightSkyShader
[Alias('moon_size')]
[ComponentModel.DefaultBindingProperty('moon_size')]
[Single]
$MoonSize,
# Set the moon_bump_size of OBSNightSkyShader
[Alias('moon_bump_size')]
[ComponentModel.DefaultBindingProperty('moon_bump_size')]
[Single]
$MoonBumpSize,
# Set the Moon_Position_x of OBSNightSkyShader
[Alias('Moon_Position_x')]
[ComponentModel.DefaultBindingProperty('Moon_Position_x')]
[Single]
$MoonPositionX,
# Set the Moon_Position_y of OBSNightSkyShader
[Alias('Moon_Position_y')]
[ComponentModel.DefaultBindingProperty('Moon_Position_y')]
[Single]
$MoonPositionY,
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
$shaderName = 'night_sky'
$ShaderNoun = 'OBSNightSkyShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Night Sky shader by Charles Fettinger for obs-shaderfilter plugin 6/2020 v.65
// https://github.com/Oncorporation/obs-shaderfilter
//https://www.shadertoy.com/view/3tfXRM Simple Night Sky - converted from and updated
//Converted to OpenGL by Q-mii & Exeldro February 22, 2022
uniform float speed<
    string label = "Speed";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 0.01;
> = 20.0;
uniform bool Include_Clouds = true;
uniform bool Include_Moon = true;
uniform int center_width_percentage<
    string label = "Center width percentage";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 50;
uniform int center_height_percentage<
    string label = "Center width percentage";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 50;
uniform float Alpha_Percentage<
    string label = "Alpha Percentage";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 0.01;
> = 95.0; //<Range(0.0,100.0)>
uniform bool Apply_To_Image = false;
uniform bool Replace_Image_Color = false;
uniform int number_stars<
    string label = "Number stars";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 20; //<Range(0,100)>

uniform float4 SKY_COLOR = { 0.027, 0.151, 0.354, 1.0 };
uniform float4 STAR_COLOR = { 0.92, 0.92, 0.14, 1.0 };
uniform float4 LIGHT_SKY = { 0.45, 0.61, 0.98, 1.0 };
uniform float SKY_LIGHTNESS<
    string label = "SKY LIGHTNESS";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.001;
> = .3;

 // Moon
uniform float4 MOON_COLOR = { .4, .25, 0.25, 1.0 };
uniform float moon_size<
    string label = "Moon size";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.18;
uniform float moon_bump_size<
    string label = "Moon bump size";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.14;
uniform float Moon_Position_x<
    string label = "Moon Position x";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = -0.6;
uniform float Moon_Position_y<
    string label = "Moon Position y";
    string widget_type = "slider";
    float minimum = -1.0;
    float maximum = 1.0;
    float step = 0.001;
> = -0.3;

#define PI 3.1416

//Noise functions from https://www.youtube.com/watch?v=zXsWftRdsvU
float noise11(float p) {
	return frac(sin(p*633.1847) * 9827.95);
}
    
float noise21(float2 p) {
	return frac(sin(p.x*827.221 + p.y*3228.8275) * 878.121);
}

float2 noise22(float2 p) {
	return frac(float2(sin(p.x*9378.35), sin(p.y*75.589)) * 556.89);
}

//From https://codepen.io/Tobsta/post/procedural-generation-part-1-1d-perlin-noise
float cosineInterpolation(float a, float b, float x) {
    float ft = x * PI;
    float f = (1. - cos(ft)) * .5;
    return a * (1. - f) + b * f;
}

float smoothNoise11(float p, float dist) {
    float prev = noise11(p-dist);
    float next = noise11(p+dist);
       
    return cosineInterpolation(prev, next, .5);
}

float smoothNoise21(float2 uv, float cells) {
	float2 lv = frac(uv*cells);
    float2 id = floor(uv*cells);
    
    //smoothstep function: maybe change it later!
    lv = lv*lv*(3.-2.*lv);
    
    float bl = noise21(id);
    float br = noise21(id+float2(1.,0.));
    float b = lerp(bl, br, lv.x);
    
    float tl = noise21(id+float2(0.,1.));
    float tr = noise21(id+float2(1.,1.));
    float t = lerp(tl, tr, lv.x);
    
    return lerp(b, t, lv.y);
}

float2 smoothNoise22(float2 uv, float cells) {
	float2 lv = frac(uv*cells);
    float2 id = floor(uv*cells);    
    
    lv = lv*lv*(3.-2.*lv);
    
    float2 bl = noise22(id);
    float2 br = noise22(id+float2(1.,0.));
    float2 b = lerp(bl, br, lv.x);
    
    float2 tl = noise22(id+float2(0.,1.));
    float2 tr = noise22(id+float2(1.,1.));
    float2 t = lerp(tl, tr, lv.x);
    
    return lerp(b, t, lv.y);
}

float valueNoise11(float p) {
	float c = smoothNoise11(p, 0.5);
    c += smoothNoise11(p, 0.25)*.5;
    c += smoothNoise11(p, 0.125)*.25;
    c += smoothNoise11(p, 0.0625)*.125;
    
    return c /= .875;
}

float valueNoise21(float2 uv) {
	float c = smoothNoise21(uv, 4.);
    c += smoothNoise21(uv, 8.)*.5;
    c += smoothNoise21(uv, 16.)*.25;
    c += smoothNoise21(uv, 32.)*.125;
    c += smoothNoise21(uv, 64.)*.0625;
    
    return c /= .9375;
}

float2 valueNoise22(float2 uv) {
	float2 c = smoothNoise22(uv, 4.);
    c += smoothNoise22(uv, 8.)*.5;
    c += smoothNoise22(uv, 16.)*.25;
    c += smoothNoise22(uv, 32.)*.125;
    c += smoothNoise22(uv, 64.)*.0625;
    
    return c /= .9375;
}

float3 points(float2 p, float2 uv, float3 color, float size, float blur) {
	float dist = distance(p, uv);    
    return color*smoothstep(size, size*(0.999-blur), dist);
}

float mapInterval(float x, float a, float b, float c, float d) {
	return (x-a)/(b-a) * (d-c) + c;
}

float blink(float time, float timeInterval) {
    float halfInterval = timeInterval / 2.0;
    //Get relative position in the bucket
    float p = fmod(time, timeInterval);
    
    
    if (p <= timeInterval / 2.) {
    	return smoothstep(0., 1., p/halfInterval);
    } else {
        return smoothstep(1., 0., (p-halfInterval)/halfInterval);
    }
}

float3 sampleBumps(float2 p, float2 uv, float radius, float spin) {
	float dist = distance(p, uv);
	float3 BumpSamples =  float3(0.,0.,0.);
    
    if (dist < radius) {
    	float bumps =  (1.-valueNoise21(uv*spin))*.1;
    	BumpSamples = float3(bumps, bumps, bumps);
    }
    return  BumpSamples;
}

float4 mainImage(VertData v_in) : TARGET
{
	float4 rgba;// = image.Sample(textureSampler, v_in.uv);
	float alpha = clamp(Alpha_Percentage *.01 ,0,1.0);
	float2 center_pixel_coordinates = float2((center_width_percentage * 0.01), (center_height_percentage * 0.01));
	float2 st = v_in.uv* uv_scale;
	float2 toCenter = center_pixel_coordinates - st;

    // Normalized pixel coordinates (from 0 to 1)
    float2 uv = v_in.uv;
    float2 ouv = uv;
    uv -= .5;
    uv.x *= uv_size.x/uv_size.y;
    
    float2 seed = toCenter / uv_size.xy;
    
    float time = elapsed_time + seed.x*speed;
        
    //float3 col = float3(0.0);
    //float m = valueNoise21(uv);    
	float3 col = lerp(SKY_COLOR.rgb, LIGHT_SKY.rgb, ouv.y-SKY_LIGHTNESS);
    
    col *= SKY_LIGHTNESS - (1.-ouv.y);
    
    //Add clouds
    if (Include_Clouds)
    {
	    float2 timeUv = uv;
	    timeUv.x += time*.1;
	    timeUv.y += valueNoise11(timeUv.x+.352)*.01;
	    float cloud = valueNoise21(timeUv);
	    col += cloud*.1;
    }

    //Add stars in the top part of the scene
    float timeInterval = speed *.5; //5.0
    float timeBucket = floor(time / timeInterval);  

    float2 moonPosition = float2(-1000, -1000);
    if (Include_Moon)
    {   
    	moonPosition = float2(Moon_Position_x, Moon_Position_y);
	    col += points(moonPosition, uv, MOON_COLOR.rgb,moon_size, 0.3);
	    // Moon bumps
	    col += sampleBumps(moonPosition, uv, moon_bump_size, 9. + fmod(time*.1,9));
    }

    for (float i = 0.; i < clamp(number_stars,0,100); i++) {
	    float2 starPosition = float2(i/10., i/10.);
        
        starPosition.x = mapInterval(valueNoise11(timeBucket + i*827.913)-.4, 0., 1., 0.825, -0.825);
        starPosition.y = mapInterval(valueNoise11(starPosition.x)-.3, 0., 1., 0.445, -0.445);
	    
        float starIntensity = blink(time+ (rand_f * i), timeInterval );
        //Hide stars that are behind the moon
        if (distance(starPosition, moonPosition) > moon_size) {
        	col += points(starPosition, uv, STAR_COLOR.rgb, 0.001, 0.0)*clamp(starIntensity-.1, 0.0, 1.0)*10.0;
        	col += points(starPosition, uv, STAR_COLOR.rgb, 0.009, 3.5)*starIntensity*3.0;
        }
    }
	//col = float3(blink(time, timeInterval));
	rgba = float4(col,alpha);

    // Output to screen
	if (Apply_To_Image)
	{
		float4 color = image.Sample(textureSampler, v_in.uv);
		float4 original_color = color;
		float luma = color.r * 0.299 + color.g * 0.587 + color.b * 0.114;
		if (Replace_Image_Color)
			color = float4(luma, luma, luma, luma); 
		rgba = lerp(original_color, rgba * color,alpha);
		
	}
	return rgba;
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

