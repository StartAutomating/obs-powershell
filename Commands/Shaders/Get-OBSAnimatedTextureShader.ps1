function Get-OBSAnimatedTextureShader {

[Alias('Set-OBSAnimatedTextureShader','Add-OBSAnimatedTextureShader')]
param(
# Set the ViewProj of OBSAnimatedTextureShader
[ComponentModel.DefaultBindingProperty('ViewProj')]
[Single[][]]
$ViewProj,
# Set the image of OBSAnimatedTextureShader
[ComponentModel.DefaultBindingProperty('image')]
[String]
$Image,
# Set the elapsed_time of OBSAnimatedTextureShader
[Alias('elapsed_time')]
[ComponentModel.DefaultBindingProperty('elapsed_time')]
[Single]
$ElapsedTime,
# Set the uv_offset of OBSAnimatedTextureShader
[Alias('uv_offset')]
[ComponentModel.DefaultBindingProperty('uv_offset')]
[Single[]]
$UvOffset,
# Set the uv_scale of OBSAnimatedTextureShader
[Alias('uv_scale')]
[ComponentModel.DefaultBindingProperty('uv_scale')]
[Single[]]
$UvScale,
# Set the uv_pixel_interval of OBSAnimatedTextureShader
[Alias('uv_pixel_interval')]
[ComponentModel.DefaultBindingProperty('uv_pixel_interval')]
[Single[]]
$UvPixelInterval,
# Set the rand_f of OBSAnimatedTextureShader
[Alias('rand_f')]
[ComponentModel.DefaultBindingProperty('rand_f')]
[Single]
$RandF,
# Set the uv_size of OBSAnimatedTextureShader
[Alias('uv_size')]
[ComponentModel.DefaultBindingProperty('uv_size')]
[Single[]]
$UvSize,
# Set the notes of OBSAnimatedTextureShader
[ComponentModel.DefaultBindingProperty('notes')]
[String]
$Notes,
# Set the Animation_Image of OBSAnimatedTextureShader
[Alias('Animation_Image')]
[ComponentModel.DefaultBindingProperty('Animation_Image')]
[String]
$AnimationImage,
# Set the Colorization_Image of OBSAnimatedTextureShader
[Alias('Colorization_Image')]
[ComponentModel.DefaultBindingProperty('Colorization_Image')]
[String]
$ColorizationImage,
# Set the reverse of OBSAnimatedTextureShader
[ComponentModel.DefaultBindingProperty('reverse')]
[Management.Automation.SwitchParameter]
$Reverse,
# Set the bounce of OBSAnimatedTextureShader
[ComponentModel.DefaultBindingProperty('bounce')]
[Management.Automation.SwitchParameter]
$Bounce,
# Set the center_animation of OBSAnimatedTextureShader
[Alias('center_animation')]
[ComponentModel.DefaultBindingProperty('center_animation')]
[Management.Automation.SwitchParameter]
$CenterAnimation,
# Set the polar_animation of OBSAnimatedTextureShader
[Alias('polar_animation')]
[ComponentModel.DefaultBindingProperty('polar_animation')]
[Management.Automation.SwitchParameter]
$PolarAnimation,
# Set the polar_angle of OBSAnimatedTextureShader
[Alias('polar_angle')]
[ComponentModel.DefaultBindingProperty('polar_angle')]
[Single]
$PolarAngle,
# Set the polar_height of OBSAnimatedTextureShader
[Alias('polar_height')]
[ComponentModel.DefaultBindingProperty('polar_height')]
[Single]
$PolarHeight,
# Set the speed_horizontal_percent of OBSAnimatedTextureShader
[Alias('speed_horizontal_percent')]
[ComponentModel.DefaultBindingProperty('speed_horizontal_percent')]
[Single]
$SpeedHorizontalPercent,
# Set the speed_vertical_percent of OBSAnimatedTextureShader
[Alias('speed_vertical_percent')]
[ComponentModel.DefaultBindingProperty('speed_vertical_percent')]
[Single]
$SpeedVerticalPercent,
# Set the tint_speed_horizontal_percent of OBSAnimatedTextureShader
[Alias('tint_speed_horizontal_percent')]
[ComponentModel.DefaultBindingProperty('tint_speed_horizontal_percent')]
[Single]
$TintSpeedHorizontalPercent,
# Set the tint_speed_vertical_percent of OBSAnimatedTextureShader
[Alias('tint_speed_vertical_percent')]
[ComponentModel.DefaultBindingProperty('tint_speed_vertical_percent')]
[Single]
$TintSpeedVerticalPercent,
# Set the Alpha of OBSAnimatedTextureShader
[ComponentModel.DefaultBindingProperty('Alpha')]
[Single]
$Alpha,
# Set the Use_Animation_Image_Color of OBSAnimatedTextureShader
[Alias('Use_Animation_Image_Color')]
[ComponentModel.DefaultBindingProperty('Use_Animation_Image_Color')]
[Management.Automation.SwitchParameter]
$UseAnimationImageColor,
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
$shaderName = 'animated_texture'
$ShaderNoun = 'OBSAnimatedTextureShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Animated Texture By Charles Fettinger (https://github.com/Oncorporation)  3/2020
// Animates a texture with polar sizing and color options
// for use with obs-shaderfilter 1.0
//Converted to OpenGL by Q-mii & Exeldro February 24, 2022
uniform float4x4 ViewProj;
uniform texture2d image;

uniform float elapsed_time;
uniform float2 uv_offset;
uniform float2 uv_scale;
uniform float2 uv_pixel_interval;
uniform float rand_f;
uniform float2 uv_size;
uniform string notes;

uniform texture2d Animation_Image;
uniform texture2d Colorization_Image;
uniform bool reverse = false;
uniform bool bounce = false;
uniform bool center_animation = true;
uniform bool polar_animation = true;
uniform float polar_angle = 90.0;
uniform float polar_height = 1.0;
uniform float speed_horizontal_percent = 50;
uniform float speed_vertical_percent = 5;
uniform float tint_speed_horizontal_percent = 50;
uniform float tint_speed_vertical_percent = 5;
uniform float Alpha = 1.0;
uniform bool Use_Animation_Image_Color = true;

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

float4 convert_pmalpha(float4 color)
{
	float4 ret = color;
	if (color.a >= 0.001)
		ret.xyz /= color.a;
	else
		ret = float4(0.0, 0.0, 0.0, 0.0);
	return ret;
}

float2 time(float2 speed_dir)
{
	float PI = 3.1415926535897932384626433832795; //acos(-1);

	float2 t = (elapsed_time * speed_dir) ;
	if (bounce) 
	{
		// coordinates moved from -1.0 to 1.0 to 0.0 to 2.0 then modified to fit screen
		t.x = sin(elapsed_time * speed_dir.x * PI * 0.6667) + 1.0;
		t.y = cos(elapsed_time * speed_dir.y * PI) + 1.0;
		t *= -0.5;
	}

	if (reverse)
		t = t * -1;
	return t;
}

VertData mainTransform(VertData v_in)
{
	float2 speed_dir = float2(speed_horizontal_percent * 0.01, speed_vertical_percent * 0.01);	

	VertData vert_out;
	//float2 direction = abs(sin((elapsed_time - 0.001) * speed_dir));	

	float2 offset = uv_offset;

	if (center_animation)
	{
		vert_out.uv = v_in.uv - 0.5f;
	} 
	else 
	{	
		offset += time(speed_dir);
		vert_out.pos = mul(float4(v_in.pos.xyz, 1.0), ViewProj);
		vert_out.uv  = v_in.uv * uv_scale + offset;
	}

	return vert_out;
}


float4 mainImage(VertData v_in) : TARGET
{
	float PI = 3.1415926535897932384626433832795; //acos(-1);
	float PI180th = 0.0174532925; //PI divided by 180

	float2 speed_dir = float2(speed_horizontal_percent * 0.01, speed_vertical_percent * 0.01);
	float2 tint_speed_dir = float2(tint_speed_horizontal_percent * 0.01, tint_speed_vertical_percent * 0.01);

	//compensate for background vertex shader values
	float2 background_offset = float2(-.5,-.5);
	if (!center_animation)
		background_offset = time(speed_dir);
	float4 rgba =  image.Sample(textureSampler, v_in.uv - background_offset); //float4(0.0,0.0,0.0,0.01);

	// Convert our texture coordinates to polar form:
	if (polar_animation) {
	
	    float2 polar = float2(
	           atan2(v_in.uv.y, v_in.uv.x) / (polar_angle * PI180th * 4), // angle
	           log(dot(v_in.uv, v_in.uv)) * -1 * (polar_height * PI180th * PI) // log-radius
	        );

	    // Check how much our texture sampling point changes between
	    // neighbouring pixels to the sides (ddx) and above/below (ddy)
	    ///float4 gradient = float4(ddx(polar), ddy(polar));

	    // If our angle wraps around between adjacent samples,
	    // discard one full rotation from its value and keep the fraction.
	    ///gradient.xz = frac(gradient.xz + 1.5f) - 0.5f;

	    float2 tintUVs = polar * 4;
	    tintUVs += time(tint_speed_dir);

	    // Apply texture scale
    	polar *= 4; 
    	// Scroll the texture over time.
    	polar += time(speed_dir);
    	float4 animation = Animation_Image.Sample(textureSampler, frac(polar));
    	

    	float keyAmount = distance(animation.rgb,float3(0.0,0.0,0.0));
    	float intensity = dot(animation.rgb ,float3(0.299,0.587,0.114));
    	//animation.a = clamp((intensity),0.0,1.0);
    	if (Use_Animation_Image_Color)
    	{
    		animation.rgb *= Colorization_Image.Sample(textureSampler, frac(tintUVs)).rgb;
    	}
    	else
    	{
    		animation.rgb =  Colorization_Image.Sample(textureSampler, frac(tintUVs)).rgb;
    	}
    	//if (keyAmount > 0.5f)     		
    		rgba = lerp(rgba, animation, animation.a * Alpha);
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

