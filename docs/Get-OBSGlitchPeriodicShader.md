Get-OBSGlitchPeriodicShader
---------------------------

### Synopsis

Get-OBSGlitchPeriodicShader [[-PERI] <float>] [[-DURA] <float>] [[-AMPL] <float>] [[-SCRA] <float>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **AMPL**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[float]`|false   |2       |false        |

#### **DURA**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[float]`|false   |1       |false        |

#### **FilterName**

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[string]`|false   |5       |true (ByPropertyName)|

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **PERI**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[float]`|false   |0       |false        |

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **SCRA**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[float]`|false   |3       |false        |

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
{@{name=Get-OBSGlitchPeriodicShader; CommonParameters=True; parameter=System.Object[]}}
```
