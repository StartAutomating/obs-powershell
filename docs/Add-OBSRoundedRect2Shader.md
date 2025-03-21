Get-OBSRoundedRect2Shader
-------------------------

### Synopsis
Get-OBSRoundedRect2Shader [[-CornerRadius] <int>] [[-BorderThickness] <int>] [[-BorderColor] <string>] [[-BorderAlphaStart] <float>] [[-BorderAlphaEnd] <float>] [[-AlphaCutOff] <float>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-FasterScan] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **AlphaCutOff**

|Type     |Required|Position|PipelineInput|Aliases      |
|---------|--------|--------|-------------|-------------|
|`[Float]`|false   |named   |False        |alpha_cut_off|

#### **BorderAlphaEnd**

|Type     |Required|Position|PipelineInput|Aliases         |
|---------|--------|--------|-------------|----------------|
|`[Float]`|false   |named   |False        |border_alpha_end|

#### **BorderAlphaStart**

|Type     |Required|Position|PipelineInput|Aliases           |
|---------|--------|--------|-------------|------------------|
|`[Float]`|false   |named   |False        |border_alpha_start|

#### **BorderColor**

|Type      |Required|Position|PipelineInput|Aliases     |
|----------|--------|--------|-------------|------------|
|`[String]`|false   |named   |False        |border_color|

#### **BorderThickness**

|Type   |Required|Position|PipelineInput|Aliases         |
|-------|--------|--------|-------------|----------------|
|`[Int]`|false   |named   |False        |border_thickness|

#### **CornerRadius**

|Type   |Required|Position|PipelineInput|Aliases      |
|-------|--------|--------|-------------|-------------|
|`[Int]`|false   |named   |False        |corner_radius|

#### **FasterScan**

|Type      |Required|Position|PipelineInput|Aliases    |
|----------|--------|--------|-------------|-----------|
|`[Switch]`|false   |named   |False        |faster_scan|

#### **FilterName**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |False        |

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

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
Get-OBSRoundedRect2Shader [[-CornerRadius] <Int>] [[-BorderThickness] <Int>] [[-BorderColor] <String>] [[-BorderAlphaStart] <Float>] [[-BorderAlphaEnd] <Float>] [[-AlphaCutOff] <Float>] [-FasterScan <Switch>] [[-SourceName] <String>] [[-FilterName] <String>] [[-ShaderText] <String>] [-Force <Switch>] [-PassThru <Switch>] [-NoResponse <Switch>] [-UseShaderTime <Switch>] [<CommonParameters>]
```
