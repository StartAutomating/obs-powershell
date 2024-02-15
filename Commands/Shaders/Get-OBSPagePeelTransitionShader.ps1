function Get-OBSPagePeelTransitionShader {

[Alias('Set-OBSPagePeelTransitionShader','Add-OBSPagePeelTransitionShader')]
param(
# Set the image_a of OBSPagePeelTransitionShader
[Alias('image_a')]
[ComponentModel.DefaultBindingProperty('image_a')]
[String]
$ImageA,
# Set the image_b of OBSPagePeelTransitionShader
[Alias('image_b')]
[ComponentModel.DefaultBindingProperty('image_b')]
[String]
$ImageB,
# Set the transition_time of OBSPagePeelTransitionShader
[Alias('transition_time')]
[ComponentModel.DefaultBindingProperty('transition_time')]
[Single]
$TransitionTime,
# Set the convert_linear of OBSPagePeelTransitionShader
[Alias('convert_linear')]
[ComponentModel.DefaultBindingProperty('convert_linear')]
[Management.Automation.SwitchParameter]
$ConvertLinear,
# Set the page_color of OBSPagePeelTransitionShader
[Alias('page_color')]
[ComponentModel.DefaultBindingProperty('page_color')]
[String]
$PageColor,
# Set the page_transparency of OBSPagePeelTransitionShader
[Alias('page_transparency')]
[ComponentModel.DefaultBindingProperty('page_transparency')]
[Single]
$PageTransparency,
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
$shaderName = 'page-peel-transition'
$ShaderNoun = 'OBSPagePeelTransitionShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
uniform texture2d image_a;
uniform texture2d image_b;
uniform float transition_time<
    string label = "Transittion Time";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.5;
uniform bool convert_linear = true;
uniform float4 page_color = {1.0, 1.0, 1.0, 1.0};
uniform float page_transparency<
    string label = "Page Transparency";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.5;

float4 mainImage(VertData v_in) : TARGET
{
    // Normalized pixel coordinates (from 0 to 1)
    float2 aspect = float2( uv_size.x / uv_size.y, 1.0 );
	float2 uv = v_in.uv;

    float t = transition_time * 12.0 + 11.0;
    // Define the fold.
    float2 origin = float2( 0.6 + 0.6 * sin( t * 0.2 ), 0.5 + 0.5 * cos( t * 0.13 ) ) * aspect;
    float2 normal = normalize( float2( 1.0, 2.0 * sin( t * 0.3 ) ) * aspect );

    // Sample texture.
    float3 col = float3(1.0,0.0,0.0);
    
    // Check on which side the pixel lies.
    float2 pt = uv * aspect - origin;
    float side = dot( pt, normal );
    if( side > 0.0 ) {
        // Next page
        col = image_b.Sample( textureSampler, uv ).rgb;
            
        float shadow = smoothstep( 0.0, 0.05, side );
        col = lerp( col * 0.6, col, shadow );
    }
    else {
        

        // Find the mirror pixel.
        pt = ( uv * aspect - 2.0 * side * normal ) / aspect;
        
        // Check if we''re still inside the image bounds.
        if( pt.x >= 0.0 && pt.x < 1.0 && pt.y >= 0.0 && pt.y < 1.0 ) {
            col = image_a.Sample( textureSampler, pt ).rgb; // Back color.
            col = lerp(page_color.rgb, col, page_transparency);
            
            float shadow = smoothstep( 0.0, 0.2, -side );
            col = lerp( col * 0.2, col, shadow );
        }else{
            col = image_a.Sample( textureSampler, uv ).rgb;
        }
    }
    
    // Output to screen
    if(convert_linear)
        col = srgb_nonlinear_to_linear(col);
	return float4(col,1.0);
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

