function Get-OBSClockAnalogShader {

[Alias('Set-OBSClockAnalogShader','Add-OBSClockAnalogShader')]
param(
# Set the current_time_ms of OBSClockAnalogShader
[Alias('current_time_ms')]
[ComponentModel.DefaultBindingProperty('current_time_ms')]
[Int32]
$CurrentTimeMs,
# Set the current_time_sec of OBSClockAnalogShader
[Alias('current_time_sec')]
[ComponentModel.DefaultBindingProperty('current_time_sec')]
[Int32]
$CurrentTimeSec,
# Set the current_time_min of OBSClockAnalogShader
[Alias('current_time_min')]
[ComponentModel.DefaultBindingProperty('current_time_min')]
[Int32]
$CurrentTimeMin,
# Set the current_time_hour of OBSClockAnalogShader
[Alias('current_time_hour')]
[ComponentModel.DefaultBindingProperty('current_time_hour')]
[Int32]
$CurrentTimeHour,
# Set the hour_handle_color of OBSClockAnalogShader
[Alias('hour_handle_color')]
[ComponentModel.DefaultBindingProperty('hour_handle_color')]
[Single[]]
$HourHandleColor,
# Set the minute_handle_color of OBSClockAnalogShader
[Alias('minute_handle_color')]
[ComponentModel.DefaultBindingProperty('minute_handle_color')]
[Single[]]
$MinuteHandleColor,
# Set the second_handle_color of OBSClockAnalogShader
[Alias('second_handle_color')]
[ComponentModel.DefaultBindingProperty('second_handle_color')]
[Single[]]
$SecondHandleColor,
# Set the outline_color of OBSClockAnalogShader
[Alias('outline_color')]
[ComponentModel.DefaultBindingProperty('outline_color')]
[Single[]]
$OutlineColor,
# Set the top_line_color of OBSClockAnalogShader
[Alias('top_line_color')]
[ComponentModel.DefaultBindingProperty('top_line_color')]
[Single[]]
$TopLineColor,
# Set the background_color of OBSClockAnalogShader
[Alias('background_color')]
[ComponentModel.DefaultBindingProperty('background_color')]
[Single[]]
$BackgroundColor,
# Set the time_offset_hours of OBSClockAnalogShader
[Alias('time_offset_hours')]
[ComponentModel.DefaultBindingProperty('time_offset_hours')]
[Int32]
$TimeOffsetHours,
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
$shaderName = 'clock_analog'
$ShaderNoun = 'OBSClockAnalogShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
//Based on https://www.shadertoy.com/view/XdKXzy
uniform int current_time_ms;
uniform int current_time_sec;
uniform int current_time_min;
uniform int current_time_hour;
uniform float3 hour_handle_color = {1.0,1.0,1.0};
uniform float3 minute_handle_color = {1.0,1.0,1.0};
uniform float3 second_handle_color = {1.0,0.0,0.0};
uniform float3 outline_color = {1.0,1.0,1.0};
uniform float3 top_line_color = {1.0,0.0,0.0};
uniform float3 background_color = {.5,.5,.5};
uniform int time_offset_hours = 0;

#ifndef OPENGL
#define mod(x,y) (x - y * floor(x / y))
#endif
// this is my first try to actually use glsl almost from scratch
// so far all i''ve done is learning by doing / reading glsl docs.
// this is inspired by my non glsl â€želapsed_timeâ€œ projects
// especially this one: https://www.gottz.de/analoguhr.htm

// i will most likely use a buffer in future to calculate the elapsed_time
// aswell as to draw the background of the clock only once.
// tell me if thats a bad idea.

// update:
// screenshot: http://i.imgur.com/dF0nHDk.png
// as soon as i think its in a usefull state i''ll release the source
// of that particular c++ application on github.
// i hope sommeone might find it usefull :D

#define PI 3.141592653589793238462643383

// from https://www.shadertoy.com/view/4s3XDn <3
float ln(float2 p, float2 a, float2 b)
{
	float2 pa = p - a;
	float2 ba = b - a;
	float h = clamp(dot(pa, ba) / dot(ba, ba), 0.0, 1.0);
    return length(pa - ba * h);
}

// i think i should spend some elapsed_time reading docs in order to minimize this.
// hints apreciated
// (Rotated LiNe)
float rln(float2 uv, float start, float end, float perc) {
    float inp = perc * PI * 2.0;
	float2 coord = float2(sin(inp), cos(inp));
    return ln(uv, coord * start, coord * end);
}

// i need this to have an alphachannel in the output
// i intend to use an optimized version of this shader for a transparent desktop widget experiment
float4 mixer(float4 c1, float4 c2) {
    // please tell me if you think this would boost performance.
    // the elapsed_time i implemented mix myself it sure did reduce
    // the amount of operations but i''m not sure now
    // if (c2.a <= 0.0) return c1;
    // if (c2.a >= 1.0) return c2;
    return float4(lerp(c1.rgb, c2.rgb, c2.a), c1.a + c2.a);
    // in case you are curious how you could implement mix yourself:
    // return float4(c2.rgb * c2.a + c1.rgb * (1.0-c2.a), c1.a+c2.a);
}
    
float4 styleHandle(float4 color, float px, float dist, float3 handleColor, float width, float shadow) {
    if (dist <= width + shadow) {
        // lets draw the shadow
        color = mixer(color, float4(0.0, 0.0, 0.0,
                                (1.0-pow(smoothstep(width, width + shadow, dist),0.2))*0.2));
        // now lets draw the antialiased handle
        color = mixer(color, float4(handleColor, smoothstep(width, max(width - 3.0 * px, 0.0), dist)));
    }
    return color;
}

float4 mainImage(VertData v_in) : TARGET
{
    float2 R = uv_size;
    // calculate the size of a pixel
    float px = 1.0 / R.y;
    // create percentages of the coordinate system
    float2 p = (v_in.uv * uv_size).xy / R;
    // center the scene and add perspective
    float2 uv = (2.0 * (float2(v_in.uv.x,1.0-v_in.uv.y) * uv_size) - R) / min(R.x, R.y);
    
    /*float2 uv = -1.0 + 2.0 * p.xy;
    // lets add perspective for mobile device support
    if (uv_size.x > uv_size.y)
    	uv.x *= uv_size.x / uv_size.y;
    else
        uv.y *= uv_size.y / uv_size.x;*/
    
    // lets scale the scene a bit down:
    uv *= 1.1;
    px *= 0.9;
    
    float width = 0.015;
    float dist = 1.0;
    float centerdist = length(uv);
    
    float4 color = image.Sample(textureSampler, v_in.uv);
    
    // background of the clock
    if (centerdist < 1.0 - width) color = mixer(color, float4(background_color, 0.4*(1.8-length(uv))));
    
    float isRed = 1.0;
 
    if (centerdist > 1.0 - 12.0 * width && centerdist <= 1.1) {
        // minute bars
        for (float i = 0.0; i <= 15.0; i += 1.0) {
            if (mod(i, 5.0) == 0.0) {
                dist = min(dist, rln(abs(uv), 1.0 - 10.0 * width, 1.0 - 2.0 * width, i / 60.0));
                // draw first bar red
                if (i == 0.0 && uv.y > 0.0) {
                    isRed = dist;
                    dist = smoothstep(width, max(width - 3.0 * px, 0.0), dist);
                    color = mixer(color, float4(top_line_color, dist));
                    dist = 1.0;
                }
            }
            else {
                dist = min(dist, rln(abs(uv), 1.0 - 10.0 * width, 1.0 - 7.0 * width, i / 60.0));
            }
        }

        // outline circle
        dist = min(dist, abs(1.0-width-length(uv)));
        // draw clock shadow
        if (centerdist > 1.0)
            color = mixer(color, float4(0.0,0.0,0.0, 0.3*smoothstep(1.0 + width*2.0, 1.0, centerdist)));

        // draw outline + minute bars in white
		color = mixer(color, float4(0.0, 0.0, 0.0,
			(1.0 - pow(smoothstep(width, width + 0.02, min(isRed, dist)), 0.4))*0.2));
		color = mixer(color, float4(outline_color, smoothstep(width, max(width - 3.0 * px, 0.0), dist)));
    }
    
    if (centerdist < 1.0) {
        float elapsed_time = float((time_offset_hours+current_time_hour)*3600+current_time_min*60+current_time_sec) + pow(float(current_time_ms)/1000.0,16.0);
        // hour
        color = styleHandle(color, px,
                            rln(uv, -0.05, 0.5, elapsed_time / 3600.0 / 12.0),
                            hour_handle_color, 0.03, 0.02);

        // minute
        color = styleHandle(color, px,
                            rln(uv, -0.075, 0.7, elapsed_time / 3600.0),
                            minute_handle_color, 0.02, 0.02);

        // second
        color = styleHandle(color, px,
                            min(rln(uv, -0.1, 0.9, elapsed_time / 60.0), length(uv)-0.01),
                            second_handle_color, 0.01, 0.02);
    }
    
    
    return  color;
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

