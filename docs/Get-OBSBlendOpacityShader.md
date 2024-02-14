Get-OBSBlendOpacityShader
-------------------------

### Synopsis

Get-OBSBlendOpacityShader [[-RotationOffset] <float>] [[-OpacityStartPercent] <float>] [[-OpacityEndPercent] <float>] [[-Spread] <float>] [[-Speed] <float>] [[-Notes] <string>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-Vertical] [-Rotational] [-ApplyToAlphaLayer] [-Force] [-PassThru] [-NoResponse] [<CommonParameters>]

---

### Description

---

### Parameters
#### **ApplyToAlphaLayer**

|Type      |Required|Position|PipelineInput|Aliases             |
|----------|--------|--------|-------------|--------------------|
|`[switch]`|false   |Named   |false        |Apply_To_Alpha_Layer|

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

#### **Notes**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[string]`|false   |5       |false        |

#### **OpacityEndPercent**

|Type     |Required|Position|PipelineInput|Aliases            |
|---------|--------|--------|-------------|-------------------|
|`[float]`|false   |2       |false        |Opacity_End_Percent|

#### **OpacityStartPercent**

|Type     |Required|Position|PipelineInput|Aliases              |
|---------|--------|--------|-------------|---------------------|
|`[float]`|false   |1       |false        |Opacity_Start_Percent|

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **RotationOffset**

|Type     |Required|Position|PipelineInput|Aliases        |
|---------|--------|--------|-------------|---------------|
|`[float]`|false   |0       |false        |Rotation_Offset|

#### **Rotational**

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

#### **Speed**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[float]`|false   |4       |false        |

#### **Spread**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[float]`|false   |3       |false        |

#### **Vertical**

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
{@{name=Get-OBSBlendOpacityShader; CommonParameters=True; parameter=System.Object[]}}
```
