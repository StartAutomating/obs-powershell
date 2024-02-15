function Get-OBSVoronoiPixelationShader {

[Alias('Set-OBSVoronoiPixelationShader','Add-OBSVoronoiPixelationShader')]
param(
# Set the pixH of OBSVoronoiPixelationShader
[ComponentModel.DefaultBindingProperty('pixH')]
[Single]
$PixH,
# Set the alternative of OBSVoronoiPixelationShader
[ComponentModel.DefaultBindingProperty('alternative')]
[Management.Automation.SwitchParameter]
$Alternative,
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
$shaderName = 'voronoi-pixelation'
$ShaderNoun = 'OBSVoronoiPixelationShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// https://www.shadertoy.com/view/sd3yzn adopted by Exeldro

uniform float pixH<
    string label = "Size";
    string widget_type = "slider";
    float minimum = 4.0;
    float maximum = 500.0;
    float step = 0.01;
> = 100.0;
uniform bool alternative;

float2 fract2(float2 v){
    return float2(v.x - floor(v.x), v.y - floor(v.y));
}

float2 random2( float2 p ) {
    return fract2(sin(float2(dot(p,float2(127.1,311.7)),dot(p,float2(269.5,183.3))))*43758.5453);
}
float2 randomSpin(float2 p, float f){
    return 1.0 * float2(
    cos( f * elapsed_time * 3.14159 * sign(random2(p).y - 0.5) + random2(p).y * 3.14159), 
    sin( f * elapsed_time * 3.14159 * sign(random2(p).x - 0.5) + random2(p).x * 3.14159));
}
float4 VoronoiPixelation(float2 uv, float pixH ){
    float2 pixInt = fract2(uv * pixH);
    float2 pixExt = floor(uv * pixH);
    float m_dist = 10.0;
    float2 relClos = float2(0.0, 0.0);
    float2 relRot = 0.5 * float2(cos(elapsed_time), sin(elapsed_time));


    for (int y= -3; y <= 3; y++) {
        for (int x= -3; x <= 3; x++) {
            float2 neighbor = float2(float(x),float(y));

            float2 point1 = random2(pixExt + neighbor);
            float2 relRot = randomSpin(pixExt + neighbor, 0.5);
            float2 diff = neighbor + relRot + point1 - pixInt;
            float dist = length(diff);
            if(dist < m_dist){
                m_dist = dist;
                relClos = neighbor;
            }
        }
    }
    float2 nPoint = pixExt + relClos + randomSpin(pixExt + relClos, 0.5) + random2(pixExt + relClos);
    nPoint = nPoint / pixH;
    nPoint.x = nPoint.x * uv_scale.x ;
    
    return image.Sample(textureSampler, nPoint);
}
float4 VoronoiPixelation2(float2 uv, float pixH ){
    float2 pixInt = fract2(uv * pixH);
    float2 pixExt = floor(uv * pixH);
    float m_dist = 10.0;
    float2 relClos = float2(0.0, 0.0);
    float2 relRot = 0.5 * float2(cos(elapsed_time), sin(elapsed_time));


    for (int y= -3; y <= 3; y++) {
        for (int x= -3; x <= 3; x++) {
            float2 neighbor = float2(float(x),float(y));

            float2 point2 = random2(pixExt + neighbor);
            float2 relRot = randomSpin(pixExt + neighbor, 0.5);
            float2 diff = neighbor + relRot + point2 - pixInt;
            float dist = length(diff);
            if(dist < m_dist){
                m_dist = dist;
                relClos = neighbor;
            }
        }
    }
    float2 nPoint = pixExt + relClos + random2(pixExt + relClos);
    nPoint = nPoint / pixH;
    nPoint.x = nPoint.x * uv_scale.x;
    
    return image.Sample(textureSampler, nPoint);
}


float4 mainImage(VertData v_in) : TARGET
{
    if (alternative) {
        return VoronoiPixelation2(v_in.uv, pixH);
    } else {
        return VoronoiPixelation(v_in.uv, pixH);
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

