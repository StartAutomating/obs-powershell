Get-OBSFire3Shader
------------------

### Synopsis

Get-OBSFire3Shader [[-ViewProj] <float[][]>] [[-Image] <string>] [[-ElapsedTime] <float>] [[-UvOffset] <float[]>] [[-UvScale] <float[]>] [[-UvPixelInterval] <float[]>] [[-UvSize] <float[]>] [[-RandF] <float>] [[-RandInstanceF] <float>] [[-RandActivationF] <float>] [[-Loops] <int>] [[-LocalTime] <float>] [[-MovementDirectionHorizontal] <float>] [[-MovementDirectionVertical] <float>] [[-AlphaPercentage] <int>] [[-Speed] <int>] [[-LumaMin] <float>] [[-LumaMinSmooth] <float>] [[-ColorToReplace] <string>] [[-FlameSize] <float>] [[-SparkGridHeight] <float>] [[-FlameModifier] <float>] [[-FlameTongueSize] <float>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-Invert] [-ApplyToImage] [-ReplaceImageColor] [-ApplyToSpecificColor] [-FullWidth] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **AlphaPercentage**

|Type   |Required|Position|PipelineInput|Aliases         |
|-------|--------|--------|-------------|----------------|
|`[int]`|false   |14      |false        |Alpha_Percentage|

#### **ApplyToImage**

|Type      |Required|Position|PipelineInput|Aliases       |
|----------|--------|--------|-------------|--------------|
|`[switch]`|false   |Named   |false        |Apply_To_Image|

#### **ApplyToSpecificColor**

|Type      |Required|Position|PipelineInput|Aliases                |
|----------|--------|--------|-------------|-----------------------|
|`[switch]`|false   |Named   |false        |Apply_To_Specific_Color|

#### **ColorToReplace**

|Type      |Required|Position|PipelineInput|Aliases         |
|----------|--------|--------|-------------|----------------|
|`[string]`|false   |18      |false        |Color_To_Replace|

#### **ElapsedTime**

|Type     |Required|Position|PipelineInput|Aliases     |
|---------|--------|--------|-------------|------------|
|`[float]`|false   |2       |false        |elapsed_time|

#### **FilterName**

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[string]`|false   |24      |true (ByPropertyName)|

#### **FlameModifier**

|Type     |Required|Position|PipelineInput|Aliases       |
|---------|--------|--------|-------------|--------------|
|`[float]`|false   |21      |false        |Flame_Modifier|

#### **FlameSize**

|Type     |Required|Position|PipelineInput|Aliases   |
|---------|--------|--------|-------------|----------|
|`[float]`|false   |19      |false        |Flame_Size|

#### **FlameTongueSize**

|Type     |Required|Position|PipelineInput|Aliases          |
|---------|--------|--------|-------------|-----------------|
|`[float]`|false   |22      |false        |Flame_Tongue_Size|

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **FullWidth**

|Type      |Required|Position|PipelineInput|Aliases   |
|----------|--------|--------|-------------|----------|
|`[switch]`|false   |Named   |false        |Full_Width|

#### **Image**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[string]`|false   |1       |false        |

#### **Invert**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

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
|`[float]`|false   |16      |false        |

#### **LumaMinSmooth**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[float]`|false   |17      |false        |

#### **MovementDirectionHorizontal**

|Type     |Required|Position|PipelineInput|Aliases                      |
|---------|--------|--------|-------------|-----------------------------|
|`[float]`|false   |12      |false        |Movement_Direction_Horizontal|

#### **MovementDirectionVertical**

|Type     |Required|Position|PipelineInput|Aliases                    |
|---------|--------|--------|-------------|---------------------------|
|`[float]`|false   |13      |false        |Movement_Direction_Vertical|

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

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

#### **ReplaceImageColor**

|Type      |Required|Position|PipelineInput|Aliases            |
|----------|--------|--------|-------------|-------------------|
|`[switch]`|false   |Named   |false        |Replace_Image_Color|

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[string]`|false   |25      |false        |ShaderContent|

#### **SourceName**

|Type      |Required|Position|PipelineInput        |Aliases      |
|----------|--------|--------|---------------------|-------------|
|`[string]`|false   |23      |true (ByPropertyName)|SceneItemName|

#### **SparkGridHeight**

|Type     |Required|Position|PipelineInput|Aliases          |
|---------|--------|--------|-------------|-----------------|
|`[float]`|false   |20      |false        |Spark_Grid_Height|

#### **Speed**

|Type   |Required|Position|PipelineInput|
|-------|--------|--------|-------------|
|`[int]`|false   |15      |false        |

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
{@{name=Get-OBSFire3Shader; CommonParameters=True; parameter=System.Object[]}}
```
