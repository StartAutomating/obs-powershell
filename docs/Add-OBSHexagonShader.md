Get-OBSHexagonShader
--------------------

### Synopsis

Get-OBSHexagonShader [[-HexColor] <string>] [[-AlphaPercent] <int>] [[-Quantity] <float>] [[-BorderWidth] <int>] [[-SpeedPercent] <int>] [[-DistortX] <float>] [[-DistortY] <float>] [[-OffsetX] <float>] [[-OffsetY] <float>] [[-Notes] <string>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-Blend] [-Equilateral] [-ZoomAnimate] [-Glitch] [-Force] [-PassThru] [-NoResponse] [<CommonParameters>]

---

### Description

---

### Parameters
#### **AlphaPercent**

|Type   |Required|Position|PipelineInput|Aliases      |
|-------|--------|--------|-------------|-------------|
|`[int]`|false   |1       |false        |Alpha_Percent|

#### **Blend**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **BorderWidth**

|Type   |Required|Position|PipelineInput|Aliases     |
|-------|--------|--------|-------------|------------|
|`[int]`|false   |3       |false        |Border_Width|

#### **DistortX**

|Type     |Required|Position|PipelineInput|Aliases  |
|---------|--------|--------|-------------|---------|
|`[float]`|false   |5       |false        |Distort_X|

#### **DistortY**

|Type     |Required|Position|PipelineInput|Aliases  |
|---------|--------|--------|-------------|---------|
|`[float]`|false   |6       |false        |Distort_Y|

#### **Equilateral**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **FilterName**

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[string]`|false   |11      |true (ByPropertyName)|

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **Glitch**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **HexColor**

|Type      |Required|Position|PipelineInput|Aliases  |
|----------|--------|--------|-------------|---------|
|`[string]`|false   |0       |false        |Hex_Color|

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **Notes**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[string]`|false   |9       |false        |

#### **OffsetX**

|Type     |Required|Position|PipelineInput|Aliases |
|---------|--------|--------|-------------|--------|
|`[float]`|false   |7       |false        |Offset_X|

#### **OffsetY**

|Type     |Required|Position|PipelineInput|Aliases |
|---------|--------|--------|-------------|--------|
|`[float]`|false   |8       |false        |Offset_Y|

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **Quantity**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[float]`|false   |2       |false        |

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[string]`|false   |12      |false        |ShaderContent|

#### **SourceName**

|Type      |Required|Position|PipelineInput        |Aliases      |
|----------|--------|--------|---------------------|-------------|
|`[string]`|false   |10      |true (ByPropertyName)|SceneItemName|

#### **SpeedPercent**

|Type   |Required|Position|PipelineInput|Aliases      |
|-------|--------|--------|-------------|-------------|
|`[int]`|false   |4       |false        |Speed_Percent|

#### **ZoomAnimate**

|Type      |Required|Position|PipelineInput|Aliases     |
|----------|--------|--------|-------------|------------|
|`[switch]`|false   |Named   |false        |Zoom_Animate|

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
{@{name=Get-OBSHexagonShader; CommonParameters=True; parameter=System.Object[]}}
```
