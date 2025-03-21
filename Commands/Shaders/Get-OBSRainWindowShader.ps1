function Get-OBSRainWindowShader {

[Alias('Set-OBSRainWindowShader','Add-OBSRainWindowShader')]
param(
# Set the size of OBSRainWindowShader
[ComponentModel.DefaultBindingProperty('size')]
[Single]
$Size,
# Set the blurSize of OBSRainWindowShader
[ComponentModel.DefaultBindingProperty('blurSize')]
[Single]
$BlurSize,
# Set the trail_strength of OBSRainWindowShader
[Alias('trail_strength')]
[ComponentModel.DefaultBindingProperty('trail_strength')]
[Single]
$TrailStrength,
# Set the trail_color of OBSRainWindowShader
[Alias('trail_color')]
[ComponentModel.DefaultBindingProperty('trail_color')]
[Single]
$TrailColor,
# Set the speed of OBSRainWindowShader
[ComponentModel.DefaultBindingProperty('speed')]
[Single]
$Speed,
# Set the debug of OBSRainWindowShader
[ComponentModel.DefaultBindingProperty('debug')]
[Management.Automation.SwitchParameter]
$DebugShader,
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
$shaderName = 'rain-window'
$ShaderNoun = 'OBSRainWindowShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// https://www.shadertoy.com/view/slfSzS adopted for OBS by Exeldro
// shader derived from Heartfelt - by Martijn Steinrucken aka BigWings - 2017
// https://www.shadertoy.com/view/ltffzl
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

uniform float size<
    string label = "Rain Drop Size";
    string widget_type = "slider";
    float minimum = 0.001;
    float maximum = 0.5;
    float step = 0.01;
> = 0.2;
uniform float blurSize<
    string label = "Blur Radius";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 0.01;
> = 32.0; // BLUR SIZE (Radius)
uniform float trail_strength<
    string label = "Trail Strength";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 0.01;
> = 100.0;
uniform float trail_color<
    string label = "Trail Color";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 0.01;
> = 40.0; 
uniform float speed<
    string label = "Speed";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 200.0;
    float step = 0.01;
> = 100.0; 
uniform bool debug = false;


float fract(float v){
    return v - floor(v);
}

float2 fract2(float2 v){
    return float2(v.x - floor(v.x), v.y - floor(v.y));
}

float3 fract3(float3 v){
    return float3(v.x - floor(v.x), v.y - floor(v.y), v.z - floor(v.z));
}

float3 fract4(float4 v){
    return float4(v.x - floor(v.x), v.y - floor(v.y), v.z - floor(v.z), v.w - floor(v.w));
}


float3 N13(float p) {
   //  from DAVE HOSKINS
   float3 p3 = fract3(float3(p, p, p) * float3(.1031,.11369,.13787));
   p3 += dot(p3, p3.yzx + 19.19);
   return fract3(float3((p3.x + p3.y)*p3.z, (p3.x+p3.z)*p3.y, (p3.y+p3.z)*p3.x));
}

float4 N14(float t) {
	return fract4(sin(t*float4(123., 1024., 1456., 264.))*float4(6547., 345., 8799., 1564.));
}
float N(float t) {
    return fract(sin(t*12345.564)*7658.76);
}

float Saw(float b, float t) {
	return smoothstep(0., b, t)*smoothstep(1., b, t);
}

float2 Drops(float2 uv, float t) {
    
    float2 UV = uv;
    
    // DEFINE GRID
    uv.y += t*0.8;
    float2 a = float2(6., 1.);
    float2 grid = a*2.;
    float2 id = floor(uv*grid);
    
    // RANDOM SHIFT Y
    float colShift = N(id.x); 
    uv.y += colShift;
    
    // DEFINE SPACES
    id = floor(uv*grid);
    float3 n = N13(id.x*35.2+id.y*2376.1);
    float2 st = fract2(uv*grid)-float2(.5, 0);
    
    // POSITION DROPS
    //clamp(2*x,0,2)+clamp(1-x*.5, -1.5, .5)+1.5-2
    float x = n.x-.5;
    
    float y = UV.y*20.;
    
    float distort = sin(y+sin(y));
    x += distort*(.5-abs(x))*(n.z-.5);
    x *= .7;
    float ti = fract(t+n.z);
    y = (Saw(.85, ti)-.5)*.9+.5;
    float2 p = float2(x, y);
    
    // DROPS
    float d = length((st-p)*a.yx);
    
    float dSize = size; 
    
    float Drop = smoothstep(dSize, .0, d);
    
    
    float r = sqrt(smoothstep(1., y, st.y));
    float cd = abs(st.x-x);
    
    // TRAILS
    float trail = smoothstep((dSize*.5+.03)*r, (dSize*.5-.05)*r, cd);
    float trailFront = smoothstep(-.02, .02, st.y-y);
    trail *= trailFront;
    
    
    // DROPLETS
    y = UV.y;
    y += N(id.x);
    float trail2 = smoothstep(dSize*r, .0, cd);
    float droplets = max(0., (sin(y*(1.-y)*120.)-st.y))*trail2*trailFront*n.z;
    y = fract(y*10.)+(st.y-.5);
    float dd = length(st-float2(x, y));
    droplets = smoothstep(dSize*N(id.x), 0., dd);
    float m = Drop+droplets*r*trailFront;
    if(debug){
        m += st.x>a.y*.45 || st.y>a.x*.165 ? 1.2 : 0.; //DEBUG SPACES
    }
    
    
    return float2(m, trail);
}

float StaticDrops(float2 uv, float t) {
	uv *= 30.;
    
    float2 id = floor(uv);
    uv = fract2(uv)-.5;
    float3 n = N13(id.x*107.45+id.y*3543.654);
    float2 p = (n.xy-.5)*0.5;
    float d = length(uv-p);
    
    float fade = Saw(.025, fract(t+n.z));
    float c = smoothstep(size, 0., d)*fract(n.z*10.)*fade;

    return c;
}

float2 Rain(float2 uv, float t) {
    //float s = StaticDrops(uv, t); 
    float2 r1 = Drops(uv, t);
    float2 r2 = Drops(uv*1.8, t);
    float c;
    if(debug){
        c = r1.x;
    }else{
        c = r1.x+r2.x;//s+r1.x+r2.x;
    }
    
    c = smoothstep(.3, 1., c);
    
    if(debug){
        return float2(c, r1.y);
    }else{
        return float2(c, max(r1.y, r2.y));
    }
}

float4 mainImage(VertData v_in) : TARGET
{
	float2 uv = v_in.uv;//(fragCoord.xy-.5*iResolution.xy) / iResolution.y;
    uv.y = 1.0 - uv.y;
    uv = uv * uv_scale;
    float2 UV = v_in.uv;
    float T = elapsed_time * speed / 100.0;
       
    float t = T*.2;
    
    UV = (UV-.5)*(.9)+.5;

    float2 c = Rain(uv, t);

   	float2 e = float2(.001, 0.); //pixel offset
   	float cx = Rain(uv+e, t).x;
   	float cy = Rain(uv+e.yx, t).x;
   	float2 n = float2(cx-c.x, cy-c.x); //normals

    // BLUR derived from existical https://www.shadertoy.com/view/Xltfzj
    float Pi = 6.28318530718; // Pi*2

    // GAUSSIAN BLUR SETTINGS {{{
    float Directions = 32.0; // BLUR DIRECTIONS (Default 16.0 - More is better but slower)
    float Quality = 8.0; // BLUR QUALITY (Default 4.0 - More is better but slower)
    // GAUSSIAN BLUR SETTINGS }}}
    float2 Radius = blurSize/uv_size;
    float3 col = image.Sample(textureSampler, UV).rgb;

    if(blurSize > 0.0){
        // Blur calculations
        for(float d=0.0; d<Pi; d+=Pi/Directions)
        {
            for(float i=1.0/Quality; i<=1.0; i+=1.0/Quality)
            {
                float2 uv2;
                if(debug){
                    uv2 = UV+c+float2(cos(d),sin(d))*Radius*i;
                } else{
                    uv2 = UV+n+float2(cos(d),sin(d))*Radius*i;
                }
                float3 t = image.Sample(textureSampler, uv2).rgb;
                col = col + t;       
            }
        }

        col /= Quality * Directions - 0.0;
    }

    float3 tex = image.Sample(textureSampler, UV+n).rgb;

    c.y = clamp(c.y, 0.0, 1.);
    c.y = c.y * trail_strength /100.0;
    col -= c.y;
    col += c.y*(tex + 1.0 - trail_color/100.0);

    return float4(col, 1.);
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

