Get-OBSRoundedRectPerSideShader
-------------------------------

### Synopsis
Get-OBSRoundedRectPerSideShader [[-CornerRadiusBottom] <int>] [[-CornerRadiusLeft] <int>] [[-CornerRadiusTop] <int>] [[-CornerRadiusRight] <int>] [[-BorderThickness] <int>] [[-BorderColor] <string>] [[-BorderAlphaStart] <float>] [[-BorderAlphaEnd] <float>] [[-AlphaCutOff] <float>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

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

#### **CornerRadiusBottom**

|Type   |Required|Position|PipelineInput|Aliases             |
|-------|--------|--------|-------------|--------------------|
|`[Int]`|false   |named   |False        |corner_radius_bottom|

#### **CornerRadiusLeft**

|Type   |Required|Position|PipelineInput|Aliases           |
|-------|--------|--------|-------------|------------------|
|`[Int]`|false   |named   |False        |corner_radius_left|

#### **CornerRadiusRight**

|Type   |Required|Position|PipelineInput|Aliases            |
|-------|--------|--------|-------------|-------------------|
|`[Int]`|false   |named   |False        |corner_radius_right|

#### **CornerRadiusTop**

|Type   |Required|Position|PipelineInput|Aliases          |
|-------|--------|--------|-------------|-----------------|
|`[Int]`|false   |named   |False        |corner_radius_top|

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
Get-OBSRoundedRectPerSideShader [[-CornerRadiusBottom] <Int>] [[-CornerRadiusLeft] <Int>] [[-CornerRadiusTop] <Int>] [[-CornerRadiusRight] <Int>] [[-BorderThickness] <Int>] [[-BorderColor] <String>] [[-BorderAlphaStart] <Float>] [[-BorderAlphaEnd] <Float>] [[-AlphaCutOff] <Float>] [[-SourceName] <String>] [[-FilterName] <String>] [[-ShaderText] <String>] [-Force <Switch>] [-PassThru <Switch>] [-NoResponse <Switch>] [-UseShaderTime <Switch>] [<CommonParameters>]
```
