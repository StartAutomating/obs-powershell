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
|`[float]`|false   |8       |false        |alpha_cut_off|

#### **BorderAlphaEnd**

|Type     |Required|Position|PipelineInput|Aliases         |
|---------|--------|--------|-------------|----------------|
|`[float]`|false   |7       |false        |border_alpha_end|

#### **BorderAlphaStart**

|Type     |Required|Position|PipelineInput|Aliases           |
|---------|--------|--------|-------------|------------------|
|`[float]`|false   |6       |false        |border_alpha_start|

#### **BorderColor**

|Type      |Required|Position|PipelineInput|Aliases     |
|----------|--------|--------|-------------|------------|
|`[string]`|false   |5       |false        |border_color|

#### **BorderThickness**

|Type   |Required|Position|PipelineInput|Aliases         |
|-------|--------|--------|-------------|----------------|
|`[int]`|false   |4       |false        |border_thickness|

#### **CornerRadiusBottom**

|Type   |Required|Position|PipelineInput|Aliases             |
|-------|--------|--------|-------------|--------------------|
|`[int]`|false   |0       |false        |corner_radius_bottom|

#### **CornerRadiusLeft**

|Type   |Required|Position|PipelineInput|Aliases           |
|-------|--------|--------|-------------|------------------|
|`[int]`|false   |1       |false        |corner_radius_left|

#### **CornerRadiusRight**

|Type   |Required|Position|PipelineInput|Aliases            |
|-------|--------|--------|-------------|-------------------|
|`[int]`|false   |3       |false        |corner_radius_right|

#### **CornerRadiusTop**

|Type   |Required|Position|PipelineInput|Aliases          |
|-------|--------|--------|-------------|-----------------|
|`[int]`|false   |2       |false        |corner_radius_top|

#### **FilterName**

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[string]`|false   |10      |true (ByPropertyName)|

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[string]`|false   |11      |false        |ShaderContent|

#### **SourceName**

|Type      |Required|Position|PipelineInput        |Aliases      |
|----------|--------|--------|---------------------|-------------|
|`[string]`|false   |9       |true (ByPropertyName)|SceneItemName|

#### **UseShaderTime**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

---

### Inputs
System.String

---

### Outputs
* [Object](https://learn.microsoft.com/en-us/dotnet/api/System.Object)

---

### Syntax
```PowerShell
syntaxItem
```
```PowerShell
----------
```
```PowerShell
{@{name=Get-OBSRoundedRectPerSideShader; CommonParameters=True; parameter=System.Object[]}}
```
