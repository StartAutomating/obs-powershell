function Get-OBSClockDigitalLedShader {

[Alias('Set-OBSClockDigitalLedShader','Add-OBSClockDigitalLedShader')]
param(
# Set the current_time_sec of OBSClockDigitalLedShader
[Alias('current_time_sec')]
[ComponentModel.DefaultBindingProperty('current_time_sec')]
[Int32]
$CurrentTimeSec,
# Set the current_time_min of OBSClockDigitalLedShader
[Alias('current_time_min')]
[ComponentModel.DefaultBindingProperty('current_time_min')]
[Int32]
$CurrentTimeMin,
# Set the current_time_hour of OBSClockDigitalLedShader
[Alias('current_time_hour')]
[ComponentModel.DefaultBindingProperty('current_time_hour')]
[Int32]
$CurrentTimeHour,
# Set the timeMode of OBSClockDigitalLedShader
[ComponentModel.DefaultBindingProperty('timeMode')]
[Int32]
$TimeMode,
# Set the showMatrix of OBSClockDigitalLedShader
[ComponentModel.DefaultBindingProperty('showMatrix')]
[Management.Automation.SwitchParameter]
$ShowMatrix,
# Set the showOff of OBSClockDigitalLedShader
[ComponentModel.DefaultBindingProperty('showOff')]
[Management.Automation.SwitchParameter]
$ShowOff,
# Set the ampm of OBSClockDigitalLedShader
[ComponentModel.DefaultBindingProperty('ampm')]
[Management.Automation.SwitchParameter]
$Ampm,
# Set the ledColor of OBSClockDigitalLedShader
[ComponentModel.DefaultBindingProperty('ledColor')]
[String]
$LedColor,
# Set the offsetHours of OBSClockDigitalLedShader
[ComponentModel.DefaultBindingProperty('offsetHours')]
[Int32]
$OffsetHours,
# Set the offsetSeconds of OBSClockDigitalLedShader
[ComponentModel.DefaultBindingProperty('offsetSeconds')]
[Int32]
$OffsetSeconds,
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
$shaderName = 'clock_digital_led'
$ShaderNoun = 'OBSClockDigitalLedShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// based on https://www.shadertoy.com/view/MdfGzf
// cmarangu has linked all 7 segments in his comments
// https://www.shadertoy.com/view/3dtSRj

#ifndef OPENGL
#define mod(x,y) (x - y * floor(x / y))
#endif

uniform int current_time_sec;
uniform int current_time_min;
uniform int current_time_hour;

uniform int timeMode<
  string label = "Time mode";
  string widget_type = "select";
  int    option_0_value = 0;
  string option_0_label = "Time";
  int    option_1_value = 1;
  string option_1_label = "Enable duration";
  int    option_2_value = 2;
  string option_2_label = "Active duration";
  int    option_3_value = 3;
  string option_3_label = "Show duration";
  int    option_4_value = 4;
  string option_4_label = "Load duration";
> = 0;

uniform bool showMatrix = false;
uniform bool showOff = false;
uniform bool ampm = false;
uniform float4 ledColor = {1.0,0,0,1.0};
uniform int offsetHours = 0;
uniform int offsetSeconds = 0;

float segment(float2 uv, bool On)
{
	if (!On && !showOff)
		return 0.0;
	
	float seg = (1.0-smoothstep(0.08,0.09+float(On)*0.02,abs(uv.x)))*
			    (1.0-smoothstep(0.46,0.47+float(On)*0.02,abs(uv.y)+abs(uv.x)));
	
    //Fiddle with lights and matrix
	//uv.x += sin(elapsed_time*60.0*6.26)/14.0;
	//uv.y += cos(elapsed_time*60.0*6.26)/14.0;
	
	//led like brightness
	if (On){
		seg *= (1.0-length(uv*float2(3.8,0.9)));//-sin(elapsed_time*25.0*6.26)*0.04;
	} else {
		seg *= -(0.05+length(uv*float2(0.2,0.1)));
	}
	return seg;
}

float sevenSegment(float2 uv,int num)
{
	float seg= 0.0;
    seg += segment(uv.yx+float2(-1.0, 0.0),num!=-1 && num!=1 && num!=4                    );
	seg += segment(uv.xy+float2(-0.5,-0.5),num!=-1 && num!=1 && num!=2 && num!=3 && num!=7);
	seg += segment(uv.xy+float2( 0.5,-0.5),num!=-1 && num!=5 && num!=6                    );
   	seg += segment(uv.yx+float2( 0.0, 0.0),num!=-1 && num!=0 && num!=1 && num!=7          );
	seg += segment(uv.xy+float2(-0.5, 0.5),num==0 || num==2 || num==6 || num==8           );
	seg += segment(uv.xy+float2( 0.5, 0.5),num!=-1 && num!=2                              );
    seg += segment(uv.yx+float2( 1.0, 0.0),num!=-1 && num!=1 && num!=4 && num!=7          );
	
	return seg;
}

float showNum(float2 uv,int nr, bool zeroTrim)
{
	//Speed optimization, leave if pixel is not in segment
	if (abs(uv.x)>1.5 || abs(uv.y)>1.2)
		return 0.0;
	
	float seg= 0.0;
	if (uv.x>0.0)
	{
		nr /= 10;
		if (nr==0 && zeroTrim)
			nr = -1;
		seg += sevenSegment(uv+float2(-0.75,0.0),nr);
	} else {
		seg += sevenSegment(uv+float2( 0.75,0.0),int(mod(float(nr),10.0)));
	}

	return seg;
}

float dots(float2 uv)
{
	float seg = 0.0;
	uv.y -= 0.5;
	seg += (1.0-smoothstep(0.11,0.13,length(uv))) * (1.0-length(uv)*2.0);
	uv.y += 1.0;
	seg += (1.0-smoothstep(0.11,0.13,length(uv))) * (1.0-length(uv)*2.0);
	return seg;
}

float4 mainImage(VertData v_in) : TARGET
{
	float2 uv = ((float2(v_in.uv.x, 1.0-v_in.uv.y)  * uv_size).xy-0.5*uv_size) /
 		       min(uv_size.x,uv_size.y);
	
	if (uv_size.x>uv_size.y)
	{
		uv *= 6.0;
	}
	else
	{
		uv *= 12.0;
	}
	
	uv.x *= -1.0;
	uv.x += uv.y/12.0;
	//wobble
	//uv.x += sin(uv.y*3.0+elapsed_time*14.0)/25.0;
	//uv.y += cos(uv.x*3.0+elapsed_time*14.0)/25.0;
    uv.x += 3.5;
	float seg = 0.0;

	if(timeMode == 0){
		seg += showNum(uv,current_time_sec,false);
		uv.x -= 1.75;
		seg += dots(uv);
		uv.x -= 1.75;
		seg += showNum(uv,current_time_min,false);
		uv.x -= 1.75;
		seg += dots(uv);
		uv.x -= 1.75;
		if (ampm) {
			if(current_time_hour == 0){
				seg += showNum(uv,12,true);
			}else if(current_time_hour > 12){
				seg += showNum(uv,current_time_hour-12,true);
			}else{
				seg += showNum(uv,current_time_hour,true);
			}
		} else {
			seg += showNum(uv,current_time_hour,true);
		}
	}else{
		float timeSecs = 0.0;
		if(timeMode == 1){
			timeSecs = elapsed_time_enable;
		}else if(timeMode == 2){
			timeSecs = elapsed_time_active;
		}else if(timeMode == 3){
			timeSecs = elapsed_time_show;
		}else if(timeMode == 4){
			timeSecs = elapsed_time_start;
		}

		timeSecs += offsetSeconds + offsetHours*3600;
		if(timeSecs < 0)
			timeSecs = 0.9999-timeSecs;
		seg += showNum(uv,int(mod(timeSecs,60.0)),false);
		
		timeSecs = floor(timeSecs/60.0);
		
		uv.x -= 1.75;

		seg += dots(uv);
		
		uv.x -= 1.75;
		
		seg += showNum(uv,int(mod(timeSecs,60.0)),false);
		
		timeSecs = floor(timeSecs/60.0);
		if (ampm)
		{
			if(timeSecs == 0.0){
				timeSecs = 12.0;
			}else if (timeSecs > 12.0){
				timeSecs = mod(timeSecs,12.0);
			}
		}else if (timeSecs > 24.0) {
			timeSecs = mod(timeSecs,24.0);
		}
		
		uv.x -= 1.75;
		
		seg += dots(uv);
		
		uv.x -= 1.75;
		seg += showNum(uv,int(mod(timeSecs,60.0)),true);
	}

	
	if (seg==0.0){
		return image.Sample(textureSampler, v_in.uv);
	}
	// matrix over segment
	if (showMatrix)
	{
		seg *= 0.8+0.2*smoothstep(0.02,0.04,mod(uv.y+uv.x,0.06025));
		//seg *= 0.8+0.2*smoothstep(0.02,0.04,mod(uv.y-uv.x,0.06025));
	}
	if (seg<0.0)
	{
		seg = -seg;;
		return float4(seg,seg,seg,1.0);
	}
	return float4(ledColor.rgb * seg, ledColor.a);
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

