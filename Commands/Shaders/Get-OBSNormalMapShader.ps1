function Get-OBSNormalMapShader {

[Alias('Set-OBSNormalMapShader','Add-OBSNormalMapShader')]
param(
# Set the strength of OBSNormalMapShader
[ComponentModel.DefaultBindingProperty('strength')]
[Single]
$Strength,
# Set the offsetHeight of OBSNormalMapShader
[ComponentModel.DefaultBindingProperty('offsetHeight')]
[Management.Automation.SwitchParameter]
$OffsetHeight,
# Set the invertR of OBSNormalMapShader
[ComponentModel.DefaultBindingProperty('invertR')]
[Management.Automation.SwitchParameter]
$InvertR,
# Set the invertG of OBSNormalMapShader
[ComponentModel.DefaultBindingProperty('invertG')]
[Management.Automation.SwitchParameter]
$InvertG,
# Set the invertH of OBSNormalMapShader
[ComponentModel.DefaultBindingProperty('invertH')]
[Management.Automation.SwitchParameter]
$InvertH,
# Set the type of OBSNormalMapShader
[ComponentModel.DefaultBindingProperty('type')]
[Int32]
$Type,
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
$shaderName = 'normal_map'
$ShaderNoun = 'OBSNormalMapShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// Normal map shader based on cpetry''s NormalMap-Online website
// https://github.com/cpetry/NormalMap-Online/blob/gh-pages/javascripts/shader/NormalMapShader.js

uniform float strength<
  string label = "Strength";
  string widget_type = "slider";
  float minimum = 0.001;
  float maximum = 10;
  float step = 0.001;
> = 1;

uniform bool offsetHeight = true;
uniform bool invertR = false;
uniform bool invertG = false;
uniform bool invertH = false;

uniform int type<
  string label = "Filter Type";
  string widget_type = "select";
  int    option_0_value = 0;
  string option_0_label = "Sobel";
  int    option_1_value = 1;
  string option_1_label = "Scharr";
> = 0;

float4 mainImage( VertData v_in ) : TARGET {
  float2 step = float2(1.0, 1.0) / uv_size;
  float2 vUv = v_in.uv;

  float dz = 1 / strength;
  float dz2 = dz * dz;

  float2 tlv = float2(vUv.x - step.x, vUv.y + step.y);
  float2 lv  = float2(vUv.x - step.x, vUv.y 	  	  );
  float2 blv = float2(vUv.x - step.x, vUv.y - step.y);
  float2 tv  = float2(vUv.x 		    , vUv.y + step.y);
  float2 bv  = float2(vUv.x 		    , vUv.y - step.y);
  float2 trv = float2(vUv.x + step.x, vUv.y + step.y);
  float2 rv  = float2(vUv.x + step.x, vUv.y 		    );
  float2 brv = float2(vUv.x + step.x, vUv.y - step.y);

  tlv = float2(tlv.x >= 0.0 ? tlv.x : (1.0 + tlv.x),  	tlv.y >= 0.0	? tlv.y : (1.0  + tlv.y));
  tlv = float2(tlv.x < 1.0  ? tlv.x : (tlv.x - 1.0 ), 	tlv.y < 1.0   ? tlv.y : (tlv.y - 1.0 ));
  lv  = float2( lv.x >= 0.0 ?  lv.x : (1.0 + lv.x),   	lv.y  >= 0.0 	?  lv.y : (1.0  +  lv.y));
  lv  = float2( lv.x < 1.0  ?  lv.x : ( lv.x - 1.0 ),   lv.y  < 1.0  	?  lv.y : ( lv.y - 1.0 ));
  blv = float2(blv.x >= 0.0 ? blv.x : (1.0 + blv.x),  	blv.y >= 0.0 	? blv.y : (1.0  + blv.y));
  blv = float2(blv.x < 1.0  ? blv.x : (blv.x - 1.0 ), 	blv.y < 1.0 	? blv.y : (blv.y - 1.0 ));
  tv  = float2( tv.x >= 0.0 ?  tv.x : (1.0 + tv.x),   	tv.y  >= 0.0 	?  tv.y : (1.0  +  tv.y));
  tv  = float2( tv.x < 1.0  ?  tv.x : ( tv.x - 1.0 ),   tv.y  < 1.0 	?  tv.y : ( tv.y - 1.0 ));
  bv  = float2( bv.x >= 0.0 ?  bv.x : (1.0 + bv.x),   	bv.y  >= 0.0 	?  bv.y : (1.0  +  bv.y));
  bv  = float2( bv.x < 1.0  ?  bv.x : ( bv.x - 1.0 ),   bv.y  < 1.0 	?  bv.y : ( bv.y - 1.0 ));
  trv = float2(trv.x >= 0.0 ? trv.x : (1.0 + trv.x),  	trv.y >= 0.0 	? trv.y : (1.0  + trv.y));
  trv = float2(trv.x < 1.0  ? trv.x : (trv.x - 1.0 ), 	trv.y < 1.0   ? trv.y : (trv.y - 1.0 ));
  rv  = float2( rv.x >= 0.0 ?  rv.x : (1.0 + rv.x),   	rv.y  >= 0.0 	?  rv.y : (1.0  +  rv.y));
  rv  = float2( rv.x < 1.0  ?  rv.x : ( rv.x - 1.0 ),   rv.y  < 1.0   ?  rv.y : ( rv.y - 1.0 ));
  brv = float2(brv.x >= 0.0 ? brv.x : (1.0 + brv.x),  	brv.y >= 0.0 	? brv.y : (1.0  + brv.y));
  brv = float2(brv.x < 1.0  ? brv.x : (brv.x - 1.0 ), 	brv.y < 1.0   ? brv.y : (brv.y - 1.0 ));

  float tl = image.Sample(textureSampler, tlv).r;
  float l  = image.Sample(textureSampler, lv ).r;
  float bl = image.Sample(textureSampler, blv).r;	
  float t  = image.Sample(textureSampler, tv ).r; 
  float b  = image.Sample(textureSampler, bv ).r;
  float tr = image.Sample(textureSampler, trv).r; 
  float r  = image.Sample(textureSampler, rv ).r;
  float br = image.Sample(textureSampler, brv).r;

  float dx = 0.0;
  float dy = 0.0;

  if(type == 0) {	// Sobel
    dx = tl + l*2.0 + bl - tr - r*2.0 - br;
    dy = tl + t*2.0 + tr - bl - b*2.0 - br;
  }
  else { // Scharr
    dx = tl*3.0 + l*10.0 + bl*3.0 - tr*3.0 - r*10.0 - br*3.0;
    dy = tl*3.0 + t*10.0 + tr*3.0 - bl*3.0 - b*10.0 - br*3.0;
  }

  float invH = invertH ? -1. : 1.;
  float invR = invertR ? -1. : 1.;
  float invG = invertG ? -1. : 1.;

  float4 normal = float4(
    float3(dx * invR * invH, dy * invG * invH, dz),
    image.Sample(textureSampler, vUv).a
  );

  l = sqrt((dx * dx) + (dy * dy) + dz2);

  if (offsetHeight) {
    return float4(normal.xy / l * 0.5 + 0.5, normal.zw);
  }

  return float4(normal.xyz / l * 0.5 + 0.5, normal.w);
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

