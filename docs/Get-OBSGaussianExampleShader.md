Get-OBSGaussianExampleShader
----------------------------

### Synopsis

Get-OBSGaussianExampleShader [[-ViewProj] <float[][]>] [[-Image] <string>] [[-ElapsedTime] <float>] [[-UvOffset] <float[]>] [[-UvScale] <float[]>] [[-UvSize] <float[]>] [[-UvPixelInterval] <float[]>] [[-InitialImage] <string>] [[-BeforeImage] <string>] [[-AfterImage] <string>] [[-TextColor] <string>] [[-MaxDistance] <float>] [[-Exp] <float>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-Force] [-PassThru] [-NoResponse] [<CommonParameters>]

---

### Description

---

### Parameters
#### **AfterImage**

|Type      |Required|Position|PipelineInput|Aliases    |
|----------|--------|--------|-------------|-----------|
|`[string]`|false   |9       |false        |after_image|

#### **BeforeImage**

|Type      |Required|Position|PipelineInput|Aliases     |
|----------|--------|--------|-------------|------------|
|`[string]`|false   |8       |false        |before_image|

#### **ElapsedTime**

|Type     |Required|Position|PipelineInput|Aliases     |
|---------|--------|--------|-------------|------------|
|`[float]`|false   |2       |false        |elapsed_time|

#### **Exp**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[float]`|false   |12      |false        |

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

#### **InitialImage**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[string]`|false   |7       |false        |initial_image|

#### **MaxDistance**

|Type     |Required|Position|PipelineInput|Aliases     |
|---------|--------|--------|-------------|------------|
|`[float]`|false   |11      |false        |max_distance|

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[string]`|false   |15      |false        |ShaderContent|

#### **SourceName**

|Type      |Required|Position|PipelineInput        |Aliases      |
|----------|--------|--------|---------------------|-------------|
|`[string]`|false   |13      |true (ByPropertyName)|SceneItemName|

#### **TextColor**

|Type      |Required|Position|PipelineInput|Aliases   |
|----------|--------|--------|-------------|----------|
|`[string]`|false   |10      |false        |text_color|

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
{@{name=Get-OBSGaussianExampleShader; CommonParameters=True; parameter=System.Object[]}}
```
