function Get-OBSPixelationShader {

[Alias('Set-OBSPixelationShader','Add-OBSPixelationShader')]
param(
# Set the Target_Width of OBSPixelationShader
[Alias('Target_Width')]
[ComponentModel.DefaultBindingProperty('Target_Width')]
[Single]
$TargetWidth,
# Set the Target_Height of OBSPixelationShader
[Alias('Target_Height')]
[ComponentModel.DefaultBindingProperty('Target_Height')]
[Single]
$TargetHeight,
# Set the notes of OBSPixelationShader
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
$shaderName = 'pixelation'
$ShaderNoun = 'OBSPixelationShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// pixelation shader by Charles Fettinger for obs-shaderfilter plugin 3/2019
// with help from SkeltonBowTV
// https://github.com/Oncorporation/obs-shaderfilter
//Converted to OpenGL by Exeldro February 15, 2022
uniform float Target_Width<
    string label = "Target Width";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 2000.0;
    float step = 0.1;
> = 320.0;
uniform float Target_Height<
    string label = "Target Height";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 2000.0;
    float step = 0.1;
> = 180.0;
uniform string notes<
    string widget_type = "info";
> = "adjust width and height to your screen dimension";

float4 mainImage(VertData v_in) : TARGET
{
	float targetWidth = Target_Width;
	if(targetWidth < 2.0)
		targetWidth = 2.0;
	float targetHeight = Target_Height;
	if(targetHeight < 2.0)
		targetHeight = 2.0;
	float2 tex1;
	int pixelSizeX = int(uv_size.x / targetWidth);
	int pixelSizeY = int(uv_size.y / targetHeight);

	int pixelX = int(v_in.uv.x * uv_size.x);
	int pixelY = int(v_in.uv.y * uv_size.y);

	tex1.x = ((float(pixelX / pixelSizeX)*float(pixelSizeX)) / uv_size.x) + (float(pixelSizeX) / uv_size.x)/2.0;
	tex1.y = ((float(pixelY / pixelSizeY)*float(pixelSizeY)) / uv_size.y) + (float(pixelSizeY) / uv_size.y)/2.0;

	float4 c1 = image.Sample(textureSampler, tex1 );

	return c1;
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

