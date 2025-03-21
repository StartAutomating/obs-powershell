function Get-OBSBoxBlurShader {

[Alias('Set-OBSBoxBlurShader','Add-OBSBoxBlurShader')]
param(
# Set the Strength of OBSBoxBlurShader
[ComponentModel.DefaultBindingProperty('Strength')]
[Int32]
$Strength,
# Set the Mask_Left of OBSBoxBlurShader
[Alias('Mask_Left')]
[ComponentModel.DefaultBindingProperty('Mask_Left')]
[Single]
$MaskLeft,
# Set the Mask_Right of OBSBoxBlurShader
[Alias('Mask_Right')]
[ComponentModel.DefaultBindingProperty('Mask_Right')]
[Single]
$MaskRight,
# Set the Mask_Top of OBSBoxBlurShader
[Alias('Mask_Top')]
[ComponentModel.DefaultBindingProperty('Mask_Top')]
[Single]
$MaskTop,
# Set the Mask_Bottom of OBSBoxBlurShader
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
$shaderName = 'box-blur'
$ShaderNoun = 'OBSBoxBlurShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
uniform int Strength<
    string label = "Strength (1)";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 25;
    int step = 1;
> = 1;
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
    if(Strength <= 0)
        return image.Sample(textureSampler, v_in.uv);
	
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
    float transparent = 0.0;
    int count = 1;
    float samples = 0.0;
    float4 c = float4(0.0, 0.0, 0.0, 0.0);
    float Steps = float(Strength);
    
    [loop] for (int i = -Strength; i <= Strength; i++) {
    	[loop] for (int k = -Strength; k <= Strength; k++) {
            float4 sc = image.Sample(textureSampler, v_in.uv+float2(float(i), float(k))/uv_size*Steps);
            transparent += sc.a;
			count++;
            c += sc * sc.a;
            samples += sc.a;
        }
    }
    if(samples > 0.0)
        c /= samples;

    c.a = transparent / float(count); 
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

