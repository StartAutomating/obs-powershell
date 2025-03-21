Get-OBSEmbersShader
-------------------

### Synopsis
Get-OBSEmbersShader [[-ViewProj] <float[][]>] [[-Image] <string>] [[-ElapsedTime] <float>] [[-UvOffset] <float[]>] [[-UvScale] <float[]>] [[-UvSize] <float[]>] [[-UvPixelInterval] <float[]>] [[-RandF] <float>] [[-RandInstanceF] <float>] [[-RandActivationF] <float>] [[-Loops] <int>] [[-LocalTime] <float>] [[-Notes] <string>] [[-AnimationSpeed] <float>] [[-MovementDirectionHorizontal] <float>] [[-MovementDirectionVertical] <float>] [[-MovementSpeedPercent] <int>] [[-LayersCount] <int>] [[-LumaMin] <float>] [[-LumaMinSmooth] <float>] [[-AlphaPercentage] <float>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-ApplyToAlphaLayer] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **AlphaPercentage**

|Type     |Required|Position|PipelineInput|Aliases         |
|---------|--------|--------|-------------|----------------|
|`[Float]`|false   |named   |False        |Alpha_Percentage|

#### **AnimationSpeed**

|Type     |Required|Position|PipelineInput|Aliases        |
|---------|--------|--------|-------------|---------------|
|`[Float]`|false   |named   |False        |Animation_Speed|

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

#### **Image**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |False        |

#### **LayersCount**

|Type   |Required|Position|PipelineInput|Aliases     |
|-------|--------|--------|-------------|------------|
|`[Int]`|false   |named   |False        |Layers_Count|

#### **LocalTime**

|Type     |Required|Position|PipelineInput|Aliases   |
|---------|--------|--------|-------------|----------|
|`[Float]`|false   |named   |False        |local_time|

#### **Loops**

|Type   |Required|Position|PipelineInput|
|-------|--------|--------|-------------|
|`[Int]`|false   |named   |False        |

#### **LumaMin**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[Float]`|false   |named   |False        |

#### **LumaMinSmooth**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[Float]`|false   |named   |False        |

#### **MovementDirectionHorizontal**

|Type     |Required|Position|PipelineInput|Aliases                      |
|---------|--------|--------|-------------|-----------------------------|
|`[Float]`|false   |named   |False        |Movement_Direction_Horizontal|

#### **MovementDirectionVertical**

|Type     |Required|Position|PipelineInput|Aliases                    |
|---------|--------|--------|-------------|---------------------------|
|`[Float]`|false   |named   |False        |Movement_Direction_Vertical|

#### **MovementSpeedPercent**

|Type   |Required|Position|PipelineInput|Aliases               |
|-------|--------|--------|-------------|----------------------|
|`[Int]`|false   |named   |False        |Movement_Speed_Percent|

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

#### **RandActivationF**

|Type     |Required|Position|PipelineInput|Aliases          |
|---------|--------|--------|-------------|-----------------|
|`[Float]`|false   |named   |False        |rand_activation_f|

#### **RandF**

|Type     |Required|Position|PipelineInput|Aliases|
|---------|--------|--------|-------------|-------|
|`[Float]`|false   |named   |False        |rand_f |

#### **RandInstanceF**

|Type     |Required|Position|PipelineInput|Aliases        |
|---------|--------|--------|-------------|---------------|
|`[Float]`|false   |named   |False        |rand_instance_f|

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
Get-OBSEmbersShader [[-ViewProj] <System.Single[][]>] [[-Image] <String>] [[-ElapsedTime] <Float>] [[-UvOffset] <System.Single[]>] [[-UvScale] <System.Single[]>] [[-UvSize] <System.Single[]>] [[-UvPixelInterval] <System.Single[]>] [[-RandF] <Float>] [[-RandInstanceF] <Float>] [[-RandActivationF] <Float>] [[-Loops] <Int>] [[-LocalTime] <Float>] [[-Notes] <String>] [[-AnimationSpeed] <Float>] [[-MovementDirectionHorizontal] <Float>] [[-MovementDirectionVertical] <Float>] [[-MovementSpeedPercent] <Int>] [[-LayersCount] <Int>] [[-LumaMin] <Float>] [[-LumaMinSmooth] <Float>] [[-AlphaPercentage] <Float>] [-ApplyToAlphaLayer <Switch>] [[-SourceName] <String>] [[-FilterName] <String>] [[-ShaderText] <String>] [-Force <Switch>] [-PassThru <Switch>] [-NoResponse <Switch>] [-UseShaderTime <Switch>] [<CommonParameters>]
```
