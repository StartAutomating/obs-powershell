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
|`[Switch]`|false   |named   |False        |alpha_channel|

#### **AlphaInvert**

|Type      |Required|Position|PipelineInput|Aliases     |
|----------|--------|--------|-------------|------------|
|`[Switch]`|false   |named   |False        |alpha_invert|

#### **AlphaLevel**

|Type     |Required|Position|PipelineInput|Aliases    |
|---------|--------|--------|-------------|-----------|
|`[Float]`|false   |named   |False        |alpha_level|

#### **EdgeColor**

|Type      |Required|Position|PipelineInput|Aliases   |
|----------|--------|--------|-------------|----------|
|`[String]`|false   |named   |False        |edge_color|

#### **EdgeMultiply**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[Switch]`|false   |named   |False        |edge_multiply|

#### **FilterName**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |False        |

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **InvertEdge**

|Type      |Required|Position|PipelineInput|Aliases    |
|----------|--------|--------|-------------|-----------|
|`[Switch]`|false   |named   |False        |invert_edge|

#### **NonEdgeColor**

|Type      |Required|Position|PipelineInput|Aliases       |
|----------|--------|--------|-------------|--------------|
|`[String]`|false   |named   |False        |non_edge_color|

#### **NonEdgeMultiply**

|Type      |Required|Position|PipelineInput|Aliases          |
|----------|--------|--------|-------------|-----------------|
|`[Switch]`|false   |named   |False        |non_edge_multiply|

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **Notes**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |False        |

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **RandF**

|Type     |Required|Position|PipelineInput|Aliases|
|---------|--------|--------|-------------|-------|
|`[Float]`|false   |named   |False        |rand_f |

#### **Sensitivity**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[Float]`|false   |named   |False        |

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[String]`|false   |named   |False        |ShaderContent|

#### **SourceName**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[String]`|false   |named   |False        |SceneItemName|

#### **UseShaderTime**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

---

### Inputs
System.String

---

### Outputs
* [Object](https://learn.microsoft.com/en-us/dotnet/api/System.Object)

---

### Syntax
```PowerShell
Get-OBSEdgeDetectionShader [[-Sensitivity] <Float>] [-InvertEdge <Switch>] [[-EdgeColor] <String>] [-EdgeMultiply <Switch>] [[-NonEdgeColor] <String>] [-NonEdgeMultiply <Switch>] [-AlphaChannel <Switch>] [[-AlphaLevel] <Float>] [-AlphaInvert <Switch>] [[-RandF] <Float>] [[-Notes] <String>] [[-SourceName] <String>] [[-FilterName] <String>] [[-ShaderText] <String>] [-Force <Switch>] [-PassThru <Switch>] [-NoResponse <Switch>] [-UseShaderTime <Switch>] [<CommonParameters>]
```
