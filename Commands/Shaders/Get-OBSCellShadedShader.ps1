function Get-OBSCellShadedShader {

[Alias('Set-OBSCellShadedShader','Add-OBSCellShadedShader')]
param(
# Set the Angle_Steps of OBSCellShadedShader
[Alias('Angle_Steps')]
[ComponentModel.DefaultBindingProperty('Angle_Steps')]
[Int32]
$AngleSteps,
# Set the Radius_Steps of OBSCellShadedShader
[Alias('Radius_Steps')]
[ComponentModel.DefaultBindingProperty('Radius_Steps')]
[Int32]
$RadiusSteps,
# Set the ampFactor of OBSCellShadedShader
[ComponentModel.DefaultBindingProperty('ampFactor')]
[Single]
$AmpFactor,
# Set the notes of OBSCellShadedShader
[ComponentModel.DefaultBindingProperty('notes')]
[String]
$Notes,
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
$shaderName = 'cell_shaded'
$ShaderNoun = 'OBSCellShadedShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Cell Shaded shader by Charles Fettinger for obs-shaderfilter plugin 3/2019
//https://github.com/Oncorporation/obs-shaderfilter
//Converted to OpenGL by Q-mii & Exeldro February 18, 2022
uniform int Angle_Steps<
    string label = "Angle Steps";
    string widget_type = "slider";
    int minimum = 1;
    int maximum = 20;
    int step = 1;
> = 5;
uniform int Radius_Steps<
    string label = "Radius Steps";
    string widget_type = "slider";
    int minimum = 0;
    int maximum = 20;
    int step = 1;
> = 9; 
uniform float ampFactor<
    string label = "amp Factor";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 0.01;
> = 2.0;
uniform string notes<
    string widget_type = "info";
> = "Steps limited in range from 0 to 20. Edit cell_shaded.shader to remove limits at your own risk.";

float4 mainImage(VertData v_in) : TARGET
{
	float radiusSteps = clamp(Radius_Steps, 0, 20);
	float angleSteps = clamp(Angle_Steps, 1, 20);
	float PI = 3.1415926535897932384626433832795;//acos(-1);
	int totalSteps = int(radiusSteps * angleSteps);
	float minRadius = (3 * uv_pixel_interval.y);
	float maxRadius = (24 * uv_pixel_interval.y);

	float angleDelta = ((2 * PI) / angleSteps);
	float radiusDelta = ((maxRadius - minRadius) / radiusSteps);

	float4 c0 = image.Sample(textureSampler, v_in.uv);
	float4 origColor = c0;
	float4 accumulatedColor = float4(0,0,0,0);

	for (int radiusStep = 0; radiusStep < radiusSteps; radiusStep++) {
		float radius = minRadius + radiusStep * radiusDelta;

		for (float angle=0; angle <(2*PI); angle += angleDelta) {
			float2 currentCoord;

			float xDiff = radius * cos(angle);
			float yDiff = radius * sin(angle);
			
			currentCoord = v_in.uv + float2(xDiff, yDiff);
			float4 currentColor = image.Sample(textureSampler, currentCoord);
			float4 colorDiff = abs(c0 - currentColor);
			float currentFraction = (radiusSteps + 1 - radiusStep) / (radiusSteps + 1);
			accumulatedColor +=  currentFraction * colorDiff / totalSteps;
			
		}
	}
	accumulatedColor *= ampFactor;

	return c0 - accumulatedColor; // Cell shaded style
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

