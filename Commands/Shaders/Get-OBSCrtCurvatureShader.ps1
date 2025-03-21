function Get-OBSCrtCurvatureShader {

[Alias('Set-OBSCrtCurvatureShader','Add-OBSCrtCurvatureShader')]
param(
# Set the strength of OBSCrtCurvatureShader
[ComponentModel.DefaultBindingProperty('strength')]
[Single]
$Strength,
# Set the border of OBSCrtCurvatureShader
[ComponentModel.DefaultBindingProperty('border')]
[String]
$Border,
# Set the feathering of OBSCrtCurvatureShader
[ComponentModel.DefaultBindingProperty('feathering')]
[Single]
$Feathering,
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
$shaderName = 'crt-curvature'
$ShaderNoun = 'OBSCrtCurvatureShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
uniform float strength<
	string label = "Strength";
	string widget_type = "slider";
	float minimum = 0.;
	float maximum = 200.;
	float step = 0.01;
> = 33.33;

uniform float4 border<
	string label = "Border Color";
> = {0., 0., 0., 1.};

uniform float feathering<
	string label = "Feathering";	
	string widget_type = "slider";
	float minimum = 0.0;
	float maximum = 100.0;
	float step = 0.01;
> = 33.33;


float4 mainImage(VertData v_in) : TARGET
{
    float2 cc = v_in.uv - float2(0.5, 0.5);
    float dist = dot(cc, cc) * strength / 100.0;
    float2 bent = v_in.uv + cc * (1.0 + dist) * dist;
    if ((bent.x <= 0.0 || bent.x >= 1.0) || (bent.y <= 0.0 || bent.y >= 1.0)) {
		return border;
	}
    if (feathering >= .01) {
        float2 borderArea = float2(0.5, 0.5) * feathering / 100.0;
        float2 borderDistance = (float2(0.5, 0.5) - abs(bent - float2(0.5, 0.5))) / float2(0.5, 0.5);
        borderDistance = (min(borderDistance - float2(0.5, 0.5) * feathering / 100.0, 0) + borderArea) / borderArea;
        float borderFade = sin(borderDistance.x * 1.570796326) * sin(borderDistance.y * 1.570796326);
        return lerp(border, image.Sample(textureSampler, bent), borderFade);
    }

	return image.Sample(textureSampler, bent);
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

