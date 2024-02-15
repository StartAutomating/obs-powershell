Get-OBSGaussianBlurShader
-------------------------

### Synopsis

Get-OBSGaussianBlurShader [[-ViewProj] <float[][]>] [[-Image] <string>] [[-ImageSize] <float[]>] [[-ImageTexel] <float[]>] [[-URadius] <int>] [[-UDiameter] <int>] [[-UTexelDelta] <float[]>] [[-ElapsedTime] <float>] [[-UvOffset] <float[]>] [[-UvScale] <float[]>] [[-UvPixelInterval] <float[]>] [[-Kernel] <string>] [[-KernelTexel] <float[]>] [[-PixelSize] <float>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **ElapsedTime**

|Type     |Required|Position|PipelineInput|Aliases     |
|---------|--------|--------|-------------|------------|
|`[float]`|false   |7       |false        |elapsed_time|

#### **FilterName**

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[string]`|false   |15      |true (ByPropertyName)|

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **Image**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[string]`|false   |1       |false        |

#### **ImageSize**

|Type       |Required|Position|PipelineInput|
|-----------|--------|--------|-------------|
|`[float[]]`|false   |2       |false        |

#### **ImageTexel**

|Type       |Required|Position|PipelineInput|
|-----------|--------|--------|-------------|
|`[float[]]`|false   |3       |false        |

#### **Kernel**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[string]`|false   |11      |false        |

#### **KernelTexel**

|Type       |Required|Position|PipelineInput|
|-----------|--------|--------|-------------|
|`[float[]]`|false   |12      |false        |

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **PixelSize**

|Type     |Required|Position|PipelineInput|Aliases   |
|---------|--------|--------|-------------|----------|
|`[float]`|false   |13      |false        |pixel_size|

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[string]`|false   |16      |false        |ShaderContent|

#### **SourceName**

|Type      |Required|Position|PipelineInput        |Aliases      |
|----------|--------|--------|---------------------|-------------|
|`[string]`|false   |14      |true (ByPropertyName)|SceneItemName|

#### **UDiameter**

|Type   |Required|Position|PipelineInput|Aliases   |
|-------|--------|--------|-------------|----------|
|`[int]`|false   |5       |false        |u_diameter|

#### **URadius**

|Type   |Required|Position|PipelineInput|Aliases |
|-------|--------|--------|-------------|--------|
|`[int]`|false   |4       |false        |u_radius|

#### **UTexelDelta**

|Type       |Required|Position|PipelineInput|Aliases     |
|-----------|--------|--------|-------------|------------|
|`[float[]]`|false   |6       |false        |u_texelDelta|

#### **UseShaderTime**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **UvOffset**

|Type       |Required|Position|PipelineInput|Aliases  |
|-----------|--------|--------|-------------|---------|
|`[float[]]`|false   |8       |false        |uv_offset|

#### **UvPixelInterval**

|Type       |Required|Position|PipelineInput|Aliases          |
|-----------|--------|--------|-------------|-----------------|
|`[float[]]`|false   |10      |false        |uv_pixel_interval|

#### **UvScale**

|Type       |Required|Position|PipelineInput|Aliases |
|-----------|--------|--------|-------------|--------|
|`[float[]]`|false   |9       |false        |uv_scale|

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
{@{name=Get-OBSGaussianBlurShader; CommonParameters=True; parameter=System.Object[]}}
```
