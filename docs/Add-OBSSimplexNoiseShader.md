Get-OBSSimplexNoiseShader
-------------------------

### Synopsis

Get-OBSSimplexNoiseShader [[-SnapPercent] <float>] [[-SpeedPercent] <float>] [[-Resolution] <float>] [[-ForeColor] <string>] [[-BackColor] <string>] [[-AlphaPercent] <float>] [[-Notes] <string>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-Fractal] [-UseAlphaLayer] [-Force] [-PassThru] [-NoResponse] [<CommonParameters>]

---

### Description

---

### Parameters
#### **AlphaPercent**

|Type     |Required|Position|PipelineInput|Aliases      |
|---------|--------|--------|-------------|-------------|
|`[float]`|false   |5       |false        |Alpha_Percent|

#### **BackColor**

|Type      |Required|Position|PipelineInput|Aliases   |
|----------|--------|--------|-------------|----------|
|`[string]`|false   |4       |false        |Back_Color|

#### **FilterName**

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[string]`|false   |8       |true (ByPropertyName)|

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **ForeColor**

|Type      |Required|Position|PipelineInput|Aliases   |
|----------|--------|--------|-------------|----------|
|`[string]`|false   |3       |false        |Fore_Color|

#### **Fractal**

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
|`[string]`|false   |6       |false        |

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **Resolution**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[float]`|false   |2       |false        |

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[string]`|false   |9       |false        |ShaderContent|

#### **SnapPercent**

|Type     |Required|Position|PipelineInput|Aliases     |
|---------|--------|--------|-------------|------------|
|`[float]`|false   |0       |false        |Snap_Percent|

#### **SourceName**

|Type      |Required|Position|PipelineInput        |Aliases      |
|----------|--------|--------|---------------------|-------------|
|`[string]`|false   |7       |true (ByPropertyName)|SceneItemName|

#### **SpeedPercent**

|Type     |Required|Position|PipelineInput|Aliases      |
|---------|--------|--------|-------------|-------------|
|`[float]`|false   |1       |false        |Speed_Percent|

#### **UseAlphaLayer**

|Type      |Required|Position|PipelineInput|Aliases        |
|----------|--------|--------|-------------|---------------|
|`[switch]`|false   |Named   |false        |Use_Alpha_Layer|

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
{@{name=Get-OBSSimplexNoiseShader; CommonParameters=True; parameter=System.Object[]}}
```
