Get-OBSEmbersShader
-------------------

### Synopsis

Get-OBSEmbersShader [[-ViewProj] <float[][]>] [[-Image] <string>] [[-ElapsedTime] <float>] [[-UvOffset] <float[]>] [[-UvScale] <float[]>] [[-UvSize] <float[]>] [[-UvPixelInterval] <float[]>] [[-RandF] <float>] [[-RandInstanceF] <float>] [[-RandActivationF] <float>] [[-Loops] <int>] [[-LocalTime] <float>] [[-Notes] <string>] [[-AnimationSpeed] <float>] [[-MovementDirectionHorizontal] <float>] [[-MovementDirectionVertical] <float>] [[-MovementSpeedPercent] <int>] [[-LayersCount] <int>] [[-LumaMin] <float>] [[-LumaMinSmooth] <float>] [[-AlphaPercentage] <float>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-ApplyToAlphaLayer] [-Force] [-PassThru] [-NoResponse] [<CommonParameters>]

---

### Description

---

### Parameters
#### **AlphaPercentage**

|Type     |Required|Position|PipelineInput|Aliases         |
|---------|--------|--------|-------------|----------------|
|`[float]`|false   |20      |false        |Alpha_Percentage|

#### **AnimationSpeed**

|Type     |Required|Position|PipelineInput|Aliases        |
|---------|--------|--------|-------------|---------------|
|`[float]`|false   |13      |false        |Animation_Speed|

#### **ApplyToAlphaLayer**

|Type      |Required|Position|PipelineInput|Aliases             |
|----------|--------|--------|-------------|--------------------|
|`[switch]`|false   |Named   |false        |Apply_To_Alpha_Layer|

#### **ElapsedTime**

|Type     |Required|Position|PipelineInput|Aliases     |
|---------|--------|--------|-------------|------------|
|`[float]`|false   |2       |false        |elapsed_time|

#### **FilterName**

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[string]`|false   |22      |true (ByPropertyName)|

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **Image**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[string]`|false   |1       |false        |

#### **LayersCount**

|Type   |Required|Position|PipelineInput|Aliases     |
|-------|--------|--------|-------------|------------|
|`[int]`|false   |17      |false        |Layers_Count|

#### **LocalTime**

|Type     |Required|Position|PipelineInput|Aliases   |
|---------|--------|--------|-------------|----------|
|`[float]`|false   |11      |false        |local_time|

#### **Loops**

|Type   |Required|Position|PipelineInput|
|-------|--------|--------|-------------|
|`[int]`|false   |10      |false        |

#### **LumaMin**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[float]`|false   |18      |false        |

#### **LumaMinSmooth**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[float]`|false   |19      |false        |

#### **MovementDirectionHorizontal**

|Type     |Required|Position|PipelineInput|Aliases                      |
|---------|--------|--------|-------------|-----------------------------|
|`[float]`|false   |14      |false        |Movement_Direction_Horizontal|

#### **MovementDirectionVertical**

|Type     |Required|Position|PipelineInput|Aliases                    |
|---------|--------|--------|-------------|---------------------------|
|`[float]`|false   |15      |false        |Movement_Direction_Vertical|

#### **MovementSpeedPercent**

|Type   |Required|Position|PipelineInput|Aliases               |
|-------|--------|--------|-------------|----------------------|
|`[int]`|false   |16      |false        |Movement_Speed_Percent|

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
|`[string]`|false   |23      |false        |ShaderContent|

#### **SourceName**

|Type      |Required|Position|PipelineInput        |Aliases      |
|----------|--------|--------|---------------------|-------------|
|`[string]`|false   |21      |true (ByPropertyName)|SceneItemName|

#### **UvOffset**

|Type       |Required|Position|PipelineInput|Aliases  |
|-----------|--------|--------|-------------|---------|
|`[float[]]`|false   |3       |false        |uv_offset|

#### **UvPixelInterval**

|Type       |Required|Position|PipelineInput|Aliases          |
|-----------|--------|--------|-------------|-----------------|
|`[float[]]`|false   |6       |false        |uv_pixel_interval|

#### **UvScale**

|Type       |Required|Position|PipelineInput|Aliases |
|-----------|--------|--------|-------------|--------|
|`[float[]]`|false   |4       |false        |uv_scale|

#### **UvSize**

|Type       |Required|Position|PipelineInput|Aliases|
|-----------|--------|--------|-------------|-------|
|`[float[]]`|false   |5       |false        |uv_size|

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
{@{name=Get-OBSEmbersShader; CommonParameters=True; parameter=System.Object[]}}
```
