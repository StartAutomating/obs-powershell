Set-OBSShaderFilter
-------------------

### Synopsis
Sets a Shader filter.

---

### Description

Adds or Changes a Shader Filter on an OBS Input.    
This requires that the [OBS Shader Filter](https://github.com/exeldro/obs-shaderfilter) is installed.

---

### Examples
> EXAMPLE 1

```PowerShell
Show-OBS -Uri https://pssvg.start-automating.com/Examples/Stars.svg |    
    Set-OBSShaderFilter -FilterName "Shader" -ShaderFile fisheye-xy -ShaderSetting @{    
        center_x_percent=30    
        center_y_percent=70    
    }
```

---

### Parameters
#### **ShaderText**
The text of the shader

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |1       |true (ByPropertyName)|

#### **ShaderFile**
The file path to the shader, or the short file name of the shader.

|Type      |Required|Position|PipelineInput        |Aliases   |
|----------|--------|--------|---------------------|----------|
|`[String]`|false   |2       |true (ByPropertyName)|ShaderName|

#### **ShaderSetting**
Any other settings for the shader.    
To see what the name of a shader setting is, change it in the user interface and then get the input's filters.

|Type        |Required|Position|PipelineInput        |Aliases       |
|------------|--------|--------|---------------------|--------------|
|`[PSObject]`|false   |3       |true (ByPropertyName)|ShaderSettings|

#### **Force**
If set, will remove a filter if one already exists.    
If this is not provided and the filter already exists, the settings of the filter will be changed.

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |

---

### Syntax
```PowerShell
Set-OBSShaderFilter [[-ShaderText] <String>] [[-ShaderFile] <String>] [[-ShaderSetting] <PSObject>] [-Force] [<CommonParameters>]
```
