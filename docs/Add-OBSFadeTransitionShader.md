Get-OBSFadeTransitionShader
---------------------------

### Synopsis

Get-OBSFadeTransitionShader [[-ImageA] <string>] [[-ImageB] <string>] [[-TransitionTime] <float>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-ConvertLinear] [-PassThru] [-NoResponse] [<CommonParameters>]

---

### Description

---

### Parameters
#### **ConvertLinear**

|Type      |Required|Position|PipelineInput|Aliases       |
|----------|--------|--------|-------------|--------------|
|`[switch]`|false   |Named   |false        |convert_linear|

#### **FilterName**

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[string]`|false   |4       |true (ByPropertyName)|

#### **ImageA**

|Type      |Required|Position|PipelineInput|Aliases|
|----------|--------|--------|-------------|-------|
|`[string]`|false   |0       |false        |image_a|

#### **ImageB**

|Type      |Required|Position|PipelineInput|Aliases|
|----------|--------|--------|-------------|-------|
|`[string]`|false   |1       |false        |image_b|

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
|`[string]`|false   |5       |false        |ShaderContent|

#### **SourceName**

|Type      |Required|Position|PipelineInput        |Aliases      |
|----------|--------|--------|---------------------|-------------|
|`[string]`|false   |3       |true (ByPropertyName)|SceneItemName|

#### **TransitionTime**

|Type     |Required|Position|PipelineInput|Aliases        |
|---------|--------|--------|-------------|---------------|
|`[float]`|false   |2       |false        |transition_time|

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
{@{name=Get-OBSFadeTransitionShader; CommonParameters=True; parameter=System.Object[]}}
```
