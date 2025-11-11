Get-OBSCubeRotatingShader
-------------------------

### Synopsis

Get-OBSCubeRotatingShader [[-Images] <int>] [[-Speed] <float>] [[-Shadow] <float>] [[-OtherImage1] <string>] [[-OtherImage2] <string>] [[-OtherImage3] <string>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **FilterName**

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[string]`|false   |7       |true (ByPropertyName)|

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **Images**

|Type   |Required|Position|PipelineInput|
|-------|--------|--------|-------------|
|`[int]`|false   |0       |false        |

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **OtherImage1**

|Type      |Required|Position|PipelineInput|Aliases     |
|----------|--------|--------|-------------|------------|
|`[string]`|false   |3       |false        |other_image1|

#### **OtherImage2**

|Type      |Required|Position|PipelineInput|Aliases     |
|----------|--------|--------|-------------|------------|
|`[string]`|false   |4       |false        |other_image2|

#### **OtherImage3**

|Type      |Required|Position|PipelineInput|Aliases     |
|----------|--------|--------|-------------|------------|
|`[string]`|false   |5       |false        |other_image3|

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[string]`|false   |8       |false        |ShaderContent|

#### **Shadow**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[float]`|false   |2       |false        |

#### **SourceName**

|Type      |Required|Position|PipelineInput        |Aliases      |
|----------|--------|--------|---------------------|-------------|
|`[string]`|false   |6       |true (ByPropertyName)|SceneItemName|

#### **Speed**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[float]`|false   |1       |false        |

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
{@{name=Get-OBSCubeRotatingShader; CommonParameters=True; parameter=System.Object[]}}
```
