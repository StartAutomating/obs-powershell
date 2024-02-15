function Get-OBSSelectiveColorShader {

[Alias('Set-OBSSelectiveColorShader','Add-OBSSelectiveColorShader')]
param(
# Set the cutoff_Red of OBSSelectiveColorShader
[Alias('cutoff_Red')]
[ComponentModel.DefaultBindingProperty('cutoff_Red')]
[Single]
$CutoffRed,
# Set the cutoff_Green of OBSSelectiveColorShader
[Alias('cutoff_Green')]
[ComponentModel.DefaultBindingProperty('cutoff_Green')]
[Single]
$CutoffGreen,
# Set the cutoff_Blue of OBSSelectiveColorShader
[Alias('cutoff_Blue')]
[ComponentModel.DefaultBindingProperty('cutoff_Blue')]
[Single]
$CutoffBlue,
# Set the cutoff_Yellow of OBSSelectiveColorShader
[Alias('cutoff_Yellow')]
[ComponentModel.DefaultBindingProperty('cutoff_Yellow')]
[Single]
$CutoffYellow,
# Set the acceptance_Amplifier of OBSSelectiveColorShader
[Alias('acceptance_Amplifier')]
[ComponentModel.DefaultBindingProperty('acceptance_Amplifier')]
[Single]
$AcceptanceAmplifier,
# Set the show_Red of OBSSelectiveColorShader
[Alias('show_Red')]
[ComponentModel.DefaultBindingProperty('show_Red')]
[Management.Automation.SwitchParameter]
$ShowRed,
# Set the show_Green of OBSSelectiveColorShader
[Alias('show_Green')]
[ComponentModel.DefaultBindingProperty('show_Green')]
[Management.Automation.SwitchParameter]
$ShowGreen,
# Set the show_Blue of OBSSelectiveColorShader
[Alias('show_Blue')]
[ComponentModel.DefaultBindingProperty('show_Blue')]
[Management.Automation.SwitchParameter]
$ShowBlue,
# Set the show_Yellow of OBSSelectiveColorShader
[Alias('show_Yellow')]
[ComponentModel.DefaultBindingProperty('show_Yellow')]
[Management.Automation.SwitchParameter]
$ShowYellow,
# Set the notes of OBSSelectiveColorShader
[ComponentModel.DefaultBindingProperty('notes')]
[String]
$Notes,
# Set the background_type of OBSSelectiveColorShader
[Alias('background_type')]
[ComponentModel.DefaultBindingProperty('background_type')]
[Int32]
$BackgroundType,
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
$shaderName = 'selective_color'
$ShaderNoun = 'OBSSelectiveColorShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Selective Color shader by Charles Fettinger for obs-shaderfilter plugin 3/2019
//https://github.com/Oncorporation/obs-shaderfilter
//updated 4/13/2020: take into account the opacity/alpha of input image		-thanks Skeletonbow for suggestion
//Converted to OpenGL by Q-mii February 25, 2020
uniform float cutoff_Red<
    string label = "cutoff Red";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.40;
uniform float cutoff_Green<
    string label = "cutoff Green";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.025;
uniform float cutoff_Blue<
    string label = "cutoff Blue";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.25;
uniform float cutoff_Yellow<
    string label = "cutoff Yellow";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.25;
uniform float acceptance_Amplifier<
    string label = "acceptance Amplifier";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 20.0;
    float step = 0.001;
> = 5.0;

uniform bool show_Red = true;
uniform bool show_Green = true;
uniform bool show_Blue = true;
uniform bool show_Yellow = true;
uniform string notes<
    string widget_type = "info";
> = "defaults: .4,.03,.25,.25, 5.0, true,true, true, true. cuttoff higher = less color, 0 = all 1 = none.";
uniform int background_type<
  string label = "background type";
  string widget_type = "select";
  int    option_0_value = 0;
  string option_0_label = "Grey";
  int    option_1_value = 1;
  string option_1_label = "Luma";
  int    option_2_value = 2;
  string option_2_label = "White";
  int    option_3_value = 3;
  string option_3_label = "Black";
  int    option_4_value = 4;
  string option_4_label = "Transparent";
  int    option_5_value = 5;
  string option_5_label = "Background Color";
> = 0;

float4 mainImage(VertData v_in) : TARGET
{
	const float PI		= 3.1415926535897932384626433832795;//acos(-1);
	const float3 coefLuma = float3(0.2126, 0.7152, 0.0722);
	float4 color		= image.Sample(textureSampler, v_in.uv);

	float luminance 	= dot(coefLuma, color.rgb);	
	float4 gray			= float4(luminance, luminance, luminance, 1.0);

	 if (background_type == 0)
	 {
	 	luminance		= (color.r + color.g + color.b) * 0.3333;
	 	gray 			= float4(luminance,luminance,luminance, 1.0);
	 }	 	
	 //if (background_type == 1)
	 //{
	 //	gray 			= float4(luminance,luminance,luminance, 1.0);
	 //}
	 if (background_type == 2)
	 	gray 			= float4(1.0,1.0,1.0,1.0);
	 if (background_type == 3)
	 	gray 			= float4(0.0,0.0,0.0,1.0);
	 if (background_type == 4)
	 	gray.a 			=  0.01;
	 if (background_type == 5)
	 	gray 			= color;

	float redness		= max ( min ( color.r - color.g , color.r - color.b ) / color.r , 0);
	float greenness		= max ( min ( color.g - color.r , color.g - color.b ) / color.g , 0);
	float blueness		= max ( min ( color.b - color.r , color.b - color.g ) / color.b , 0);
	
	float rgLuminance	= (color.r*1.4 + color.g*0.6)/2;
	float rgDiff		= abs(color.r-color.g)*1.4;

 	float yellowness	= 0.1 + rgLuminance * 1.2 - color.b - rgDiff;

	float4 accept;
	accept.r			= float(show_Red) * (redness - cutoff_Red);
	accept.g			= float(show_Green) * (greenness - cutoff_Green);
	accept.b			= float(show_Blue) * (blueness - cutoff_Blue);
	accept[3]			= float(show_Yellow) * (yellowness - cutoff_Yellow);

	float acceptance	= max (accept.r, max(accept.g, max(accept.b, max(accept[3],0))));
	float modAcceptance	= min (acceptance * acceptance_Amplifier, 1);

	float4 result = color;
	if (result.a > 0) {
		result			= modAcceptance * color + (1.0 - modAcceptance) * gray;
		//result.a 		*= gray.a;
	}

	return result;
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

