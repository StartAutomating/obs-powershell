function Get-OBSRotatingSourceShader {

[Alias('Set-OBSRotatingSourceShader','Add-OBSRotatingSourceShader')]
param(
# Set the spin_speed of OBSRotatingSourceShader
[Alias('spin_speed')]
[ComponentModel.DefaultBindingProperty('spin_speed')]
[Single]
$SpinSpeed,
# Set the rotation of OBSRotatingSourceShader
[ComponentModel.DefaultBindingProperty('rotation')]
[Single]
$Rotation,
# Set the zoomin of OBSRotatingSourceShader
[ComponentModel.DefaultBindingProperty('zoomin')]
[Single]
$Zoomin,
# Set the keep_aspectratio of OBSRotatingSourceShader
[Alias('keep_aspectratio')]
[ComponentModel.DefaultBindingProperty('keep_aspectratio')]
[Management.Automation.SwitchParameter]
$KeepAspectratio,
# Set the x_center of OBSRotatingSourceShader
[Alias('x_center')]
[ComponentModel.DefaultBindingProperty('x_center')]
[Single]
$XCenter,
# Set the y_center of OBSRotatingSourceShader
[Alias('y_center')]
[ComponentModel.DefaultBindingProperty('y_center')]
[Single]
$YCenter,
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
$shaderName = 'rotating-source'
$ShaderNoun = 'OBSRotatingSourceShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
//spin speed higher the slower
uniform float spin_speed<
    string label = "Spin Speed";
    string widget_type = "slider";
    float minimum = -10.0;
    float maximum = 10.0;
    float step = 0.001;
> = 1.0;
uniform float rotation<
    string label = "Rotation";
    string widget_type = "slider";
    float minimum = -360.0;
    float maximum = 360.0;
    float step = 0.1;
> = 0.0;
uniform float zoomin<
    string label = "Zoom";
    string widget_type = "slider";
    float minimum = 0.01;
    float maximum = 10.0;
    float step = 0.01;
> = 1.0;
uniform bool keep_aspectratio = true;
uniform float x_center<
    string label = "Center x";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.5;
uniform float y_center<
    string label = "Center y";
    string widget_type = "slider";
    float minimum = 0.0;
    float maximum = 1.0;
    float step = 0.001;
> = 0.5;


//main fragment code
//from lioran to nutella with love
float4 mainImage(VertData v_in) : TARGET
{
    float x_aspectratio = keep_aspectratio ? uv_size.x : 1.0;
    float y_aspectratio = keep_aspectratio ? uv_size.y : 1.0;
    //get position on of the texture and focus on the middle
    float i_rotation;
    if (spin_speed == 0){
        //turn angle number into pi number
        i_rotation = rotation/57.295779513;
    }else{
        //use elapsed time for spinning if spin speed is not 0
        i_rotation = elapsed_time * spin_speed;
    }
    float2 i_point;
    i_point.x = (v_in.uv.x * x_aspectratio) - (x_aspectratio * x_center);
    i_point.y = (v_in.uv.y * y_aspectratio) - (y_aspectratio * y_center);
        
    //get the angle from center , returns pi number
    float i_dir = atan(i_point.y/i_point.x);
    if(i_point.x < 0.0){
        i_dir += 3.14159265359;
    }
        
    //get the distance from the centers
    float i_distance = sqrt(pow(i_point.x,2) + pow(i_point.y,2));
    //multiple distance by the zoomin value
    i_distance *= zoomin;
        
    //shift the texture position based on angle and distance from the middle
    i_point.x = ((x_aspectratio*x_center)+cos(i_dir-i_rotation)*i_distance)/x_aspectratio;
    i_point.y = ((y_aspectratio*y_center)+sin(i_dir-i_rotation)*i_distance)/y_aspectratio;
            
    //draw normally from new point
    return image.Sample(textureSampler, i_point);
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

