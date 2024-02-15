Get-OBSDeadPixelFixerShader
---------------------------

### Synopsis

Get-OBSDeadPixelFixerShader [[-DeadPixelX] <int>] [[-DeadPixelY] <int>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **DeadPixelX**

|Type   |Required|Position|PipelineInput|Aliases     |
|-------|--------|--------|-------------|------------|
|`[int]`|false   |0       |false        |Dead_Pixel_X|

#### **DeadPixelY**

|Type   |Required|Position|PipelineInput|Aliases     |
|-------|--------|--------|-------------|------------|
|`[int]`|false   |1       |false        |Dead_Pixel_Y|

#### **FilterName**

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[string]`|false   |3       |true (ByPropertyName)|

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
|`[string]`|false   |4       |false        |ShaderContent|

#### **SourceName**

|Type      |Required|Position|PipelineInput        |Aliases      |
|----------|--------|--------|---------------------|-------------|
|`[string]`|false   |2       |true (ByPropertyName)|SceneItemName|

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
{@{name=Get-OBSDeadPixelFixerShader; CommonParameters=True; parameter=System.Object[]}}
```
