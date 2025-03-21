Get-OBSCartoonShader
--------------------

### Synopsis
Get-OBSCartoonShader [[-ViewProj] <float[][]>] [[-Image] <string>] [[-ElapsedTime] <float>] [[-UvOffset] <float[]>] [[-UvScale] <float[]>] [[-UvPixelInterval] <float[]>] [[-RandF] <float>] [[-UvSize] <float[]>] [[-Notes] <string>] [[-HueSteps] <int>] [[-ValueSteps] <int>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-ApplyToAlphaLayer] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **ApplyToAlphaLayer**

|Type      |Required|Position|PipelineInput|Aliases             |
|----------|--------|--------|-------------|--------------------|
|`[Switch]`|false   |named   |False        |Apply_To_Alpha_Layer|

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

#### **HueSteps**

|Type   |Required|Position|PipelineInput|Aliases  |
|-------|--------|--------|-------------|---------|
|`[Int]`|false   |named   |False        |hue_steps|

#### **Image**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |False        |

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

#### **ValueSteps**

|Type   |Required|Position|PipelineInput|Aliases    |
|-------|--------|--------|-------------|-----------|
|`[Int]`|false   |named   |False        |value_steps|

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
Get-OBSCartoonShader [[-ViewProj] <System.Single[][]>] [[-Image] <String>] [[-ElapsedTime] <Float>] [[-UvOffset] <System.Single[]>] [[-UvScale] <System.Single[]>] [[-UvPixelInterval] <System.Single[]>] [[-RandF] <Float>] [[-UvSize] <System.Single[]>] [[-Notes] <String>] [[-HueSteps] <Int>] [[-ValueSteps] <Int>] [-ApplyToAlphaLayer <Switch>] [[-SourceName] <String>] [[-FilterName] <String>] [[-ShaderText] <String>] [-Force <Switch>] [-PassThru <Switch>] [-NoResponse <Switch>] [-UseShaderTime <Switch>] [<CommonParameters>]
```
