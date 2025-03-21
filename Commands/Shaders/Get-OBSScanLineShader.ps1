function Get-OBSScanLineShader {

[Alias('Set-OBSScanLineShader','Add-OBSScanLineShader')]
param(
# Set the lengthwise of OBSScanLineShader
[ComponentModel.DefaultBindingProperty('lengthwise')]
[Management.Automation.SwitchParameter]
$Lengthwise,
# Set the animate of OBSScanLineShader
[ComponentModel.DefaultBindingProperty('animate')]
[Management.Automation.SwitchParameter]
$Animate,
# Set the speed of OBSScanLineShader
[ComponentModel.DefaultBindingProperty('speed')]
[Single]
$Speed,
# Set the angle of OBSScanLineShader
[ComponentModel.DefaultBindingProperty('angle')]
[Single]
$Angle,
# Set the shift of OBSScanLineShader
[ComponentModel.DefaultBindingProperty('shift')]
[Management.Automation.SwitchParameter]
$Shift,
# Set the boost of OBSScanLineShader
[ComponentModel.DefaultBindingProperty('boost')]
[Management.Automation.SwitchParameter]
$Boost,
# Set the floor of OBSScanLineShader
[ComponentModel.DefaultBindingProperty('floor')]
[Single]
$Floor,
# Set the period of OBSScanLineShader
[ComponentModel.DefaultBindingProperty('period')]
[Single]
$Period,
# Set the notes of OBSScanLineShader
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
$shaderName = 'scan_line'
$ShaderNoun = 'OBSScanLineShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Scan Line Effect for OBS Studio
// originally from Andersama (https://github.com/Andersama)
// Modified and improved my Charles Fettinger (https://github.com/Oncorporation)  1/2019
//Converted to OpenGL by Q-mii & Exeldro February 21, 2022
//Count the number of scanlines we want via height or width, adjusts the sin wave period
uniform bool lengthwise;
//Do we want the scanlines to move?
uniform bool animate;
//How fast do we want those scanlines to move?
uniform float speed<
    string label = "Speed";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 10000.0;
    float step = 1;
> = 1000;
//What angle should the scanlines come in at (based in degrees)
uniform float angle<
    string label = "angle";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 360.0;
    float step = 0.1;
> = 45;
//Turns on adjustment of the results, sin returns -1 -> 1 these settings will change the results a bit
//By default values for color range from 0 to 1
//Boost centers the result of the sin wave on 1*, to help maintain the brightness of the screen
uniform bool shift = true;
uniform bool boost = true;
//Increases the minimum value of the sin wave
uniform float floor<
    string label = "Floor";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 0.001;
> = 0.0;
//final adjustment to the period of the sin wave, we can''t / 0, need to be careful w/ user input
uniform float period<
    string label = "Period";
    string widget_type = "slider";
    float minimum = 1.0;
    float maximum = 1000.0;
    float step = 1.0;
> = 10.0;
uniform string notes<
    string widget_type = "info";
> = "floor affects the minimum opacity of the scan line";
float4 mainImage(VertData v_in) : TARGET
{
	//3.141592653589793238462643383279502884197169399375105820974944592307816406286208998628034825342117067982148086513282306647093844609550582231725359408128481 							3.141592653589793238462643383279502884197169399375105820974944592307816406286 
	// float pix2 = 6.2831853071795864769252;//86766559005768394338798750211641949
	 float nfloor = clamp(floor, 0.0, 100.0) * 0.01;
	 float nperiod = max(period, 1.0);
	 float gap = 1 - nfloor;
	 float pi   = 3.1415926535897932384626;
	 float2 direction = float2( cos(angle * pi / 180.0) , sin(angle * pi / 180.0) );
	 float nspeed = 0.0;
	if(animate){
		nspeed = speed * 0.0001;
	}
	
	float4 color = image.Sample(textureSampler, v_in.uv);
	
	float t = elapsed_time * nspeed;
	
	if(!lengthwise){
		 float base_height = 1.0 / uv_pixel_interval.y;
		 float h_interval = pi * base_height;
		
		float rh_sin = sin(((v_in.uv.y * direction.y + v_in.uv.x * direction.x) + t) * (h_interval / nperiod));
		if(shift){
			rh_sin = ((1.0 + rh_sin) * 0.5) * gap + nfloor;
			if(boost){
				rh_sin += gap * 0.5;
			}
		}
		float4 s_mult = float4(rh_sin,rh_sin,rh_sin,1);
		return s_mult * color;
	}
	else{
		 float base_width = 1.0 / uv_pixel_interval.x;
		 float w_interval = pi * base_width;
		
		float rh_sin = sin(((v_in.uv.y * direction.y + v_in.uv.x * direction.x) + t) * (w_interval / nperiod));
		if(shift){
			rh_sin = ((1.0 + rh_sin) * 0.5) * gap + nfloor;
			if(boost){
				rh_sin += gap * 0.5;
			}
		}
		float4 s_mult = float4(rh_sin,rh_sin,rh_sin,1);
		return s_mult * color;
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

