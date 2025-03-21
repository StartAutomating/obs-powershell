Get-OBSFrostedGlassShader
-------------------------

### Synopsis
Get-OBSFrostedGlassShader [[-AlphaPercent] <float>] [[-Amount] <float>] [[-Scale] <float>] [[-BorderOffset] <float>] [[-BorderColor] <string>] [[-Notes] <string>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-Animate] [-HorizontalBorder] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **AlphaPercent**

|Type     |Required|Position|PipelineInput|Aliases      |
|---------|--------|--------|-------------|-------------|
|`[Float]`|false   |named   |False        |Alpha_Percent|

#### **Amount**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[Float]`|false   |named   |False        |

#### **Animate**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **BorderColor**

|Type      |Required|Position|PipelineInput|Aliases     |
|----------|--------|--------|-------------|------------|
|`[String]`|false   |named   |False        |Border_Color|

#### **BorderOffset**

|Type     |Required|Position|PipelineInput|Aliases      |
|---------|--------|--------|-------------|-------------|
|`[Float]`|false   |named   |False        |Border_Offset|

#### **FilterName**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |False        |

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **HorizontalBorder**

|Type      |Required|Position|PipelineInput|Aliases          |
|----------|--------|--------|-------------|-----------------|
|`[Switch]`|false   |named   |False        |Horizontal_Border|

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **Notes**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |False        |

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **Scale**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[Float]`|false   |named   |False        |

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[String]`|false   |named   |False        |ShaderContent|

#### **SourceName**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[String]`|false   |named   |False        |SceneItemName|

#### **UseShaderTime**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

---

### Inputs
System.String

---

### Outputs
* [Object](https://learn.microsoft.com/en-us/dotnet/api/System.Object)

---

### Syntax
```PowerShell
Get-OBSFrostedGlassShader [[-AlphaPercent] <Float>] [[-Amount] <Float>] [[-Scale] <Float>] [-Animate <Switch>] [-HorizontalBorder <Switch>] [[-BorderOffset] <Float>] [[-BorderColor] <String>] [[-Notes] <String>] [[-SourceName] <String>] [[-FilterName] <String>] [[-ShaderText] <String>] [-Force <Switch>] [-PassThru <Switch>] [-NoResponse <Switch>] [-UseShaderTime <Switch>] [<CommonParameters>]
```
