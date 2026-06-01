function Get-OBS3dPanelShader {

[Alias('Set-OBS3dPanelShader','Add-OBS3dPanelShader')]
param(
# Set the credits of OBS3dPanelShader
[ComponentModel.DefaultBindingProperty('credits')]
[String]
$Credits,
# Set the scale of OBS3dPanelShader
[ComponentModel.DefaultBindingProperty('scale')]
[Single]
$Scale,
# Set the tilt_x_deg of OBS3dPanelShader
[Alias('tilt_x_deg')]
[ComponentModel.DefaultBindingProperty('tilt_x_deg')]
[Single]
$TiltXDeg,
# Set the tilt_y_deg of OBS3dPanelShader
[Alias('tilt_y_deg')]
[ComponentModel.DefaultBindingProperty('tilt_y_deg')]
[Single]
$TiltYDeg,
# Set the tilt_z_deg of OBS3dPanelShader
[Alias('tilt_z_deg')]
[ComponentModel.DefaultBindingProperty('tilt_z_deg')]
[Single]
$TiltZDeg,
# Set the pos_x of OBS3dPanelShader
[Alias('pos_x')]
[ComponentModel.DefaultBindingProperty('pos_x')]
[Single]
$PosX,
# Set the pos_y of OBS3dPanelShader
[Alias('pos_y')]
[ComponentModel.DefaultBindingProperty('pos_y')]
[Single]
$PosY,
# Set the thickness of OBS3dPanelShader
[ComponentModel.DefaultBindingProperty('thickness')]
[Single]
$Thickness,
# Set the radius_fb of OBS3dPanelShader
[Alias('radius_fb')]
[ComponentModel.DefaultBindingProperty('radius_fb')]
[Single]
$RadiusFb,
# Set the brightness of OBS3dPanelShader
[ComponentModel.DefaultBindingProperty('brightness')]
[Single]
$Brightness,
# Set the light_position of OBS3dPanelShader
[Alias('light_position')]
[ComponentModel.DefaultBindingProperty('light_position')]
[Int32]
$LightPosition,
# Set the wiggle of OBS3dPanelShader
[ComponentModel.DefaultBindingProperty('wiggle')]
[Single]
$Wiggle,
# Set the wiggle_rot of OBS3dPanelShader
[Alias('wiggle_rot')]
[ComponentModel.DefaultBindingProperty('wiggle_rot')]
[Management.Automation.SwitchParameter]
$WiggleRot,
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
$shaderName = '3d-panel'
$ShaderNoun = 'OBS3dPanelShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
//based on https://x.com/HoraiChan/status/1986268258883010766

uniform string credits<
    string widget_type = "info";
> = "Based on effect by <a href=''https://twitter.com/HoraiChan''>Horaiken</a>";

uniform float scale<
    string label = "大きさ / Scale";
    string widget_type = "slider";
    float minimum = 0.25;
    float maximum = 3.00;
    float step = 0.001;
> = 1.0;
uniform float tilt_x_deg<
    string label = "縦方向の傾き(X) / Tilt (X)";
    string widget_type = "slider";
    float minimum = -360.0;
    float maximum = 360.00;
    float step = 0.1;
> = 20.0;
uniform float tilt_y_deg<
    string label = "横方向の傾き(Y) / Tilt (Y)";
    string widget_type = "slider";
    float minimum = -360.0;
    float maximum = 360.00;
    float step = 0.1;
> = 35.0;
uniform float tilt_z_deg<
    string label = "回転(Z) / Roll (Z)";
    string widget_type = "slider";
    float minimum = -360.0;
    float maximum = 360.00;
    float step = 0.1;
> = 0.0;
uniform float pos_x<
    string label = "横位置 / Horizontal Position";
    string widget_type = "slider";
    float minimum = -1.00;
    float maximum = 1.00;
    float step = 0.0001;
> = 0.0;
uniform float pos_y<
    string label = "縦位置 / Vertical Position";
    string widget_type = "slider";
    float minimum = -1.00;
    float maximum = 1.00;
    float step = 0.0001;
> = 0.0;
uniform float thickness<
    string label = "厚み / Thickness";
    string widget_type = "slider";
    float minimum = 0.00;
    float maximum = 0.1;
    float step = 0.001;
> = 0.03;
uniform float radius_fb<
    string label = "角丸 / Corner Radius";
    string widget_type = "slider";
    float minimum = 0.00;
    float maximum = 1.00;
    float step = 0.01;
> = 0.2;
uniform float brightness<
    string label = "明るさ / Brightness";
    string widget_type = "slider";
    float minimum = 0.00;
    float maximum = 2.00;
    float step = 0.01;
> = 1.2;
uniform int light_position <
  string label = "照明の位置 / Light Direction";
  string widget_type = "select";
  int    option_0_value = 0;
  string option_0_label = "左側に光 / Light From Left";
  int    option_1_value = 1;
  string option_1_label = "右側に光 / Light From Right";
> = 0;
uniform float wiggle <
    string label = "ゆらゆら / Wiggle";
    string widget_type = "slider";
    float minimum = 0.00;
    float maximum = 2.50;
    float step = 0.01;
> = 0.0;
uniform bool wiggle_rot <
    string label = "角度もゆらゆら / Wiggle Rotation";
>;

float hash1(float n){ return frac(sin(n)*43758.5453123); }

float noise1D(float x) {
    float i = floor(x);
    float f = frac(x);
    float u = f*f*(3.0 - 2.0*f);
    return lerp(hash1(i), hash1(i+1.0), u); // 0..1
}

float fbm1D(float x) {
    float v = 0.0;
    float a = 0.5;
    float f = 1.0;
    for(int k=0;k<4;k++){
        v += a * noise1D(x * f);
        f *= 2.0;
        a *= 0.5;
    }
    return v;
}

float saturate(float x) { return clamp(x, 0.0, 1.0); }

float3 rotateX(float3 p, float a){ float c=cos(a), s=sin(a); return float3(p.x, c*p.y - s*p.z, s*p.y + c*p.z); }
float3 rotateY(float3 p, float a){ float c=cos(a), s=sin(a); return float3( c*p.x + s*p.z, p.y, -s*p.x + c*p.z); }
float3 rotateZ(float3 p, float a){ float c=cos(a), s=sin(a); return float3(c*p.x - s*p.y, s*p.x + c*p.y, p.z); }

// 2D 角丸長方形 SDF（中心、半径 bxy, 角丸 r）
float sdRoundRect2D(float2 p, float2 bxy, float r) {
    float2 q = abs(p) - bxy + r;
    return length(max(q, 0.0)) + min(max(q.x, q.y), 0.0) - r;
}

// 正面シルエット角丸 + Z方向に押し出し
float sdFrontViewRoundedPrism(float3 p, float3 b, float r_fb_norm) {
    float r_fb = saturate(r_fb_norm) * (0.999 * min(b.x, b.y));
    float a = sdRoundRect2D(p.xy, b.xy, r_fb);
    float dz = abs(p.z) - b.z;
    return max(a, dz);
}

// 法線
float3 calcNormal(float3 p, float3 b, float rfb) {
    const float e = 0.001;
    float3 ex=float3(e,0,0), ey=float3(0,e,0), ez=float3(0,0,e);
    float dx = sdFrontViewRoundedPrism(p+ex,b,rfb) - sdFrontViewRoundedPrism(p-ex,b,rfb);
    float dy = sdFrontViewRoundedPrism(p+ey,b,rfb) - sdFrontViewRoundedPrism(p-ey,b,rfb);
    float dz = sdFrontViewRoundedPrism(p+ez,b,rfb) - sdFrontViewRoundedPrism(p-ez,b,rfb);
    return normalize(float3(dx,dy,dz));
}

// 照明
float3 shade(float3 n, float3 v) {
    float3 l;
    if (light_position == 0) { // 左から光
        l = normalize(float3(-1.0, -0.1, 1.0));
    }
    else { // 右から光
        l = normalize(float3( 1.0, -0.1, 1.0));
    }
    float diff = saturate(dot(n,l));
    float rim = pow(1.0 - saturate(dot(n,v)), 2.0);
    float li = 0.25 + 0.75*diff + 0.08*rim;
    return float3(li, li, li);
}

float4 mainImage(VertData v_in) : TARGET {
    float2 uv = v_in.uv;

    // 画面座標（短辺基準）
    float aspect = uv_size.x / uv_size.y;
    float2 ndc = uv * 2.0 - 1.0;
    ndc += float2(pos_x, pos_y) * -1.0 * (scale + 1.0);
    float2 p2 = ndc;
    p2.x *= aspect;

    // カメラ設定
    float3 ro = float3(0.0, 0.0, 3.2);
    float3 rd = normalize(float3(p2, -4.0));

    // 回転（Z→Y→X の順に逆回転）
    float ax=radians(tilt_x_deg), ay=radians(tilt_y_deg), az=radians(tilt_z_deg);
    ro = rotateX(rotateY(rotateZ(ro, -az), -ay), -ax);
    rd = normalize(rotateX(rotateY(rotateZ(rd, -az), -ay), -ax));

    // 画面フィット（短辺基準）＋ 厚み
    float2 baseXY;
    if (aspect > 1.0) {
        baseXY = float2(1.0, 1.0 / aspect);
    } else {
        const float portraitMargin = 0.6;
        baseXY = float2(aspect * portraitMargin, 1.0 * portraitMargin);
    }
    float3 b = float3(baseXY, thickness) * max(scale, 0.0001);

    // Wiggle
    float diag = length(2.0 * b);
    float amp  = 0.05 * wiggle * diag;
    const float WSPD = 0.1;
    
    // 各軸に独立ノイズ
    float wx = (fbm1D(elapsed_time*WSPD + 13.37) * 2.0 - 1.0) * amp;
    float wy = (fbm1D(elapsed_time*WSPD + 47.11) * 2.0 - 1.0) * amp;
    float wz = (fbm1D(elapsed_time*WSPD + 91.73) * 2.0 - 1.0) * amp * 0.35;
    float3 woff = float3(wx, wy, wz);

    float rotAmp = radians(12.0) * wiggle;
    
    float wobX = (fbm1D(elapsed_time*WSPD + 128.31) * 2.0 - 1.0) * rotAmp;
    float wobY = (fbm1D(elapsed_time*WSPD + 299.91) * 2.0 - 1.0) * rotAmp;
    
    float3 ro2 = ro;
    float3 rd2 = rd;
    
    if (wiggle_rot) {
        ro2 = rotateX(ro2, wobX);
        ro2 = rotateY(ro2, wobY);
        rd2 = rotateX(rd2, wobX);
        rd2 = rotateY(rd2, wobY);
    }

    float t = 0.0;
    float d = 0.0;
    bool hit = false;
    for (int i=0; i<64; i++) {
        float3 pos = ro2 + rd2 * t;
        d = sdFrontViewRoundedPrism(pos - woff, b, radius_fb);
        if (d < 0.001) { hit = true; break; }
        t += d;
        if (t > 8.0) break;
    }

    // ヒットしなければ完全透明（元ソースは非表示）
    if (!hit) return float4(0.0, 0.0, 0.0, 0.0);

    float3 pos = ro2 + rd2 * t;
    float3 pObj = pos - woff;
    float3 n = calcNormal(pObj, b, radius_fb);
    float3 vdir = normalize(-rd2);

    // テクスチャ貼り付け
    float frontMask = smoothstep(0.5, 0.8, dot(n, float3(0.0, 0.0, 1.0)));
    float2 uvTex = (pObj.xy / b.xy) * 0.5 + 0.5;

    // サンプル（Address Clamp なので側面/背面は端ピクセルが“引き伸ばし”）
    float4 texFront = image.Sample(textureSampler, uvTex);
    float4 texEdge = image.Sample(textureSampler, uvTex);
    float4 tex = lerp(texEdge, texFront, frontMask);

    // フロント面エッジ・ハイライト（細い線）
    float r_fb = saturate(radius_fb) * (0.999 * min(b.x, b.y));
    float a_xy = sdRoundRect2D(pObj.xy, b.xy, r_fb); // XY角丸SDF
    float edgeWidth = 0.02 * min(b.x, b.y);
    float edgeIntensity = 0.6;
    float edgeProx = 1.0 - saturate(abs(a_xy) / edgeWidth);
    float edgeMask = frontMask * edgeProx;
    tex.rgb *= (1.0 + edgeMask * edgeIntensity);

    // 照明
    float3 lightTerm = shade(n, vdir);
    tex.rgb *= lightTerm;

    // 明るさスライダ
    tex.rgb *= brightness;

    // 出力
    return float4(tex.rgb, 1.0);
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

