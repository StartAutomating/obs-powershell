function Get-OBSSeascapeShader {

[Alias('Set-OBSSeascapeShader','Add-OBSSeascapeShader')]
param(
# Set the AA of OBSSeascapeShader
[ComponentModel.DefaultBindingProperty('AA')]
[Management.Automation.SwitchParameter]
$AA,
# Set the SEA_HEIGHT of OBSSeascapeShader
[Alias('SEA_HEIGHT')]
[ComponentModel.DefaultBindingProperty('SEA_HEIGHT')]
[Single]
$SEAHEIGHT,
# Set the SEA_CHOPPY of OBSSeascapeShader
[Alias('SEA_CHOPPY')]
[ComponentModel.DefaultBindingProperty('SEA_CHOPPY')]
[Single]
$SEACHOPPY,
# Set the SEA_SPEED of OBSSeascapeShader
[Alias('SEA_SPEED')]
[ComponentModel.DefaultBindingProperty('SEA_SPEED')]
[Single]
$SEASPEED,
# Set the SEA_FREQ of OBSSeascapeShader
[Alias('SEA_FREQ')]
[ComponentModel.DefaultBindingProperty('SEA_FREQ')]
[Single]
$SEAFREQ,
# Set the SEA_BASE of OBSSeascapeShader
[Alias('SEA_BASE')]
[ComponentModel.DefaultBindingProperty('SEA_BASE')]
[String]
$SEABASE,
# Set the SEA_WATER_COLOR of OBSSeascapeShader
[Alias('SEA_WATER_COLOR')]
[ComponentModel.DefaultBindingProperty('SEA_WATER_COLOR')]
[String]
$SEAWATERCOLOR,
# Set the CAMERA_SPEED of OBSSeascapeShader
[Alias('CAMERA_SPEED')]
[ComponentModel.DefaultBindingProperty('CAMERA_SPEED')]
[Single]
$CAMERASPEED,
# Set the CAMERA_TURN_SPEED of OBSSeascapeShader
[Alias('CAMERA_TURN_SPEED')]
[ComponentModel.DefaultBindingProperty('CAMERA_TURN_SPEED')]
[Single]
$CAMERATURNSPEED,
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
$shaderName = 'seascape'
$ShaderNoun = 'OBSSeascapeShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
/*
 * "Seascape" by Alexander Alekseev aka TDM - 2014
 * License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
 * Contact: tdmaav@gmail.com
 * https://www.shadertoy.com/view/Ms2SD1 adapted by Exeldro
 */

#define NUM_STEPS 8
#define PI 3.141592
#define EPSILON 0.001
uniform bool AA<
    string label = "Smooth (more resources)";
> = false;

#ifndef OPENGL
#define mat2 float2x2
#define mat3 float3x3
#define fract frac
#define mix lerp
#endif

// sea
#define ITER_GEOMETRY 3
#define ITER_FRAGMENT 5
uniform float SEA_HEIGHT<
    string label = "Sea Height";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.5;
    float step = 0.001;
> = 0.6;
uniform float SEA_CHOPPY<
    string label = "Sea Choppy";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 10.0;
    float step = 0.001;
> = 4.0;
uniform float SEA_SPEED<
    string label = "Sea Speed";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 10.0;
    float step = 0.001;
> = 0.8;
uniform float SEA_FREQ<
    string label = "Sea Frequency";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 0.5;
    float step = 0.001;
> = 0.16;
uniform float4 SEA_BASE<
    string label = "Sea Base";
> = {0.0,0.09,0.18,1.0};
uniform float4 SEA_WATER_COLOR<
    string label = "Sea Water";
> = {0.48,0.54,0.36,1.0};

uniform float CAMERA_SPEED<
    string label = "Camera Speed";
    string widget_type = "slider";
    float minimum = -10.0;
    float maximum = 10.0;
    float step = 0.001;
> = 1.0;

uniform float CAMERA_TURN_SPEED<
    string label = "Camera Turn Speed";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 10.0;
    float step = 0.001;
> = 1.0;


float SEA_TIME(){
    return 1.0 + elapsed_time * SEA_SPEED;
}

// math
mat3 fromEuler(float3 ang) {
	float2 a1 = float2(sin(ang.x),cos(ang.x));
    float2 a2 = float2(sin(ang.y),cos(ang.y));
    float2 a3 = float2(sin(ang.z),cos(ang.z));
	return mat3(float3(a1.y*a3.y+a1.x*a2.x*a3.x,a1.y*a2.x*a3.x+a3.y*a1.x,-a2.y*a3.x),
    float3(-a2.y*a1.x,a1.y*a2.y,a2.x),
    float3(a3.y*a1.x*a2.x+a1.y*a3.x,a1.x*a3.x-a1.y*a3.y*a2.x,a2.y*a3.y));
}

float hash(float2 p) {
    float h = dot(p,float2(127.1,311.7));
    return fract(sin(h)*43758.5453123);
}

float noise(float2 p) {
    float2 i = floor( p );
    float2 f = fract( p );	
	float2 u = f*f*(3.0-2.0*f);
    return -1.0+2.0*mix( mix( hash( i + float2(0.0,0.0) ), 
                     hash( i + float2(1.0,0.0) ), u.x),
                mix( hash( i + float2(0.0,1.0) ), 
                     hash( i + float2(1.0,1.0) ), u.x), u.y);
}

// lighting
float diffuse(float3 n,float3 l,float p) {
    return pow(dot(n,l) * 0.4 + 0.6,p);
}
float specular(float3 n,float3 l,float3 e,float s) {    
    float nrm = (s + 8.0) / (PI * 8.0);
    return pow(max(dot(reflect(e,n),l),0.0),s) * nrm;
}

// sky
float3 getSkyColor(float3 e) {
    e.y = (max(e.y,0.0)*0.8+0.2)*0.8;
    return float3(pow(1.0-e.y,2.0), 1.0-e.y, 0.6+(1.0-e.y)*0.4) * 1.1;
}

// sea
float sea_octave(float2 uv, float choppy) {
    uv += noise(uv);        
    float2 wv = 1.0-abs(sin(uv));
    float2 swv = abs(cos(uv));    
    wv = mix(wv,swv,wv);
    return pow(1.0-pow(wv.x * wv.y,0.65),choppy);
}

float map(float3 p) {
    float freq = SEA_FREQ;
    float amp = SEA_HEIGHT;
    float choppy = SEA_CHOPPY;
    float2 uv = p.xz;
    uv.x *= 0.75;
    mat2 octave_m = mat2(1.6,1.2,-1.2,1.6);

    float st = SEA_TIME();
    float d, h = 0.0;    
    for(int i = 0; i < ITER_GEOMETRY; i++) {        
    	d = sea_octave((uv+float2(st,st))*freq,choppy);
    	d += sea_octave((uv-float2(st,st))*freq,choppy);
        h += d * amp;        
    	uv = mul(uv, octave_m);
        freq *= 1.9;
        amp *= 0.22;
        choppy = mix(choppy,1.0,0.2);
    }
    return p.y - h;
}

float map_detailed(float3 p) {
    float freq = SEA_FREQ;
    float amp = SEA_HEIGHT;
    float choppy = SEA_CHOPPY;
    float2 uv = p.xz; uv.x *= 0.75;
    mat2 octave_m = mat2(1.6,1.2,-1.2,1.6);
    float st = SEA_TIME();
    float d, h = 0.0;    
    for(int i = 0; i < ITER_FRAGMENT; i++) {        
    	d = sea_octave((uv+float2(st,st))*freq,choppy);
    	d += sea_octave((uv-float2(st,st))*freq,choppy);
        h += d * amp;        
    	uv = mul(uv, octave_m);
        freq *= 1.9;
        amp *= 0.22;
        choppy = mix(choppy,1.0,0.2);
    }
    return p.y - h;
}

float3 getSeaColor(float3 p, float3 n, float3 l, float3 eye, float3 dist) {  
    float fresnel = clamp(1.0 - dot(n,-eye), 0.0, 1.0);
    fresnel = min(pow(fresnel,3.0), 0.5);
        
    float3 reflected = getSkyColor(reflect(eye,n));    
    float3 refracted = SEA_BASE.rgb + diffuse(n,l,80.0) * SEA_WATER_COLOR.rgb * 0.12; 
    
    float3 color = mix(refracted,reflected,fresnel);
    
    float atten = max(1.0 - dot(dist,dist) * 0.001, 0.0);
    color += SEA_WATER_COLOR.rgb * (p.y - SEA_HEIGHT) * 0.18 * atten;
    
    float s = specular(n,l,eye,60.0);
    color += float3(s,s,s);
    
    return color;
}

// tracing
float3 getNormal(float3 p, float eps) {
    float3 n;
    n.y = map_detailed(p);    
    n.x = map_detailed(float3(p.x+eps,p.y,p.z)) - n.y;
    n.z = map_detailed(float3(p.x,p.y,p.z+eps)) - n.y;
    n.y = eps;
    return normalize(n);
}

float heightMapTracing(float3 ori, float3 dir, out float3 p) {  
    float tm = 0.0;
    float tx = 1000.0;    
    float hx = map(ori + dir * tx);
    if(hx > 0.0) {
        p = ori + dir * tx;
        return tx;   
    }
    float hm = map(ori + dir * tm);    
    float tmid = 0.0;
    for(int i = 0; i < NUM_STEPS; i++) {
        tmid = mix(tm,tx, hm/(hm-hx));                   
        p = ori + dir * tmid;                   
    	float hmid = map(p);
		if(hmid < 0.0) {
        	tx = tmid;
            hx = hmid;
        } else {
            tm = tmid;
            hm = hmid;
        }
    }
    return tmid;
}

float3 getPixel(in float2 coord, float time) {    
    float2 uv = coord / uv_size.xy;
    uv = uv * 2.0 - 1.0;
    uv.x *= uv_size.x / uv_size.y;
        
    // ray
    float3 ang = float3(sin(time*3.0*CAMERA_TURN_SPEED)*0.1,sin(time*CAMERA_TURN_SPEED)*0.2+0.3,time*CAMERA_TURN_SPEED);    
    float3 ori = float3(0.0,3.5,time*5.0*CAMERA_SPEED);
    float3 dir = normalize(float3(uv.xy,-2.0));
    dir.z += length(uv) * 0.14;
    dir = mul(normalize(dir), fromEuler(ang));
    
    // tracing
    float3 p;
    heightMapTracing(ori,dir,p);
    float3 dist = p - ori;
    float3 n = getNormal(p, dot(dist,dist) * (0.1 / uv_size.x));
    float3 light = normalize(float3(0.0,1.0,0.8)); 
             
    // color
    return mix(
        getSkyColor(dir),
        getSeaColor(p,n,light,dir,dist),
    	pow(smoothstep(0.0,-0.02,dir.y),0.2));
}

// main
float4 mainImage(VertData v_in) : TARGET
{
    float time = elapsed_time * 0.3;
    float2 fragCoord = float2(v_in.uv.x * uv_size.x, (1.0 - v_in.uv.y) * uv_size.y);
	
    float3 color = float3(0.0,0.0,0.0);;
    if (AA){
        for(int i = -1; i <= 1; i++) {
            for(int j = -1; j <= 1; j++) {
                float2 uv = fragCoord+float2(i,j)/3.0;
                color += getPixel(uv, time);
            }
        }
        color /= 9.0;
    }else{
        color = getPixel(fragCoord, time);
    }
    
    // post
	return float4(pow(color,float3(0.65,0.65,0.65)), 1.0);
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

