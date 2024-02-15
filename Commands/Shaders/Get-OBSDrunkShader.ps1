function Get-OBSDrunkShader {

[Alias('Set-OBSDrunkShader','Add-OBSDrunkShader')]
param(
# Set the color_matrix of OBSDrunkShader
[Alias('color_matrix')]
[ComponentModel.DefaultBindingProperty('color_matrix')]
[Single[][]]
$ColorMatrix,
# Set the glow_percent of OBSDrunkShader
[Alias('glow_percent')]
[ComponentModel.DefaultBindingProperty('glow_percent')]
[Int32]
$GlowPercent,
# Set the blur of OBSDrunkShader
[ComponentModel.DefaultBindingProperty('blur')]
[Int32]
$Blur,
# Set the min_brightness of OBSDrunkShader
[Alias('min_brightness')]
[ComponentModel.DefaultBindingProperty('min_brightness')]
[Int32]
$MinBrightness,
# Set the max_brightness of OBSDrunkShader
[Alias('max_brightness')]
[ComponentModel.DefaultBindingProperty('max_brightness')]
[Int32]
$MaxBrightness,
# Set the pulse_speed_percent of OBSDrunkShader
[Alias('pulse_speed_percent')]
[ComponentModel.DefaultBindingProperty('pulse_speed_percent')]
[Int32]
$PulseSpeedPercent,
# Set the Apply_To_Alpha_Layer of OBSDrunkShader
[Alias('Apply_To_Alpha_Layer')]
[ComponentModel.DefaultBindingProperty('Apply_To_Alpha_Layer')]
[Management.Automation.SwitchParameter]
$ApplyToAlphaLayer,
# Set the glow_color of OBSDrunkShader
[Alias('glow_color')]
[ComponentModel.DefaultBindingProperty('glow_color')]
[String]
$GlowColor,
# Set the ease of OBSDrunkShader
[ComponentModel.DefaultBindingProperty('ease')]
[Management.Automation.SwitchParameter]
$Ease,
# Set the glitch of OBSDrunkShader
[ComponentModel.DefaultBindingProperty('glitch')]
[Management.Automation.SwitchParameter]
$Glitch,
# Set the notes of OBSDrunkShader
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
$shaderName = 'drunk'
$ShaderNoun = 'OBSDrunkShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Drunk shader by Charles Fettinger  (https://github.com/Oncorporation)  2/2019
//Converted to OpenGL by Q-mii & Exeldro March 11, 2022
uniform float4x4 color_matrix;


uniform int glow_percent<
    string label = "Glow percent";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 10;
uniform int blur<
    string label = "Blur";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 1;
uniform int min_brightness<
    string label = "Min brightness";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 27;
uniform int max_brightness<
    string label = "Max brightness";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 100;
uniform int pulse_speed_percent<
    string label = "Pulse speed percent";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 0;
uniform bool Apply_To_Alpha_Layer = true;
uniform float4 glow_color;
uniform bool ease;
uniform bool glitch;
uniform string notes<
    string widget_type = "info";
> ="''drunk refers to the bad blur effect of using 4 coordinates to blur. ''blur'' - the distance between the 4 copies (recommend 1-4)";


// Gaussian Blur
float Gaussian(float x, float o) {
	const float pivalue = 3.1415926535897932384626433832795;
	return (1.0 / (o * sqrt(2.0 * pivalue))) * exp((-(x * x)) / (2 * (o * o)));
}


float EaseInOutCircTimer(float t,float b,float c,float d){
	t /= d/2;
	if (t < 1) return -c/2 * (sqrt(1 - t*t) - 1) + b;
	t -= 2;
	return c/2 * (sqrt(1 - t*t) + 1) + b;	
}

float BlurStyler(float t,float b,float c,float d,bool ease)
{
	if (ease) return EaseInOutCircTimer(t,0,c,d);
	return t;
}

float4 InternalGaussianPrecalculated(float2 p_uv, float2 p_uvStep, int p_radius,
  texture2d p_image, float2 p_imageTexel,
  texture2d p_kernel, float2 p_kernelTexel) {
	float4 l_value = image.Sample(pointClampSampler, p_uv)
		* kernel.Sample(pointClampSampler, float2(0, 0)).r;
	float2 l_uvoffset = float2(0, 0);
	for (int k = 1; k <= p_radius; k++) {
		l_uvoffset += p_uvStep;
		float l_g = kernel.Sample(pointClampSampler, p_kernelTexel * k).r;
		float4 l_p = image.Sample(pointClampSampler, p_uv + l_uvoffset) * l_g;
		float4 l_n = image.Sample(pointClampSampler, p_uv - l_uvoffset) * l_g;
		l_value += l_p + l_n;
	}
	return l_value;
}

float4 mainImage(VertData v_in) : TARGET
{
	float2 offsets[4];
    offsets[0] = float2(-0.05,  0.066);
    offsets[1] = float2(-0.05, -0.066);
    offsets[2] = float2(0.05, -0.066);
    offsets[3] = float2(0.05,  0.066);

	// convert input for vector math
	float blur_amount = float(blur) /100;
	float glow_amount = float(glow_percent) * 0.1;
	float speed = float(pulse_speed_percent) * 0.01;	
	float luminance_floor = float(min_brightness) * 0.01;
	float luminance_ceiling = float(max_brightness) * 0.01;

	float4 color = image.Sample(textureSampler, v_in.uv);
	float4 temp_color = color;
	bool glitch_on = glitch;

	//circular easing variable
	float t = 1 + sin(elapsed_time * speed);
	float b = 0.0; //start value
	float c = 2.0; //change value
	float d = 2.0; //duration

	//if(color.a <= 0.0) color.rgb = float3(0.0,0.0,0.0);
	float4 glitch_color = glow_color;

	for (int n = 0; n < 4; n++){			
		//blur sample
		b = BlurStyler(t,0,c,d,ease);
		float4 ncolor = image.Sample(textureSampler, v_in.uv + (blur_amount * b) * offsets[n]) ;

		//test for rand_f color
		if (glitch) {			
			glitch_color = float4(glow_color.rgb * rand_f,glow_color.a);
			if ((color.r == rand_f) || (color.g == rand_f) || (color.b == rand_f))
			{
				glitch_on = true;
			}			
		}	

		float intensity = ncolor.r * 0.299 + ncolor.g * 0.587 + ncolor.b * 0.114;
		if (((intensity >= luminance_floor) && (intensity <= luminance_ceiling)) || // test luminance
			((color.r == glow_color.r) && (color.g == glow_color.g) && (color.b == glow_color.b)) || //test for chosen color
			glitch_on) //test for rand color
		{
			//glow calc
			if (ncolor.a > 0.0  || Apply_To_Alpha_Layer == false)
			{
				ncolor.a = clamp(ncolor.a * glow_amount, 0.0, 1.0);
				//temp_color = max(temp_color,ncolor) * glow_color ;//* ((1-ncolor.a) + color * ncolor.a);
				//temp_color += (ncolor * float4(glow_color.rbg, glow_amount));

				// use temp_color as floor, add glow, use highest alpha of blur pixels, then multiply by glow color
				// max is used to simulate addition of vector texture color
				temp_color = float4(max(temp_color.rgb, ncolor.rgb * (glow_amount * (b / 2))),  // color effected by glow over time
					max(temp_color.a, (glow_amount * (b / 2))))  // alpha affected by glow over time
					* (glitch_color * (b / 2)); // glow color affected by glow over time
			}
		}
	}
	// grab lighter color
	return max(color,temp_color);
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

