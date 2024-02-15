Get-OBSEdgeDetectionShader
--------------------------

### Synopsis

Get-OBSEdgeDetectionShader [[-Sensitivity] <float>] [[-EdgeColor] <string>] [[-NonEdgeColor] <string>] [[-AlphaLevel] <float>] [[-RandF] <float>] [[-Notes] <string>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-InvertEdge] [-EdgeMultiply] [-NonEdgeMultiply] [-AlphaChannel] [-AlphaInvert] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **AlphaChannel**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[switch]`|false   |Named   |false        |alpha_channel|

#### **AlphaInvert**

|Type      |Required|Position|PipelineInput|Aliases     |
|----------|--------|--------|-------------|------------|
|`[switch]`|false   |Named   |false        |alpha_invert|

#### **AlphaLevel**

|Type     |Required|Position|PipelineInput|Aliases    |
|---------|--------|--------|-------------|-----------|
|`[float]`|false   |3       |false        |alpha_level|

#### **EdgeColor**

|Type      |Required|Position|PipelineInput|Aliases   |
|----------|--------|--------|-------------|----------|
|`[string]`|false   |1       |false        |edge_color|

#### **EdgeMultiply**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[switch]`|false   |Named   |false        |edge_multiply|

#### **FilterName**

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[string]`|false   |7       |true (ByPropertyName)|

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **InvertEdge**

|Type      |Required|Position|PipelineInput|Aliases    |
|----------|--------|--------|-------------|-----------|
|`[switch]`|false   |Named   |false        |invert_edge|

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **NonEdgeColor**

|Type      |Required|Position|PipelineInput|Aliases       |
|----------|--------|--------|-------------|--------------|
|`[string]`|false   |2       |false        |non_edge_color|

#### **NonEdgeMultiply**

|Type      |Required|Position|PipelineInput|Aliases          |
|----------|--------|--------|-------------|-----------------|
|`[switch]`|false   |Named   |false        |non_edge_multiply|

#### **Notes**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[string]`|false   |5       |false        |

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **RandF**

|Type     |Required|Position|PipelineInput|Aliases|
|---------|--------|--------|-------------|-------|
|`[float]`|false   |4       |false        |rand_f |

#### **Sensitivity**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[float]`|false   |0       |false        |

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[string]`|false   |8       |false        |ShaderContent|

#### **SourceName**

|Type      |Required|Position|PipelineInput        |Aliases      |
|----------|--------|--------|---------------------|-------------|
|`[string]`|false   |6       |true (ByPropertyName)|SceneItemName|

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
{@{name=Get-OBSEdgeDetectionShader; CommonParameters=True; parameter=System.Object[]}}
```
