Get-OBSDisplacementMapShader
----------------------------

### Synopsis

Get-OBSDisplacementMapShader [[-DisplacementInfo] <string>] [[-DisplacementX] <float>] [[-DisplacementY] <float>] [[-MaskLayer] <string>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **DisplacementInfo**

|Type      |Required|Position|PipelineInput|Aliases          |
|----------|--------|--------|-------------|-----------------|
|`[string]`|false   |0       |false        |displacement_info|

#### **DisplacementX**

|Type     |Required|Position|PipelineInput|Aliases       |
|---------|--------|--------|-------------|--------------|
|`[float]`|false   |1       |false        |displacement_x|

#### **DisplacementY**

|Type     |Required|Position|PipelineInput|Aliases       |
|---------|--------|--------|-------------|--------------|
|`[float]`|false   |2       |false        |displacement_y|

#### **FilterName**

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[string]`|false   |5       |true (ByPropertyName)|

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **MaskLayer**

|Type      |Required|Position|PipelineInput|Aliases   |
|----------|--------|--------|-------------|----------|
|`[string]`|false   |3       |false        |mask_layer|

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
|`[string]`|false   |6       |false        |ShaderContent|

#### **SourceName**

|Type      |Required|Position|PipelineInput        |Aliases      |
|----------|--------|--------|---------------------|-------------|
|`[string]`|false   |4       |true (ByPropertyName)|SceneItemName|

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
{@{name=Get-OBSDisplacementMapShader; CommonParameters=True; parameter=System.Object[]}}
```
