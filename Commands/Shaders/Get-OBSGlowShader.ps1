function Get-OBSGlowShader {

[Alias('Set-OBSGlowShader','Add-OBSGlowShader')]
param(
# Set the glow_percent of OBSGlowShader
[Alias('glow_percent')]
[ComponentModel.DefaultBindingProperty('glow_percent')]
[Int32]
$GlowPercent,
# Set the blur of OBSGlowShader
[ComponentModel.DefaultBindingProperty('blur')]
[Int32]
$Blur,
# Set the min_brightness of OBSGlowShader
[Alias('min_brightness')]
[ComponentModel.DefaultBindingProperty('min_brightness')]
[Int32]
$MinBrightness,
# Set the max_brightness of OBSGlowShader
[Alias('max_brightness')]
[ComponentModel.DefaultBindingProperty('max_brightness')]
[Int32]
$MaxBrightness,
# Set the pulse_speed of OBSGlowShader
[Alias('pulse_speed')]
[ComponentModel.DefaultBindingProperty('pulse_speed')]
[Int32]
$PulseSpeed,
# Set the ease of OBSGlowShader
[ComponentModel.DefaultBindingProperty('ease')]
[Management.Automation.SwitchParameter]
$Ease,
# Set the notes of OBSGlowShader
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
$shaderName = 'glow'
$ShaderNoun = 'OBSGlowShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
//Converted to OpenGL by Exeldro February 21, 2022
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
uniform int pulse_speed<
    string label = "Pulse speed";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 0;
uniform bool ease;
uniform string notes<
    string widget_type = "info";
> = "''ease'' - makes the animation pause at the begin and end for a moment,''glow_percent'' - how much brightness to add (recommend 0-100). ''blur'' - how far should the glow extend (recommend 1-4).''pulse_speed'' - (0-100). ''min/max brightness'' - floor and ceiling brightness level to target for glows.";


float EaseInOutCircTimer(float t,float b,float c,float d){
	t /= d/2.0;
	if (t < 1.0) return -c/2.0 * (sqrt(1.0 - t*t) - 1.0) + b;
	t -= 2.0;
	return c/2.0 * (sqrt(1.0 - t*t) + 1.0) + b;	
}

float BlurStyler(float t,float b,float c,float d,bool ease)
{
	if (ease) return EaseInOutCircTimer(t,0.0,c,d);
	return t;
}

float4 mainImage(VertData v_in) : TARGET
{
	float2 offsets[4];
    offsets[0] = float2(-0.1,  0.125);
    offsets[1] = float2(-0.1, -0.125);
    offsets[2] = float2(0.1, -0.125);
    offsets[3] = float2(0.1,  0.125);

	// convert input for vector math
	float4 col = image.Sample(textureSampler, v_in.uv);
	float blur_amount = float(blur) /100.0;
	float glow_amount = float(glow_percent) * 0.01;
	float speed = float(pulse_speed) * 0.01;	
	float luminance_floor = float(min_brightness) /100.0;
	float luminance_ceiling = float(max_brightness) /100.0;

	if (col.a > 0.0)
	{
		//circular easing variable
		float t = 1.0 + sin(elapsed_time * speed);
		float b = 0.0; //start value
		float c = 2.0; //change value
		float d = 2.0; //duration

		// simple glow calc
		for (int n = 0; n < 4; n++) {
			b = BlurStyler(t, 0, c, d, ease);
			float4 ncolor = image.Sample(textureSampler, v_in.uv + (blur_amount * b) * offsets[n]);
			float intensity = ncolor.r * 0.299 + ncolor.g * 0.587 + ncolor.b * 0.114;
			if ((intensity >= luminance_floor) && (intensity <= luminance_ceiling))
			{
				ncolor.a = clamp(ncolor.a * glow_amount, 0.0, 1.0);
				col += (ncolor * (glow_amount * b));
			}
		}
	}
	return col;

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

