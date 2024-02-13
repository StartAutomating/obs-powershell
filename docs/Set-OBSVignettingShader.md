Get-OBSVignettingShader
-----------------------

### Synopsis

Get-OBSVignettingShader [[-InnerRadius] <float>] [[-OuterRadius] <float>] [[-Opacity] <float>] [[-Notes] <string>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-PassThru] [-NoResponse] [<CommonParameters>]

---

### Description

---

### Parameters
#### **FilterName**

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[string]`|false   |5       |true (ByPropertyName)|

#### **InnerRadius**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[float]`|false   |0       |false        |

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **Notes**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[string]`|false   |3       |false        |

#### **Opacity**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[float]`|false   |2       |false        |

#### **OuterRadius**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[float]`|false   |1       |false        |

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
{@{name=Get-OBSVignettingShader; CommonParameters=True; parameter=System.Object[]}}
```
