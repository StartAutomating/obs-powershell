function Get-OBSTvCrtSubpixelShader {

[Alias('Set-OBSTvCrtSubpixelShader','Add-OBSTvCrtSubpixelShader')]
param(
# Set the channelWidth of OBSTvCrtSubpixelShader
[ComponentModel.DefaultBindingProperty('channelWidth')]
[Int32]
$ChannelWidth,
# Set the channelHeight of OBSTvCrtSubpixelShader
[ComponentModel.DefaultBindingProperty('channelHeight')]
[Int32]
$ChannelHeight,
# Set the hGap of OBSTvCrtSubpixelShader
[ComponentModel.DefaultBindingProperty('hGap')]
[Int32]
$HGap,
# Set the vGap of OBSTvCrtSubpixelShader
[ComponentModel.DefaultBindingProperty('vGap')]
[Int32]
$VGap,
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
$shaderName = 'tv-crt-subpixel'
$ShaderNoun = 'OBSTvCrtSubpixelShader'
if (-not $psBoundParameters['ShaderText']) {    
    $psBoundParameters['ShaderText'] = $ShaderText = '
// https://www.shadertoy.com/view/dlBBz1 adopted for OBS by Exeldro

// width of a single color channel in pixels
uniform int channelWidth<
    string label = "Channel Width";
    string widget_type = "slider";
    int minimum = 1;
    int maximum = 20;
    int step = 1;
> = 1;

// height of color channels in pixels
uniform int channelHeight<
    string label = "Channel Height";
    string widget_type = "slider";
    int minimum = 1;
    int maximum = 20;
    int step = 1;
> = 3;

// horizontal distance between two neighboring pixels
uniform int hGap<
    string label = "Horizontal Gap";
    string widget_type = "slider";
    int minimum = 1;
    int maximum = 20;
    int step = 1;
> = 1;

// vertical distance between two neighboring pixels
uniform int vGap<
    string label = "Vertical Gap";
    string widget_type = "slider";
    int minimum = 1;
    int maximum = 20;
    int step = 1;
> = 1;

float4 mainImage(VertData v_in) : TARGET
{
    float columns = float(channelWidth * 3 + hGap);
    float pixelHeight = float(channelHeight + vGap);

    float2 fragCoord = v_in.uv * uv_size;
    float2 sampleRes = float2(uv_size.x / columns, uv_size.y / pixelHeight);
    float2 pixel = float2(floor(fragCoord.x / columns), floor(fragCoord.y / pixelHeight));
    float2 sampleUv = pixel / sampleRes;

    // color of sample point
    float4 col = image.Sample(textureSampler, sampleUv);
    
    int column = int(fragCoord.x) % (channelWidth * 3 + hGap);

    // set color based on which channel this fragment corresponds to
    if (column < channelWidth * 1) col = float4(col.r, 0.0, 0.0, col.a);
    else if (column < channelWidth * 2) col = float4(0.0, col.g, 0.0, col.a);
    else if (column < channelWidth * 3) col = float4(0.0, 0.0, col.b, col.a);
    else col = float4(0.0, 0.0, 0.0, col.a);

    // offset every other column of pixels
    int height = int(pixelHeight);
    if (int(pixel.x) % 2 == 0) {
        if (int(fragCoord.y) % height >= height - vGap) col = float4(0.0, 0.0, 0.0, col.a);
    } else {
        if (int(fragCoord.y) % height < vGap) col = float4(0.0, 0.0, 0.0, col.a);
    }

    // Output to screen
    return col;
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

