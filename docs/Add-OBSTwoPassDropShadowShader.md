Get-OBSTwoPassDropShadowShader
------------------------------

### Synopsis

Get-OBSTwoPassDropShadowShader [[-ViewProj] <float[][]>] [[-Image] <string>] [[-ElapsedTime] <float>] [[-UvOffset] <float[]>] [[-UvScale] <float[]>] [[-UvPixelInterval] <float[]>] [[-RandF] <float>] [[-UvSize] <float[]>] [[-ShadowOffsetX] <int>] [[-ShadowOffsetY] <int>] [[-ShadowBlurSize] <int>] [[-ShadowColor] <string>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-IsAlphaPremultiplied] [-Force] [-PassThru] [-NoResponse] [<CommonParameters>]

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
|`[string]`|false   |13      |true (ByPropertyName)|

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **Image**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[string]`|false   |1       |false        |

#### **IsAlphaPremultiplied**

|Type      |Required|Position|PipelineInput|Aliases               |
|----------|--------|--------|-------------|----------------------|
|`[switch]`|false   |Named   |false        |is_alpha_premultiplied|

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **RandF**

|Type     |Required|Position|PipelineInput|Aliases|
|---------|--------|--------|-------------|-------|
|`[float]`|false   |6       |false        |rand_f |

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[string]`|false   |14      |false        |ShaderContent|

#### **ShadowBlurSize**

|Type   |Required|Position|PipelineInput|Aliases         |
|-------|--------|--------|-------------|----------------|
|`[int]`|false   |10      |false        |shadow_blur_size|

#### **ShadowColor**

|Type      |Required|Position|PipelineInput|Aliases     |
|----------|--------|--------|-------------|------------|
|`[string]`|false   |11      |false        |shadow_color|

#### **ShadowOffsetX**

|Type   |Required|Position|PipelineInput|Aliases        |
|-------|--------|--------|-------------|---------------|
|`[int]`|false   |8       |false        |shadow_offset_x|

#### **ShadowOffsetY**

|Type   |Required|Position|PipelineInput|Aliases        |
|-------|--------|--------|-------------|---------------|
|`[int]`|false   |9       |false        |shadow_offset_y|

#### **SourceName**

|Type      |Required|Position|PipelineInput        |Aliases      |
|----------|--------|--------|---------------------|-------------|
|`[string]`|false   |12      |true (ByPropertyName)|SceneItemName|

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
{@{name=Get-OBSTwoPassDropShadowShader; CommonParameters=True; parameter=System.Object[]}}
```
