Get-OBSGaussianExampleShader
----------------------------

### Synopsis
Get-OBSGaussianExampleShader [[-ViewProj] <float[][]>] [[-Image] <string>] [[-ElapsedTime] <float>] [[-UvOffset] <float[]>] [[-UvScale] <float[]>] [[-UvSize] <float[]>] [[-UvPixelInterval] <float[]>] [[-InitialImage] <string>] [[-BeforeImage] <string>] [[-AfterImage] <string>] [[-TextColor] <string>] [[-MaxDistance] <float>] [[-Exp] <float>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **AfterImage**

|Type      |Required|Position|PipelineInput|Aliases    |
|----------|--------|--------|-------------|-----------|
|`[String]`|false   |named   |False        |after_image|

#### **BeforeImage**

|Type      |Required|Position|PipelineInput|Aliases     |
|----------|--------|--------|-------------|------------|
|`[String]`|false   |named   |False        |before_image|

#### **ElapsedTime**

|Type     |Required|Position|PipelineInput|Aliases     |
|---------|--------|--------|-------------|------------|
|`[Float]`|false   |named   |False        |elapsed_time|

#### **Exp**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[Float]`|false   |named   |False        |

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

#### **InitialImage**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[String]`|false   |named   |False        |initial_image|

#### **MaxDistance**

|Type     |Required|Position|PipelineInput|Aliases     |
|---------|--------|--------|-------------|------------|
|`[Float]`|false   |named   |False        |max_distance|

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[String]`|false   |named   |False        |ShaderContent|

#### **SourceName**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[String]`|false   |named   |False        |SceneItemName|

#### **TextColor**

|Type      |Required|Position|PipelineInput|Aliases   |
|----------|--------|--------|-------------|----------|
|`[String]`|false   |named   |False        |text_color|

#### **UseShaderTime**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

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

#### **UvSize**

|Type               |Required|Position|PipelineInput|Aliases|
|-------------------|--------|--------|-------------|-------|
|`[System.Single[]]`|false   |named   |False        |uv_size|

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
Get-OBSGaussianExampleShader [[-ViewProj] <System.Single[][]>] [[-Image] <String>] [[-ElapsedTime] <Float>] [[-UvOffset] <System.Single[]>] [[-UvScale] <System.Single[]>] [[-UvSize] <System.Single[]>] [[-UvPixelInterval] <System.Single[]>] [[-InitialImage] <String>] [[-BeforeImage] <String>] [[-AfterImage] <String>] [[-TextColor] <String>] [[-MaxDistance] <Float>] [[-Exp] <Float>] [[-SourceName] <String>] [[-FilterName] <String>] [[-ShaderText] <String>] [-Force <Switch>] [-PassThru <Switch>] [-NoResponse <Switch>] [-UseShaderTime <Switch>] [<CommonParameters>]
```
