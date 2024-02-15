Get-OBSRoundedStrokeGradientShader
----------------------------------

### Synopsis

Get-OBSRoundedStrokeGradientShader [[-CornerRadius] <int>] [[-BorderThickness] <int>] [[-MinimumAlphaPercent] <int>] [[-RotationSpeed] <int>] [[-BorderColorL] <string>] [[-BorderColorR] <string>] [[-CenterWidth] <int>] [[-CenterHeight] <int>] [[-Notes] <string>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **BorderColorL**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[string]`|false   |4       |false        |border_colorL|

#### **BorderColorR**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[string]`|false   |5       |false        |border_colorR|

#### **BorderThickness**

|Type   |Required|Position|PipelineInput|Aliases         |
|-------|--------|--------|-------------|----------------|
|`[int]`|false   |1       |false        |border_thickness|

#### **CenterHeight**

|Type   |Required|Position|PipelineInput|Aliases      |
|-------|--------|--------|-------------|-------------|
|`[int]`|false   |7       |false        |center_height|

#### **CenterWidth**

|Type   |Required|Position|PipelineInput|Aliases     |
|-------|--------|--------|-------------|------------|
|`[int]`|false   |6       |false        |center_width|

#### **CornerRadius**

|Type   |Required|Position|PipelineInput|Aliases      |
|-------|--------|--------|-------------|-------------|
|`[int]`|false   |0       |false        |corner_radius|

#### **FilterName**

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[string]`|false   |10      |true (ByPropertyName)|

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **MinimumAlphaPercent**

|Type   |Required|Position|PipelineInput|Aliases              |
|-------|--------|--------|-------------|---------------------|
|`[int]`|false   |2       |false        |minimum_alpha_percent|

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **Notes**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[string]`|false   |8       |false        |

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **RotationSpeed**

|Type   |Required|Position|PipelineInput|Aliases       |
|-------|--------|--------|-------------|--------------|
|`[int]`|false   |3       |false        |rotation_speed|

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
{@{name=Get-OBSRoundedStrokeGradientShader; CommonParameters=True; parameter=System.Object[]}}
```
