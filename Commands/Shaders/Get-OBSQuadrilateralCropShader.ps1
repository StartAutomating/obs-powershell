function Get-OBSQuadrilateralCropShader {

[Alias('Set-OBSQuadrilateralCropShader','Add-OBSQuadrilateralCropShader')]
param(
# Set the Top_Left_X of OBSQuadrilateralCropShader
[Alias('Top_Left_X')]
[ComponentModel.DefaultBindingProperty('Top_Left_X')]
[Single]
$TopLeftX,
# Set the Top_Left_Y of OBSQuadrilateralCropShader
[Alias('Top_Left_Y')]
[ComponentModel.DefaultBindingProperty('Top_Left_Y')]
[Single]
$TopLeftY,
# Set the Top_Right_X of OBSQuadrilateralCropShader
[Alias('Top_Right_X')]
[ComponentModel.DefaultBindingProperty('Top_Right_X')]
[Single]
$TopRightX,
# Set the Top_Right_Y of OBSQuadrilateralCropShader
[Alias('Top_Right_Y')]
[ComponentModel.DefaultBindingProperty('Top_Right_Y')]
[Single]
$TopRightY,
# Set the Bottom_Left_X of OBSQuadrilateralCropShader
[Alias('Bottom_Left_X')]
[ComponentModel.DefaultBindingProperty('Bottom_Left_X')]
[Single]
$BottomLeftX,
# Set the Bottom_Left_Y of OBSQuadrilateralCropShader
[Alias('Bottom_Left_Y')]
[ComponentModel.DefaultBindingProperty('Bottom_Left_Y')]
[Single]
$BottomLeftY,
# Set the Bottom_Right_X of OBSQuadrilateralCropShader
[Alias('Bottom_Right_X')]
[ComponentModel.DefaultBindingProperty('Bottom_Right_X')]
[Single]
$BottomRightX,
# Set the Bottom_Right_Y of OBSQuadrilateralCropShader
[Alias('Bottom_Right_Y')]
[ComponentModel.DefaultBindingProperty('Bottom_Right_Y')]
[Single]
$BottomRightY,
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
$shaderName = 'quadrilateral_crop'
$ShaderNoun = 'OBSQuadrilateralCropShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Quadrilateral Crop shader (inverse of a corner pin): transform a 4 points polygon to the corners of the source.
// Useful to revert perspective.

uniform float Top_Left_X<
    string label = "Top Left X";
    string widget_type = "slider";
    float minimum = 0;
    float maximum = 100.0;
    float step = 0.01;
> = 0;
uniform float Top_Left_Y<
    string label = "Top Left Y";
    string widget_type = "slider";
    float minimum = 0;
    float maximum = 100.0;
    float step = 0.01;
> = 0;
uniform float Top_Right_X<
    string label = "Top Right X";
    string widget_type = "slider";
    float minimum = 0;
    float maximum = 100.0;
    float step = 0.01;
> = 100.;
uniform float Top_Right_Y<
    string label = "Top Right Y";
    string widget_type = "slider";
    float minimum = 0;
    float maximum = 100.0;
    float step = 0.01;
> = 0;
uniform float Bottom_Left_X<
    string label = "Bottom Left X";
    string widget_type = "slider";
    float minimum = 0;
    float maximum = 100.0;
    float step = 0.01;
> = 0;
uniform float Bottom_Left_Y<
    string label = "Bottom Left Y";
    string widget_type = "slider";
    float minimum = 0;
    float maximum = 100.0;
    float step = 0.01;
> = 100.;
uniform float Bottom_Right_X<
    string label = "Bottom Right X";
    string widget_type = "slider";
    float minimum = 0;
    float maximum = 100.0;
    float step = 0.01;
> = 100.;
uniform float Bottom_Right_Y<
    string label = "Bottom Right Y";
    string widget_type = "slider";
    float minimum = 0;
    float maximum = 100.0;
    float step = 0.01;
> = 100.;

float4 mainImage( VertData v_in ) : TARGET {
	
	float2 tl = float2(Top_Left_X, Top_Left_Y) * .01;
	float2 tr = float2(Top_Right_X, Top_Right_Y) * .01;
	float2 bl = float2(Bottom_Left_X, Bottom_Left_Y) * .01;
	float2 br = float2(Bottom_Right_X, Bottom_Right_Y) * .01;
	
	float2 t = lerp(tl, tr, v_in.uv[0]);
	float2 b = lerp(bl, br, v_in.uv[0]);
	float2 uv = lerp(t, b, v_in.uv[1]);

	return image.Sample(textureSampler, uv);
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

