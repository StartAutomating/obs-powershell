function Get-OBSChromaUVDistortionShader {

[Alias('Set-OBSChromaUVDistortionShader','Add-OBSChromaUVDistortionShader')]
param(
# Set the distortion of OBSChromaUVDistortionShader
[ComponentModel.DefaultBindingProperty('distortion')]
[Single]
$Distortion,
# Set the amplitude of OBSChromaUVDistortionShader
[ComponentModel.DefaultBindingProperty('amplitude')]
[Single]
$Amplitude,
# Set the chroma of OBSChromaUVDistortionShader
[ComponentModel.DefaultBindingProperty('chroma')]
[Single]
$Chroma,
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
$shaderName = 'Chroma+UV-Distortion'
$ShaderNoun = 'OBSChromaUVDistortionShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
//based on https://www.shadertoy.com/view/WsdyRN

//Higher values = less distortion
uniform float distortion<
    string label = "Distortion";
    string widget_type = "slider";
    float minimum = 5.0;
    float maximum = 1000.0;
    float step = 0.01;
> = 75.;
//Higher values = tighter distortion
uniform float amplitude<
    string label = "Amplitude";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 0.01;
> = 10.;
//Higher values = more color distortion
uniform float chroma<
    string label = "Chroma";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 6.28318531;
    float step = 0.01;
> = .5;

float2 zoomUv(float2 uv, float zoom) {
    float2 uv1 = uv;
    uv1 += .5;
    uv1 += zoom/2.-1.;
    uv1 /= zoom;
    return uv1;
}

float4 mainImage(VertData v_in) : TARGET
{
    float2 uvt = v_in.uv;
    
    float2 uvtR = uvt;
    float2 uvtG = uvt;
    float2 uvtB = uvt;
    
    //Uncomment the following line to get varying chroma distortion
    //chroma = sin(elapsed_time)/2.+.5;
    
    uvtR += float2(sin(uvt.y*amplitude+elapsed_time)/distortion, cos(uvt.x*amplitude+elapsed_time)/distortion);
    uvtG += float2(sin(uvt.y*amplitude+elapsed_time+chroma)/distortion, cos(uvt.x*amplitude+elapsed_time+chroma)/distortion);
    uvtB += float2(sin(uvt.y*amplitude+elapsed_time+(chroma*2.))/distortion, cos(uvt.x*amplitude+elapsed_time+(chroma*2.))/distortion);
    
    float2 uvR = zoomUv(uvtR, 1.1);
    float2 uvG = zoomUv(uvtG, 1.1);
    float2 uvB = zoomUv(uvtB, 1.1);
    
    float4 colR = image.Sample(textureSampler, uvR);
    float4 colG = image.Sample(textureSampler, uvG);
    float4 colB = image.Sample(textureSampler, uvB);

    return float4(colR.r, colG.g, colB.b, (colR.a + colG.a + colB.a) / 3.0);
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

