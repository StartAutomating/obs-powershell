function Get-OBSZoomBlurShader {

[Alias('Set-OBSZoomBlurShader','Add-OBSZoomBlurShader')]
param(
# Set the samples of OBSZoomBlurShader
[ComponentModel.DefaultBindingProperty('samples')]
[Int32]
$Samples,
# Set the magnitude of OBSZoomBlurShader
[ComponentModel.DefaultBindingProperty('magnitude')]
[Single]
$Magnitude,
# Set the speed_percent of OBSZoomBlurShader
[Alias('speed_percent')]
[ComponentModel.DefaultBindingProperty('speed_percent')]
[Int32]
$SpeedPercent,
# Set the ease of OBSZoomBlurShader
[ComponentModel.DefaultBindingProperty('ease')]
[Management.Automation.SwitchParameter]
$Ease,
# Set the glitch of OBSZoomBlurShader
[ComponentModel.DefaultBindingProperty('glitch')]
[Management.Automation.SwitchParameter]
$Glitch,
# Set the notes of OBSZoomBlurShader
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
$shaderName = 'zoom_blur'
$ShaderNoun = 'OBSZoomBlurShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// zoom blur shader by Charles Fettinger for obs-shaderfilter plugin 3/2019
// https://github.com/Oncorporation/obs-shaderfilter
// https://github.com/dinfinity/mpc-pixel-shaders/blob/master/PS_Zoom%20Blur.hlsl 
//for Media Player Classic HC or BE
//Converted to OpenGL by Q-mii & Exeldro February 18, 2022
uniform int samples <
    string label = "Samples";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 32;
uniform float magnitude<
    string label = "Magnitude";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.5;
uniform int speed_percent <
    string label = "Speed percent";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 0;
uniform bool ease;
uniform bool glitch;
uniform string notes<
    string widget_type = "info";
> = "Speed Percent above zero will animate the zoom. Keep samples low to save power";

float EaseInOutCircTimer(float t,float b,float c,float d){
	t /= d/2;
	if (t < 1) return -c/2 * (sqrt(1 - t*t) - 1) + b;
	t -= 2;
	return c/2 * (sqrt(1 - t*t) + 1) + b;	
}

float Styler(float t,float b,float c,float d,bool ease)
{
	if (ease) return EaseInOutCircTimer(t,0,c,d);
	return t;
}

float4 mainImage(VertData v_in) : TARGET
{
	float speed = speed_percent * 0.01;

	// circular easing variable
	float t = 1.0 + sin(elapsed_time * speed);
	float b = 0.0; //start value
	float c = 2.0; //change value
	float d = 2.0; //duration

	if (glitch) t = clamp(t + ((rand_f *2) - 1), 0.0,2.0);

	b = Styler(t, 0, c, d, ease);
	float sample_speed = max(samples * b, 1.0);

	float PI = 3.1415926535897932384626433832795;//acos(-1);
	float4 c0 = image.Sample(textureSampler, v_in.uv);

	float xTrans = (v_in.uv.x*2)-1;
	float yTrans = 1-(v_in.uv.y*2);
	
	float angle = atan(yTrans/xTrans) + PI;
	if (sign(xTrans) == 1) {
		angle+= PI;
	}
	float radius = sqrt(pow(xTrans,2) + pow(yTrans,2));

	float2 currentCoord;
	float4 accumulatedColor = float4(0,0,0,0);

	float4 currentColor = image.Sample(textureSampler, currentCoord);
	accumulatedColor = currentColor;

	accumulatedColor = c0/sample_speed;
	for(int i = 1; i< sample_speed; i++) {
		float currentRadius ;
		// Distance to center dependent
		currentRadius = max(0,radius - (radius/1000 * i * magnitude * b));

		// Continuous;
		// currentRadius = max(0,radius - (0.0004 * i));

		currentCoord.x = (currentRadius * cos(angle)+1.0)/2.0;
		currentCoord.y = -1* ((currentRadius * sin(angle)-1.0)/2.0);

		float4 currentColor = image.Sample(textureSampler, currentCoord);
		accumulatedColor += currentColor/sample_speed;
		
	}

	return accumulatedColor;
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

