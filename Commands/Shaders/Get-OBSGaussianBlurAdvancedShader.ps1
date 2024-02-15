function Get-OBSGaussianBlurAdvancedShader {

[Alias('Set-OBSGaussianBlurAdvancedShader','Add-OBSGaussianBlurAdvancedShader')]
param(
# Set the Directions of OBSGaussianBlurAdvancedShader
[ComponentModel.DefaultBindingProperty('Directions')]
[Single]
$Directions,
# Set the Quality of OBSGaussianBlurAdvancedShader
[ComponentModel.DefaultBindingProperty('Quality')]
[Single]
$Quality,
# Set the Size of OBSGaussianBlurAdvancedShader
[ComponentModel.DefaultBindingProperty('Size')]
[Single]
$Size,
# Set the Mask_Left of OBSGaussianBlurAdvancedShader
[Alias('Mask_Left')]
[ComponentModel.DefaultBindingProperty('Mask_Left')]
[Single]
$MaskLeft,
# Set the Mask_Right of OBSGaussianBlurAdvancedShader
[Alias('Mask_Right')]
[ComponentModel.DefaultBindingProperty('Mask_Right')]
[Single]
$MaskRight,
# Set the Mask_Top of OBSGaussianBlurAdvancedShader
[Alias('Mask_Top')]
[ComponentModel.DefaultBindingProperty('Mask_Top')]
[Single]
$MaskTop,
# Set the Mask_Bottom of OBSGaussianBlurAdvancedShader
[Alias('Mask_Bottom')]
[ComponentModel.DefaultBindingProperty('Mask_Bottom')]
[Single]
$MaskBottom,
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
$shaderName = 'gaussian-blur-advanced'
$ShaderNoun = 'OBSGaussianBlurAdvancedShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
uniform float Directions<
    string label = "Directions (16.0)";
    string widget_type = "slider";
    float minimum = 1.0;
    float maximum = 100.0;
    float step = 1.0;
> = 16.0; // BLUR DIRECTIONS (Default 16.0 - More is better but slower)
uniform float Quality<
    string label = "Quality (4.0)";
    string widget_type = "slider";
    float minimum = 1.0;
    float maximum = 100.0;
    float step = 1.0;
> = 4.0; // BLUR QUALITY (Default 4.0 - More is better but slower)
uniform float Size<
    string label = "Size (8.0)";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 1.0;
> = 8.0; // BLUR SIZE (Radius)
uniform float Mask_Left<
    string label = "Mask left (1.0)";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.01;
> = 1.0;
uniform float Mask_Right<
    string label = "Mask right (1.0)";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.01;
> = 1.0;
uniform float Mask_Top<
    string label = "Mask top (1.0)";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.01;
> = 1.0;
uniform float Mask_Bottom<
    string label = "Mask bottom (1.0)";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.01;
> = 1.0;

float4 mainImage(VertData v_in) : TARGET
{
	if(Mask_Left + Mask_Right > 1.0){
		if(v_in.uv.x > Mask_Left || 1.0 - v_in.uv.x > Mask_Right ){
			return image.Sample(textureSampler, v_in.uv);
		}
	}else{
		if((v_in.uv.x > Mask_Left) && (1.0-v_in.uv.x > Mask_Right)){
			return image.Sample(textureSampler, v_in.uv);
		}
	}
	if(Mask_Top + Mask_Bottom > 1.0){
		if(v_in.uv.y > Mask_Top || 1.0 - v_in.uv.y > Mask_Bottom){
			return image.Sample(textureSampler, v_in.uv);
		}
	}else {
		if((v_in.uv.y > Mask_Top) && (1.0-v_in.uv.y > Mask_Bottom)){
			return image.Sample(textureSampler, v_in.uv);
		}
	}
	
    float Pi = 6.28318530718; // Pi*2
    
    float4 c = image.Sample(textureSampler, v_in.uv);
    float4 oc = c;
    float transparent = oc.a;
    int count = 1;
    float samples = oc.a;
    
    // Blur calculations
    [loop] for( float d=0.0; d<Pi; d+=Pi/Directions)
    {
		[loop] for(float i=1.0/Quality; i<=1.0; i+=1.0/Quality)
        {
            float4 sc = image.Sample(textureSampler,v_in.uv+float2(cos(d),sin(d))*Size*i/uv_size);
            transparent += sc.a;
			count++;
            c += sc * sc.a;
            samples += sc.a;
        }
    }

    //Calculate averages
    if(samples > 0.0)
        c /= samples;

    c.a = transparent / count; 
    return c;
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

