Get-OBSCircleMaskFilterShader
-----------------------------

### Synopsis

Get-OBSCircleMaskFilterShader [[-Radius] <float>] [[-CircleOffsetX] <int>] [[-CircleOffsetY] <int>] [[-SourceOffsetX] <int>] [[-SourceOffsetY] <int>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-Antialiasing] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **Antialiasing**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **CircleOffsetX**

|Type   |Required|Position|PipelineInput|Aliases        |
|-------|--------|--------|-------------|---------------|
|`[int]`|false   |1       |false        |Circle_Offset_X|

#### **CircleOffsetY**

|Type   |Required|Position|PipelineInput|Aliases        |
|-------|--------|--------|-------------|---------------|
|`[int]`|false   |2       |false        |Circle_Offset_Y|

#### **FilterName**

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[string]`|false   |6       |true (ByPropertyName)|

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

#### **Radius**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[float]`|false   |0       |false        |

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[string]`|false   |7       |false        |ShaderContent|

#### **SourceName**

|Type      |Required|Position|PipelineInput        |Aliases      |
|----------|--------|--------|---------------------|-------------|
|`[string]`|false   |5       |true (ByPropertyName)|SceneItemName|

#### **SourceOffsetX**

|Type   |Required|Position|PipelineInput|Aliases        |
|-------|--------|--------|-------------|---------------|
|`[int]`|false   |3       |false        |Source_Offset_X|

#### **SourceOffsetY**

|Type   |Required|Position|PipelineInput|Aliases        |
|-------|--------|--------|-------------|---------------|
|`[int]`|false   |4       |false        |Source_Offset_Y|

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
{@{name=Get-OBSCircleMaskFilterShader; CommonParameters=True; parameter=System.Object[]}}
```
