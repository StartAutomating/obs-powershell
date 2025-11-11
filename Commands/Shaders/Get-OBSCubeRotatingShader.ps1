function Get-OBSCubeRotatingShader {

[Alias('Set-OBSCubeRotatingShader','Add-OBSCubeRotatingShader')]
param(
# Set the images of OBSCubeRotatingShader
[ComponentModel.DefaultBindingProperty('images')]
[Int32]
$Images,
# Set the speed of OBSCubeRotatingShader
[ComponentModel.DefaultBindingProperty('speed')]
[Single]
$Speed,
# Set the shadow of OBSCubeRotatingShader
[ComponentModel.DefaultBindingProperty('shadow')]
[Single]
$Shadow,
# Set the other_image1 of OBSCubeRotatingShader
[Alias('other_image1')]
[ComponentModel.DefaultBindingProperty('other_image1')]
[String]
$OtherImage1,
# Set the other_image2 of OBSCubeRotatingShader
[Alias('other_image2')]
[ComponentModel.DefaultBindingProperty('other_image2')]
[String]
$OtherImage2,
# Set the other_image3 of OBSCubeRotatingShader
[Alias('other_image3')]
[ComponentModel.DefaultBindingProperty('other_image3')]
[String]
$OtherImage3,
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
$shaderName = 'cube_rotating'
$ShaderNoun = 'OBSCubeRotatingShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
uniform int images<
  string label = "Images";
  string widget_type = "select";
  int    option_0_value = 1;
  string option_0_label = "1";
  int    option_1_value = 2;
  string option_1_label = "2";
  int    option_2_value = 4;
  string option_2_label = "4";
> = 1;

uniform float speed<
    string label = "Speed";
    string widget_type = "slider";
    float minimum = -5.0;
    float maximum = 5.0;
    float step = 0.001;
> = 0.5;

uniform float shadow<
    string label = "Shadow";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 2.5;
    float step = 0.001;
> = 1.0;

uniform texture2d other_image1;
uniform texture2d other_image2;
uniform texture2d other_image3;

#define PI 3.14159265359
float4 mainImage(VertData v_in) : TARGET
{
	float t = elapsed_time * speed;
	float4 c = float4(0,0,0,0);
	for(float side = 0.0; side<4.0; side += 1.0){
		float left = cos(t+((side*0.5-0.25)*PI))/2+0.5;
		float right = cos(t+((side*0.5+0.25)*PI))/2+0.5;
		if(left < right){
			float2 uv;
			uv.x = (v_in.uv.x-left)/(right-left);
			float left_size = 1.0 +sin(t+((side*0.5-0.25)*PI))/2+0.5;
			float right_size = 1.0 + sin(t+((side*0.5+0.25)*PI))/2+0.5;
			float size = (uv.x * right_size) + ((1.0-uv.x) * left_size);
			uv.y = (v_in.uv.y-0.5)*size+0.5;
			float4 sample = float4(0,0,0,0);
			if(images <= 1 || side == 0.0){
				sample = image.Sample(textureSampler, uv);
			}else if(images == 2){
				if(side == 1.0 || side == 3.0){
					sample = other_image1.Sample(textureSampler, uv);
				}else{
					sample = image.Sample(textureSampler, uv);
				}
			}else if(images == 4){
				if(side == 1.0){
					sample = other_image1.Sample(textureSampler, uv);
				}else if(side == 2.0){
					sample = other_image2.Sample(textureSampler, uv);
				}else if(side == 3.0){
					sample = other_image3.Sample(textureSampler, uv);
				}else{
					sample = image.Sample(textureSampler, uv);
				}
			}
			if(sample.a > 0.0){
				c += float4(sample.rgb*(1.0-abs((left+right)/2.0-0.5)*shadow),sample.a);
			}
		}
	}
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

