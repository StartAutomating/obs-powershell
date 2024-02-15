function Get-OBSFireworksShader {

[Alias('Set-OBSFireworksShader','Add-OBSFireworksShader')]
param(
# Set the show_flash of OBSFireworksShader
[Alias('show_flash')]
[ComponentModel.DefaultBindingProperty('show_flash')]
[Management.Automation.SwitchParameter]
$ShowFlash,
# Set the show_stars of OBSFireworksShader
[Alias('show_stars')]
[ComponentModel.DefaultBindingProperty('show_stars')]
[Management.Automation.SwitchParameter]
$ShowStars,
# Set the use_transparancy of OBSFireworksShader
[Alias('use_transparancy')]
[ComponentModel.DefaultBindingProperty('use_transparancy')]
[Management.Automation.SwitchParameter]
$UseTransparancy,
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
$shaderName = 'fireworks'
$ShaderNoun = 'OBSFireworksShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
#ifndef OPENGL
#define mat2 float2x2
#define fract frac
#define mix lerp
#endif

uniform bool show_flash = true;
uniform bool show_stars = true;
uniform bool use_transparancy = true;

float distLine(float2 p, float2 a, float2 b) {
	float2 pa = p - a;
    float2 ba = b - a;
    float t = clamp(dot(pa, ba) / dot(ba, ba), 0.0, 1.0);
    return length(pa - ba * t);
}

float linef(float2 uv, float2 a, float2 b, float w) {
    //return smoothstep(w, w - 0.01, distLine(uv, a, b));
    return w / distLine(uv, a, b);
}

float N21(float2 p) {
	p = fract(p * float2(233.34, 851.73));
    p += dot(p, p + 23.45);
    return fract(p.x * p.y);
}

float2 N22(float2 p) {
	float n = N21(p);
    return float2(n, N21(p + n));
}

float N11(float n) {
    return fract(sin(dot(float2(cos(n), sin(n)) ,float2(27.9898, 38.233))) * 88.5453);
}

float particle(float2 uv, float2 p, float2 v, float r, float t) {
    float g = -9.81;
    float x = p.x + v.x * t;
    float y = p.y + v.y * t + g / 2.0 * t * t;
    float2 j = (float2(x, y) - uv) * 20.0;
    float sparkle = 1.0 / dot(j, j);
    return sparkle;
}

float2 p1(float2 p, float h, float t) {
    return float2(p.x, p.y + clamp(pow(t, 5.0), 0.0, h));
}

float2 p2(float2 p, float h, float t) {
    return float2(p.x, p.y + clamp(pow(0.95 * t, 5.0), 0.0, h));
}

float endTime(float h) {
    return pow(h, 1.0 / 5.0) * 1.1;
}

float explosion(float2 uv, float2 p, float s, float n, float f, float t) {

    float m = 0.0;
    float dt = 0.5;
    float seed2 = 0.32;
	for(float i = 0.0; i < n; i++) {
    	seed2 += i;
        float2 rand = float2(1.0, 2.0) * (float2(-1.0, 1.0) + 2.0 * N22(float2(seed2, i)));
    	float2 v = float2(cos(seed2), sin(seed2)) + rand;
        m += particle(uv, p, v, s, t) * smoothstep(2.0, 2.0 - dt, t) * smoothstep(0.0, dt, t);
    }   
    return m;
}

float fireworks(float2 uv, float2 p, float h, float n, float s, float f, float t) {
    float2 p1v = p1(p, h, t);
    float e = endTime(h);
    return explosion(uv, p1v, s, n, f, t - e * 0.9);
}

float shaft(float2 uv, float2 p, float w, float h, float t) {
    float2 p1v = p1(p, h, t) + float2(0.0, 0.3);
    float2 p2v = p2(p, h, t);
    float e = 1.0 / 0.95 * endTime(h);
    float2 j = (p1v - uv) * 15.0;
    float sparkle = 1.0 / dot(j, j);
    return (linef(uv, p1v, p2v, w) + sparkle) * smoothstep(e, e - 0.5, t) * 0.5;
}

float3 base(float2 uv) {
	return 0.5 + 0.5 * cos(elapsed_time + uv.xyx + float3(0, 2, 4));   
}

float back(float2 uv, float2 p, float t) {
    float dt = 0.3;
    float j = length(p - uv);
    float m = exp(-0.005 * j * j);
    return 0.2 * m * smoothstep(-dt / 4.0, 0.0, t) * smoothstep(dt, 0.0, t);
}

float stars(float2 uv) {
    float r = N21(uv);
    return smoothstep(0.001, 0.0, r);
}

float mod(float x, float y)
{
	return x - y * floor(x / y);
}

float4 mainImage( VertData v_in ) : TARGET
{
    float2 uv = v_in.uv - float2(0.5,0.5);
    uv.y = uv.y * -1;
    float t = elapsed_time / 10.0;
    float scale = 10.0;
    uv *= scale;
    //
    float4 col = image.Sample(textureSampler, v_in.uv);
    if(show_stars){
        float c =  stars(uv);
        if(use_transparancy){
            col += float4(c,c,c,c)*(1.0-col.a);
        }else{
            col += float4(c,c,c,c);//*(1.0-orig_col.a);
        }
        
    }
    
    float a = -0.035 * sin(t * 15.0);
    float co = cos(a);
    float si = sin(a);
    mat2 trans1 = mat2(float2(co, si), float2(-si, co));
    float2 trans2 = float2(-15.0 * a, 0.0);
#ifndef OPENGL
    uv = mul(uv, trans1);
#else
    uv *= trans1;
#endif
    uv += trans2;
    
    for(float i = 0.0; i < 1.0; i += 1.0 / 8.0) {
        float ti = mod(t * 9.0 - i * 5.0, 4.0);
        float scale = mix(2.0, 0.3, ti / 4.0);
        float2 uvs = uv * scale;
        float rand = N11(i);
        float h = 10.0 + rand * 4.0;
        float w = 0.02;
        float n = 80.0;
        float s = 0.9;
        float f = 1.5;
        float2 p = float2(mix(-8.0, 8.0, rand), -10.0);  
        float fw = fireworks(uvs, p, h, n, s, f, ti);
        float3 bc = base(uv);
        col += float4(bc*fw, fw);
        col += shaft(uvs, p, w, h, ti);
        if(show_flash){
            if(use_transparancy){
                col += back(uvs, float2(p.x, p.y + h), ti - 1.8)*col.a;
            }else{
                col += back(uvs, float2(p.x, p.y + h), ti - 1.8);
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

