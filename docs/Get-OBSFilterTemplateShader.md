Get-OBSFilterTemplateShader
---------------------------

### Synopsis

Get-OBSFilterTemplateShader [[-ViewProj] <float[][]>] [[-Image] <string>] [[-ElapsedTime] <float>] [[-UvOffset] <float[]>] [[-UvScale] <float[]>] [[-UvPixelInterval] <float[]>] [[-UvSize] <float[]>] [[-RandF] <float>] [[-RandInstanceF] <float>] [[-RandActivationF] <float>] [[-Loops] <int>] [[-LocalTime] <float>] [[-Notes] <string>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **ElapsedTime**

|Type     |Required|Position|PipelineInput|Aliases     |
|---------|--------|--------|-------------|------------|
|`[float]`|false   |2       |false        |elapsed_time|

#### **FilterName**

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[string]`|false   |14      |true (ByPropertyName)|

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **Image**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[string]`|false   |1       |false        |

#### **LocalTime**

|Type     |Required|Position|PipelineInput|Aliases   |
|---------|--------|--------|-------------|----------|
|`[float]`|false   |11      |false        |local_time|

#### **Loops**

|Type   |Required|Position|PipelineInput|
|-------|--------|--------|-------------|
|`[int]`|false   |10      |false        |

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **Notes**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[string]`|false   |12      |false        |

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **RandActivationF**

|Type     |Required|Position|PipelineInput|Aliases          |
|---------|--------|--------|-------------|-----------------|
|`[float]`|false   |9       |false        |rand_activation_f|

#### **RandF**

|Type     |Required|Position|PipelineInput|Aliases|
|---------|--------|--------|-------------|-------|
|`[float]`|false   |7       |false        |rand_f |

#### **RandInstanceF**

|Type     |Required|Position|PipelineInput|Aliases        |
|---------|--------|--------|-------------|---------------|
|`[float]`|false   |8       |false        |rand_instance_f|

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[string]`|false   |15      |false        |ShaderContent|

#### **SourceName**

|Type      |Required|Position|PipelineInput        |Aliases      |
|----------|--------|--------|---------------------|-------------|
|`[string]`|false   |13      |true (ByPropertyName)|SceneItemName|

#### **UseShaderTime**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **UvOffset**

|Type       |Required|Position|PipelineInput|Aliases  |
|-----------|--------|--------|-------------|---------|
|`[float[]]`|false   |3       |false        |uv_offset|

#### **UvPixelInterval**

|Type       |Required|Position|PipelineInput|Aliases          |
|-----------|--------|--------|-------------|-----------------|
|`[float[]]`|false   |5       |false        |uv_pixel_interval|

#### **UvScale**

|Type       |Required|Position|PipelineInput|Aliases |
|-----------|--------|--------|-------------|--------|
|`[float[]]`|false   |4       |false        |uv_scale|

#### **UvSize**

|Type       |Required|Position|PipelineInput|Aliases|
|-----------|--------|--------|-------------|-------|
|`[float[]]`|false   |6       |false        |uv_size|

#### **ViewProj**

|Type         |Required|Position|PipelineInput|
|-------------|--------|--------|-------------|
|`[float[][]]`|false   |0       |false        |

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
{@{name=Get-OBSFilterTemplateShader; CommonParameters=True; parameter=System.Object[]}}
```
