Get-OBSFillColorRadialPercentageShader
--------------------------------------

### Synopsis

Get-OBSFillColorRadialPercentageShader [[-FillDirection] <int>] [[-Fill] <float>] [[-StartAngle] <float>] [[-OffsetX] <float>] [[-OffsetY] <float>] [[-FillColor] <string>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-Force] [-PassThru] [-NoResponse] [<CommonParameters>]

---

### Description

---

### Parameters
#### **Fill**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[float]`|false   |1       |false        |

#### **FillColor**

|Type      |Required|Position|PipelineInput|Aliases   |
|----------|--------|--------|-------------|----------|
|`[string]`|false   |5       |false        |Fill_Color|

#### **FillDirection**

|Type   |Required|Position|PipelineInput|Aliases       |
|-------|--------|--------|-------------|--------------|
|`[int]`|false   |0       |false        |Fill_Direction|

#### **FilterName**

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[string]`|false   |7       |true (ByPropertyName)|

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **OffsetX**

|Type     |Required|Position|PipelineInput|Aliases |
|---------|--------|--------|-------------|--------|
|`[float]`|false   |3       |false        |Offset_X|

#### **OffsetY**

|Type     |Required|Position|PipelineInput|Aliases |
|---------|--------|--------|-------------|--------|
|`[float]`|false   |4       |false        |Offset_Y|

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[string]`|false   |8       |false        |ShaderContent|

#### **SourceName**

|Type      |Required|Position|PipelineInput        |Aliases      |
|----------|--------|--------|---------------------|-------------|
|`[string]`|false   |6       |true (ByPropertyName)|SceneItemName|

#### **StartAngle**

|Type     |Required|Position|PipelineInput|Aliases    |
|---------|--------|--------|-------------|-----------|
|`[float]`|false   |2       |false        |Start_Angle|

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
{@{name=Get-OBSFillColorRadialPercentageShader; CommonParameters=True; parameter=System.Object[]}}
```
