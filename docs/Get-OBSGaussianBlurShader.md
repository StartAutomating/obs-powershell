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
|`[Float]`|false   |named   |False        |elapsed_time|

#### **FilterName**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |False        |

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **Image**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |False        |

#### **ImageSize**

|Type               |Required|Position|PipelineInput|
|-------------------|--------|--------|-------------|
|`[System.Single[]]`|false   |named   |False        |

#### **ImageTexel**

|Type               |Required|Position|PipelineInput|
|-------------------|--------|--------|-------------|
|`[System.Single[]]`|false   |named   |False        |

#### **Kernel**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |False        |

#### **KernelTexel**

|Type               |Required|Position|PipelineInput|
|-------------------|--------|--------|-------------|
|`[System.Single[]]`|false   |named   |False        |

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **PixelSize**

|Type     |Required|Position|PipelineInput|Aliases   |
|---------|--------|--------|-------------|----------|
|`[Float]`|false   |named   |False        |pixel_size|

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[String]`|false   |named   |False        |ShaderContent|

#### **SourceName**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[String]`|false   |named   |False        |SceneItemName|

#### **UDiameter**

|Type   |Required|Position|PipelineInput|Aliases   |
|-------|--------|--------|-------------|----------|
|`[Int]`|false   |named   |False        |u_diameter|

#### **URadius**

|Type   |Required|Position|PipelineInput|Aliases |
|-------|--------|--------|-------------|--------|
|`[Int]`|false   |named   |False        |u_radius|

#### **UseShaderTime**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **UTexelDelta**

|Type               |Required|Position|PipelineInput|Aliases     |
|-------------------|--------|--------|-------------|------------|
|`[System.Single[]]`|false   |named   |False        |u_texelDelta|

#### **UvOffset**

|Type               |Required|Position|PipelineInput|Aliases  |
|-------------------|--------|--------|-------------|---------|
|`[System.Single[]]`|false   |named   |False        |uv_offset|

#### **UvPixelInterval**

|Type               |Required|Position|PipelineInput|Aliases          |
|-------------------|--------|--------|-------------|-----------------|
|`[System.Single[]]`|false   |named   |False        |uv_pixel_interval|

#### **UvScale**

|Type               |Required|Position|PipelineInput|Aliases |
|-------------------|--------|--------|-------------|--------|
|`[System.Single[]]`|false   |named   |False        |uv_scale|

#### **ViewProj**

|Type                 |Required|Position|PipelineInput|
|---------------------|--------|--------|-------------|
|`[System.Single[][]]`|false   |named   |False        |

---

### Inputs
System.String

---

### Outputs
* [Object](https://learn.microsoft.com/en-us/dotnet/api/System.Object)

---

### Syntax
```PowerShell
Get-OBSGaussianBlurShader [[-ViewProj] <System.Single[][]>] [[-Image] <String>] [[-ImageSize] <System.Single[]>] [[-ImageTexel] <System.Single[]>] [[-URadius] <Int>] [[-UDiameter] <Int>] [[-UTexelDelta] <System.Single[]>] [[-ElapsedTime] <Float>] [[-UvOffset] <System.Single[]>] [[-UvScale] <System.Single[]>] [[-UvPixelInterval] <System.Single[]>] [[-Kernel] <String>] [[-KernelTexel] <System.Single[]>] [[-PixelSize] <Float>] [[-SourceName] <String>] [[-FilterName] <String>] [[-ShaderText] <String>] [-Force <Switch>] [-PassThru <Switch>] [-NoResponse <Switch>] [-UseShaderTime <Switch>] [<CommonParameters>]
```
