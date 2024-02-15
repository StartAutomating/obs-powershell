function Get-OBSReflectShader {

[Alias('Set-OBSReflectShader','Add-OBSReflectShader')]
param(
# Set the Horizontal of OBSReflectShader
[ComponentModel.DefaultBindingProperty('Horizontal')]
[Management.Automation.SwitchParameter]
$Horizontal,
# Set the Vertical of OBSReflectShader
[ComponentModel.DefaultBindingProperty('Vertical')]
[Management.Automation.SwitchParameter]
$Vertical,
# Set the center_x_percent of OBSReflectShader
[Alias('center_x_percent')]
[ComponentModel.DefaultBindingProperty('center_x_percent')]
[Int32]
$CenterXPercent,
# Set the center_y_percent of OBSReflectShader
[Alias('center_y_percent')]
[ComponentModel.DefaultBindingProperty('center_y_percent')]
[Int32]
$CenterYPercent,
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
$NoResponse
)


process {
$shaderName = 'Reflect'
$ShaderNoun = 'OBSReflectShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Simple Reflect Shader

// Reflects horizontally and/or vertically.

uniform bool Horizontal<
    string label = "Reflect horizontally";
> = false;
uniform bool Vertical<
    string label = "Reflect vertically";
> = true;

uniform int center_x_percent<
    string label = "center x percentage";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 50;
uniform int center_y_percent<
    string label = "center y percentage";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 100;
    int step = 1;
> = 50;


float4 mainImage(VertData v_in) : TARGET
{
    float2 pos = v_in.uv;
    float2 center_pos = float2(center_x_percent * .01, center_y_percent * .01);
    
    if (Horizontal == true) {
        if (pos.x < center_pos.x) {
            pos.x = center_pos.x - pos.x;
        } else if (pos.x == center_pos.x) {
            pos.x = pos.x;
        }  else {
            pos.x = pos.x - center_pos.x;
        }
    }
    if (Vertical == true) {
        if (pos.y < center_pos.y) {            
            pos.y = center_pos.y - pos.y;
        } else if (pos.y == center_pos.y) {
            pos.y = pos.y;
        }  else {
            pos.y = pos.y - center_pos.y;
        }
    }
    
    return image.Sample(textureSampler, pos);
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
