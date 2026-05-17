function Get-OBSGlitchPeriodicShader {

[Alias('Set-OBSGlitchPeriodicShader','Add-OBSGlitchPeriodicShader')]
param(
# Set the PERI of OBSGlitchPeriodicShader
[ComponentModel.DefaultBindingProperty('PERI')]
[Single]
$PERI,
# Set the DURA of OBSGlitchPeriodicShader
[ComponentModel.DefaultBindingProperty('DURA')]
[Single]
$DURA,
# Set the AMPL of OBSGlitchPeriodicShader
[ComponentModel.DefaultBindingProperty('AMPL')]
[Single]
$AMPL,
# Set the SCRA of OBSGlitchPeriodicShader
[ComponentModel.DefaultBindingProperty('SCRA')]
[Single]
$SCRA,
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
$shaderName = 'glitch-periodic'
$ShaderNoun = 'OBSGlitchPeriodicShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Created by Éric Nicolas (ccjmne) for use with obs-shaderfilter 12/2025
// Port of:                https://www.shadertoy.com/view/WfVfDh
// Originally forked from: https://www.shadertoy.com/view/MtXBDs

#define PI 3.14159265359

/*           For visual explanation of the paramters, see            */
/*           https://www.desmos.com/calculator/vezu1wyqma            */
/*                                                                   */
/*  Period        How often a glitch occurs  (in seconds)  0–?       */
/*  Duration      How long a glitch lasts    (in seconds)  0–Period  */
/*  Amplitude     How intense a glitch is                  0–1       */
/*  Scratchiness  How jittery a glitch is                  0–1       */

uniform float PERI<
    string label       = "Period";
    string widget_type = "slider";
    float minimum      = 1.;
    float maximum      = 60.;
    float step         = 1.;
> = 6.;

uniform float DURA<
    string label       = "Duration";
    string widget_type = "slider";
    float minimum      = 0.;
    float maximum      = 60.;
    float step         = .01;
> = .5;

uniform float AMPL<
    string label       = "Amplitude";
    string widget_type = "slider";
    float minimum      = 0.;
    float maximum      = 1.;
    float step         = .01;
> = .15;

uniform float SCRA<
    string label       = "Scratchiness";
    string widget_type = "slider";
    float minimum      = 0.;
    float maximum      = 1.;
    float step         = .01;
> = .2;

float random2d(float2 n) {
    return frac(sin(dot(n, float2(12.9898, 4.1414))) * 43758.5453);
}

float randomRange(in float2 seed, in float lo, in float hi) {
    return lo + random2d(seed) * (hi - lo);
}

float insideRange(float v, float bottom, float top) {
    return step(bottom, v) - step(top, v);
}

float4 mainImage(VertData v_in): TARGET {
    float time = floor(elapsed_time * SCRA * 60.);
    float2 uv = v_in.uv;

    // Periodic intermittence
    float AMP = AMPL * (cos(2. * PI * max(0., (mod(-elapsed_time / PERI, 1.) - 1.) * PERI / DURA + 1.)) * -.5 + .5);

    float4 outCol = image.Sample(textureSampler, uv);

    // Randomly offset slices horizontally
    float offsetMax = AMP / 2.;
    for (float i = 0.; i < 10. * AMP; i += 1.) {
        float sliceY =  random2d(   float2(time, 2345. + i));
        float sliceH =  random2d(   float2(time, 9035. + i)) * .25;
        float offsetH = randomRange(float2(time, 9625. + i), -offsetMax, offsetMax);
        float2 uvOff = uv;
        uvOff.x += offsetH;
        if (insideRange(uv.y, sliceY, frac(sliceY + sliceH)) == 1.) {
            outCol = image.Sample(textureSampler, uvOff);
        }
    }

    // Slightly offset one entire channel
    offsetMax = AMP / 6.;
    float2 colOff = float2(
        randomRange(float2(time, 9545.), -offsetMax, offsetMax),
        randomRange(float2(time, 7205.), -offsetMax, offsetMax)
    );
    float rnd = random2d(float2(time , 9545.));
    if      (rnd < .33) outCol.r = image.Sample(textureSampler, uv + colOff).r;
    else if (rnd < .66) outCol.g = image.Sample(textureSampler, uv + colOff).g;
    else                outCol.b = image.Sample(textureSampler, uv + colOff).b;

    return outCol;
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

