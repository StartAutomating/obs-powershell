Get-OBSNightSkyShader
---------------------

### Synopsis

Get-OBSNightSkyShader [[-Speed] <float>] [[-CenterWidthPercentage] <int>] [[-CenterHeightPercentage] <int>] [[-AlphaPercentage] <float>] [[-NumberStars] <int>] [[-SKYCOLOR] <string>] [[-STARCOLOR] <string>] [[-LIGHTSKY] <string>] [[-SKYLIGHTNESS] <float>] [[-MOONCOLOR] <string>] [[-MoonSize] <float>] [[-MoonBumpSize] <float>] [[-MoonPositionX] <float>] [[-MoonPositionY] <float>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-IncludeClouds] [-IncludeMoon] [-ApplyToImage] [-ReplaceImageColor] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **AlphaPercentage**

|Type     |Required|Position|PipelineInput|Aliases         |
|---------|--------|--------|-------------|----------------|
|`[float]`|false   |3       |false        |Alpha_Percentage|

#### **ApplyToImage**

|Type      |Required|Position|PipelineInput|Aliases       |
|----------|--------|--------|-------------|--------------|
|`[switch]`|false   |Named   |false        |Apply_To_Image|

#### **CenterHeightPercentage**

|Type   |Required|Position|PipelineInput|Aliases                 |
|-------|--------|--------|-------------|------------------------|
|`[int]`|false   |2       |false        |center_height_percentage|

#### **CenterWidthPercentage**

|Type   |Required|Position|PipelineInput|Aliases                |
|-------|--------|--------|-------------|-----------------------|
|`[int]`|false   |1       |false        |center_width_percentage|

#### **FilterName**

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[string]`|false   |15      |true (ByPropertyName)|

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **IncludeClouds**

|Type      |Required|Position|PipelineInput|Aliases       |
|----------|--------|--------|-------------|--------------|
|`[switch]`|false   |Named   |false        |Include_Clouds|

#### **IncludeMoon**

|Type      |Required|Position|PipelineInput|Aliases     |
|----------|--------|--------|-------------|------------|
|`[switch]`|false   |Named   |false        |Include_Moon|

#### **LIGHTSKY**

|Type      |Required|Position|PipelineInput|Aliases  |
|----------|--------|--------|-------------|---------|
|`[string]`|false   |7       |false        |LIGHT_SKY|

#### **MOONCOLOR**

|Type      |Required|Position|PipelineInput|Aliases   |
|----------|--------|--------|-------------|----------|
|`[string]`|false   |9       |false        |MOON_COLOR|

#### **MoonBumpSize**

|Type     |Required|Position|PipelineInput|Aliases       |
|---------|--------|--------|-------------|--------------|
|`[float]`|false   |11      |false        |moon_bump_size|

#### **MoonPositionX**

|Type     |Required|Position|PipelineInput|Aliases        |
|---------|--------|--------|-------------|---------------|
|`[float]`|false   |12      |false        |Moon_Position_x|

#### **MoonPositionY**

|Type     |Required|Position|PipelineInput|Aliases        |
|---------|--------|--------|-------------|---------------|
|`[float]`|false   |13      |false        |Moon_Position_y|

#### **MoonSize**

|Type     |Required|Position|PipelineInput|Aliases  |
|---------|--------|--------|-------------|---------|
|`[float]`|false   |10      |false        |moon_size|

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **NumberStars**

|Type   |Required|Position|PipelineInput|Aliases     |
|-------|--------|--------|-------------|------------|
|`[int]`|false   |4       |false        |number_stars|

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **ReplaceImageColor**

|Type      |Required|Position|PipelineInput|Aliases            |
|----------|--------|--------|-------------|-------------------|
|`[switch]`|false   |Named   |false        |Replace_Image_Color|

#### **SKYCOLOR**

|Type      |Required|Position|PipelineInput|Aliases  |
|----------|--------|--------|-------------|---------|
|`[string]`|false   |5       |false        |SKY_COLOR|

#### **SKYLIGHTNESS**

|Type     |Required|Position|PipelineInput|Aliases      |
|---------|--------|--------|-------------|-------------|
|`[float]`|false   |8       |false        |SKY_LIGHTNESS|

#### **STARCOLOR**

|Type      |Required|Position|PipelineInput|Aliases   |
|----------|--------|--------|-------------|----------|
|`[string]`|false   |6       |false        |STAR_COLOR|

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[string]`|false   |16      |false        |ShaderContent|

#### **SourceName**

|Type      |Required|Position|PipelineInput        |Aliases      |
|----------|--------|--------|---------------------|-------------|
|`[string]`|false   |14      |true (ByPropertyName)|SceneItemName|

#### **Speed**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[float]`|false   |0       |false        |

#### **UseShaderTime**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

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
{@{name=Get-OBSNightSkyShader; CommonParameters=True; parameter=System.Object[]}}
```
