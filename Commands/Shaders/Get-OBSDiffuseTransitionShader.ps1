function Get-OBSDiffuseTransitionShader {

[Alias('Set-OBSDiffuseTransitionShader','Add-OBSDiffuseTransitionShader')]
param(
# Set the image_a of OBSDiffuseTransitionShader
[Alias('image_a')]
[ComponentModel.DefaultBindingProperty('image_a')]
[String]
$ImageA,
# Set the image_b of OBSDiffuseTransitionShader
[Alias('image_b')]
[ComponentModel.DefaultBindingProperty('image_b')]
[String]
$ImageB,
# Set the transition_time of OBSDiffuseTransitionShader
[Alias('transition_time')]
[ComponentModel.DefaultBindingProperty('transition_time')]
[Single]
$TransitionTime,
# Set the convert_linear of OBSDiffuseTransitionShader
[Alias('convert_linear')]
[ComponentModel.DefaultBindingProperty('convert_linear')]
[Management.Automation.SwitchParameter]
$ConvertLinear,
# Set the num_samples of OBSDiffuseTransitionShader
[Alias('num_samples')]
[ComponentModel.DefaultBindingProperty('num_samples')]
[Int32]
$NumSamples,
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
$shaderName = 'diffuse_transition'
$ShaderNoun = 'OBSDiffuseTransitionShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
//based on https://www.shadertoy.com/view/4cK3z1
uniform texture2d image_a;
uniform texture2d image_b;
uniform float transition_time = 0.5;
uniform bool convert_linear = true;

// Diffuse (move pixels) between two 2D images
// Demo inspired by Iterative-(de)Blending (see Figure 9 in https://arxiv.org/pdf/2305.03486.pdf)
// Note: the approach in this demo is different - rather than randomising paths we use means

// increase for greater precision - this is O(n^2) :(
uniform int num_samples<
    string label = "Number of samples (10)";
    string widget_type = "slider";
    int minimum = 2;
    int maximum = 100;
    int step = 1;
> = 10;

float4 mainImage(VertData v_in) : TARGET
{
    float2 uv = v_in.uv;

    if (transition_time < 0.00001) {
        return image_a.Sample(textureSampler, uv);
    }
    
    // we need to normalise the distributions so just sum the samples for a division later
    // note: could calculate this once per image in a buffer or something
    float3 from_total = float3(0.0,0.0,0.0);
    float3 to_total = float3(0.0,0.0,0.0);

    for (int i=0; i<num_samples; i++) {
        float sample_x = float(i) / float(num_samples);

        for (int j=0; j<num_samples; j++) {
            float sample_y = float(j) / float(num_samples);
            float2 sample_pos = float2(sample_x, sample_y);

            from_total += image_a.Sample(textureSampler, sample_pos).rgb;
            to_total += image_b.Sample(textureSampler, sample_pos).rgb;
        }
    }

    // only a subset of the inputs and outputs would cross our 3d coord, we can compute the ranges
    // maths: https://www.desmos.com/3d/60b155c9e9
    float from_alpha = -transition_time/(1.0-transition_time);
    
    float2 from_start = clamp(((1.0 - uv) *from_alpha) + uv, float2(0.0,0.0), float2(1.0,1.0));
    float2 from_end = clamp(-uv * from_alpha + uv, float2(0.0,0.0), float2(1.0,1.0));
    
    float to_alpha = (1.0-transition_time) / -transition_time;

    float2 to_start = clamp(-uv * to_alpha + uv, float2(0.0,0.0), float2(1.0,1.0));
    float2 to_end = clamp((1.0 - uv) * to_alpha + uv, float2(0.0,0.0), float2(1.0,1.0));

    //all we need to do is figure out how many points from the original distribution will go through this coord on their way to the target
    float3 sum = float3(0.0,0.0,0.0);

    for (int i=0; i<num_samples; i++) {
        float sample_x = float(i) / float(num_samples);

        for (int j=0; j<num_samples; j++) {
            float sample_y = float(j) / float(num_samples);
            float2 sample_pos = float2(sample_x, sample_y);

            float2 from_pos = lerp(from_start, from_end, sample_pos);
            float2 to_pos = lerp(to_start, to_end, sample_pos);

            sum += image_a.Sample(textureSampler, from_pos).rgb  * (image_b.Sample(textureSampler, to_pos).rgb / to_total);
        }
    }
    
    //the two distributions may have a different sum so scale to blend between the two
    float3 target_total = lerp(from_total, to_total, transition_time);
    float3 total_multiplier = target_total / from_total;

    sum *= total_multiplier;
    if (convert_linear)
		sum = srgb_nonlinear_to_linear(sum);

    return  float4(sum,1.0);
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

