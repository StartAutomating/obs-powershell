Get-OBSAnimatedTextureShader
----------------------------

### Synopsis

Get-OBSAnimatedTextureShader [[-ViewProj] <float[][]>] [[-Image] <string>] [[-ElapsedTime] <float>] [[-UvOffset] <float[]>] [[-UvScale] <float[]>] [[-UvPixelInterval] <float[]>] [[-RandF] <float>] [[-UvSize] <float[]>] [[-Notes] <string>] [[-AnimationImage] <string>] [[-ColorizationImage] <string>] [[-PolarAngle] <float>] [[-PolarHeight] <float>] [[-SpeedHorizontalPercent] <float>] [[-SpeedVerticalPercent] <float>] [[-TintSpeedHorizontalPercent] <float>] [[-TintSpeedVerticalPercent] <float>] [[-Alpha] <float>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-Reverse] [-Bounce] [-CenterAnimation] [-PolarAnimation] [-UseAnimationImageColor] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **Alpha**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[float]`|false   |17      |false        |

#### **AnimationImage**

|Type      |Required|Position|PipelineInput|Aliases        |
|----------|--------|--------|-------------|---------------|
|`[string]`|false   |9       |false        |Animation_Image|

#### **Bounce**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **CenterAnimation**

|Type      |Required|Position|PipelineInput|Aliases         |
|----------|--------|--------|-------------|----------------|
|`[switch]`|false   |Named   |false        |center_animation|

#### **ColorizationImage**

|Type      |Required|Position|PipelineInput|Aliases           |
|----------|--------|--------|-------------|------------------|
|`[string]`|false   |10      |false        |Colorization_Image|

#### **ElapsedTime**

|Type     |Required|Position|PipelineInput|Aliases     |
|---------|--------|--------|-------------|------------|
|`[float]`|false   |2       |false        |elapsed_time|

#### **FilterName**

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[string]`|false   |19      |true (ByPropertyName)|

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **Image**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[string]`|false   |1       |false        |

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **Notes**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[string]`|false   |8       |false        |

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **PolarAngle**

|Type     |Required|Position|PipelineInput|Aliases    |
|---------|--------|--------|-------------|-----------|
|`[float]`|false   |11      |false        |polar_angle|

#### **PolarAnimation**

|Type      |Required|Position|PipelineInput|Aliases        |
|----------|--------|--------|-------------|---------------|
|`[switch]`|false   |Named   |false        |polar_animation|

#### **PolarHeight**

|Type     |Required|Position|PipelineInput|Aliases     |
|---------|--------|--------|-------------|------------|
|`[float]`|false   |12      |false        |polar_height|

#### **RandF**

|Type     |Required|Position|PipelineInput|Aliases|
|---------|--------|--------|-------------|-------|
|`[float]`|false   |6       |false        |rand_f |

#### **Reverse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[string]`|false   |20      |false        |ShaderContent|

#### **SourceName**

|Type      |Required|Position|PipelineInput        |Aliases      |
|----------|--------|--------|---------------------|-------------|
|`[string]`|false   |18      |true (ByPropertyName)|SceneItemName|

#### **SpeedHorizontalPercent**

|Type     |Required|Position|PipelineInput|Aliases                 |
|---------|--------|--------|-------------|------------------------|
|`[float]`|false   |13      |false        |speed_horizontal_percent|

#### **SpeedVerticalPercent**

|Type     |Required|Position|PipelineInput|Aliases               |
|---------|--------|--------|-------------|----------------------|
|`[float]`|false   |14      |false        |speed_vertical_percent|

#### **TintSpeedHorizontalPercent**

|Type     |Required|Position|PipelineInput|Aliases                      |
|---------|--------|--------|-------------|-----------------------------|
|`[float]`|false   |15      |false        |tint_speed_horizontal_percent|

#### **TintSpeedVerticalPercent**

|Type     |Required|Position|PipelineInput|Aliases                    |
|---------|--------|--------|-------------|---------------------------|
|`[float]`|false   |16      |false        |tint_speed_vertical_percent|

#### **UseAnimationImageColor**

|Type      |Required|Position|PipelineInput|Aliases                  |
|----------|--------|--------|-------------|-------------------------|
|`[switch]`|false   |Named   |false        |Use_Animation_Image_Color|

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
|`[float[]]`|false   |7       |false        |uv_size|

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
{@{name=Get-OBSAnimatedTextureShader; CommonParameters=True; parameter=System.Object[]}}
```
