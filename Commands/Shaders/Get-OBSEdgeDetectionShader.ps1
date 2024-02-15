function Get-OBSEdgeDetectionShader {

[Alias('Set-OBSEdgeDetectionShader','Add-OBSEdgeDetectionShader')]
param(
# Set the sensitivity of OBSEdgeDetectionShader
[ComponentModel.DefaultBindingProperty('sensitivity')]
[Single]
$Sensitivity,
# Set the invert_edge of OBSEdgeDetectionShader
[Alias('invert_edge')]
[ComponentModel.DefaultBindingProperty('invert_edge')]
[Management.Automation.SwitchParameter]
$InvertEdge,
# Set the edge_color of OBSEdgeDetectionShader
[Alias('edge_color')]
[ComponentModel.DefaultBindingProperty('edge_color')]
[String]
$EdgeColor,
# Set the edge_multiply of OBSEdgeDetectionShader
[Alias('edge_multiply')]
[ComponentModel.DefaultBindingProperty('edge_multiply')]
[Management.Automation.SwitchParameter]
$EdgeMultiply,
# Set the non_edge_color of OBSEdgeDetectionShader
[Alias('non_edge_color')]
[ComponentModel.DefaultBindingProperty('non_edge_color')]
[String]
$NonEdgeColor,
# Set the non_edge_multiply of OBSEdgeDetectionShader
[Alias('non_edge_multiply')]
[ComponentModel.DefaultBindingProperty('non_edge_multiply')]
[Management.Automation.SwitchParameter]
$NonEdgeMultiply,
# Set the alpha_channel of OBSEdgeDetectionShader
[Alias('alpha_channel')]
[ComponentModel.DefaultBindingProperty('alpha_channel')]
[Management.Automation.SwitchParameter]
$AlphaChannel,
# Set the alpha_level of OBSEdgeDetectionShader
[Alias('alpha_level')]
[ComponentModel.DefaultBindingProperty('alpha_level')]
[Single]
$AlphaLevel,
# Set the alpha_invert of OBSEdgeDetectionShader
[Alias('alpha_invert')]
[ComponentModel.DefaultBindingProperty('alpha_invert')]
[Management.Automation.SwitchParameter]
$AlphaInvert,
# Set the rand_f of OBSEdgeDetectionShader
[Alias('rand_f')]
[ComponentModel.DefaultBindingProperty('rand_f')]
[Single]
$RandF,
# Set the notes of OBSEdgeDetectionShader
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
$shaderName = 'edge_detection'
$ShaderNoun = 'OBSEdgeDetectionShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Edge Detection for OBS Studio
// originally from Andersama (https://github.com/Andersama)
// Modified and improved my Charles Fettinger (https://github.com/Oncorporation)  1/2019
//Converted to OpenGL by Q-mii & Exeldro March 8, 2022
uniform float sensitivity<
    string label = "Sensitivity";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.05;
uniform bool invert_edge;
uniform float4 edge_color = {1.0,1.0,1.0,1.0};
uniform bool edge_multiply;
uniform float4 non_edge_color = {0.0,0.0,0.0,0.0};
uniform bool non_edge_multiply;
uniform bool alpha_channel;
uniform float alpha_level<
    string label = "Alpha level";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 100.0;
    float step = 1.0;
> = 100.0;
uniform bool alpha_invert;
uniform float rand_f;

uniform string notes<
    string widget_type = "info";
> = "''sensitivity'' - 0.01 is max and will create the most edges. Increasing this value decreases the number of edges detected.  ''edge non edge color'' - the color to recolor vs the original image. ''edge or non edge multiply'' - multiplies the color against the original color giving it a tint instead of replacing the color. White represents no tint. ''invert edge'' - flips the sensativity and is great for testing and fine tuning. ''alpha channel'' - use an alpha channel to replace original color with transparency. ''alpha_level'' - transparency amount modifier where 1.0 = base luminance  (recommend 0.00 - 2.00). ''alpha_invert'' - flip what is transparent from darks (default) to lights";

float4 mainImage(VertData v_in) : TARGET
{
	float4 c = image.Sample(textureSampler, v_in.uv);
	
	 float s = 3;
     float hstep = uv_pixel_interval.x;
     float vstep = uv_pixel_interval.y;
	
	float offsetx = (hstep * s) / 2.0;
	float offsety = (vstep * s) / 2.0;
	
	float4 lum = float4(0.30, 0.59, 0.11, 1 );
	float samples[9];
	
	int index = 0;
	for(int i = 0; i < s; i++){
		for(int j = 0; j < s; j++){
			samples[index] = dot(image.Sample(textureSampler, float2(v_in.uv.x + (i * hstep) - offsetx, v_in.uv.y + (j * vstep) - offsety )), lum);
			index++;
		}
	}
	
	float vert = samples[2] + samples[8] + (2 * samples[5]) - samples[0] - (2 * samples[3]) - samples[6];
	float hori = samples[6] + (2 * samples[7]) + samples[8] - samples[0] - (2 * samples[1]) - samples[2];
	float4 col;
	
	float o = ((vert * vert) + (hori * hori));
	bool isEdge = o > sensitivity;
	if(invert_edge){
		isEdge = !isEdge;
	}
	if(isEdge) {
		col = edge_color;
		if(edge_multiply){
			col *= c;
		}
	} else {
		col = non_edge_color;
		if(non_edge_multiply){
			col *= c;
		}
	}

	if (alpha_invert) {
		lum = 1.0 - lum;
	}

	if(alpha_channel){
		if (edge_multiply && isEdge) {
			return clamp(lerp(c, col, alpha_level), 0.0, 1.0);
		}
		else {
			// use max instead of multiply
			return clamp(lerp(c, float4(max(c.r, col.r), max(c.g, col.g), max(c.b, col.b), 1.0), alpha_level), 0.0, 1.0);
		}
	} else {
		// col.a = col.a * alpha_level;
		return col;
	}
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

