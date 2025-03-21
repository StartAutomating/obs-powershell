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
|`[Float]`|false   |named   |False        |Alpha_Percentage|

#### **ApplyToImage**

|Type      |Required|Position|PipelineInput|Aliases       |
|----------|--------|--------|-------------|--------------|
|`[Switch]`|false   |named   |False        |Apply_To_Image|

#### **CenterHeightPercentage**

|Type   |Required|Position|PipelineInput|Aliases                 |
|-------|--------|--------|-------------|------------------------|
|`[Int]`|false   |named   |False        |center_height_percentage|

#### **CenterWidthPercentage**

|Type   |Required|Position|PipelineInput|Aliases                |
|-------|--------|--------|-------------|-----------------------|
|`[Int]`|false   |named   |False        |center_width_percentage|

#### **FilterName**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |False        |

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **IncludeClouds**

|Type      |Required|Position|PipelineInput|Aliases       |
|----------|--------|--------|-------------|--------------|
|`[Switch]`|false   |named   |False        |Include_Clouds|

#### **IncludeMoon**

|Type      |Required|Position|PipelineInput|Aliases     |
|----------|--------|--------|-------------|------------|
|`[Switch]`|false   |named   |False        |Include_Moon|

#### **LIGHTSKY**

|Type      |Required|Position|PipelineInput|Aliases  |
|----------|--------|--------|-------------|---------|
|`[String]`|false   |named   |False        |LIGHT_SKY|

#### **MoonBumpSize**

|Type     |Required|Position|PipelineInput|Aliases       |
|---------|--------|--------|-------------|--------------|
|`[Float]`|false   |named   |False        |moon_bump_size|

#### **MOONCOLOR**

|Type      |Required|Position|PipelineInput|Aliases   |
|----------|--------|--------|-------------|----------|
|`[String]`|false   |named   |False        |MOON_COLOR|

#### **MoonPositionX**

|Type     |Required|Position|PipelineInput|Aliases        |
|---------|--------|--------|-------------|---------------|
|`[Float]`|false   |named   |False        |Moon_Position_x|

#### **MoonPositionY**

|Type     |Required|Position|PipelineInput|Aliases        |
|---------|--------|--------|-------------|---------------|
|`[Float]`|false   |named   |False        |Moon_Position_y|

#### **MoonSize**

|Type     |Required|Position|PipelineInput|Aliases  |
|---------|--------|--------|-------------|---------|
|`[Float]`|false   |named   |False        |moon_size|

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **NumberStars**

|Type   |Required|Position|PipelineInput|Aliases     |
|-------|--------|--------|-------------|------------|
|`[Int]`|false   |named   |False        |number_stars|

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **ReplaceImageColor**

|Type      |Required|Position|PipelineInput|Aliases            |
|----------|--------|--------|-------------|-------------------|
|`[Switch]`|false   |named   |False        |Replace_Image_Color|

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[String]`|false   |named   |False        |ShaderContent|

#### **SKYCOLOR**

|Type      |Required|Position|PipelineInput|Aliases  |
|----------|--------|--------|-------------|---------|
|`[String]`|false   |named   |False        |SKY_COLOR|

#### **SKYLIGHTNESS**

|Type     |Required|Position|PipelineInput|Aliases      |
|---------|--------|--------|-------------|-------------|
|`[Float]`|false   |named   |False        |SKY_LIGHTNESS|

#### **SourceName**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[String]`|false   |named   |False        |SceneItemName|

#### **Speed**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[Float]`|false   |named   |False        |

#### **STARCOLOR**

|Type      |Required|Position|PipelineInput|Aliases   |
|----------|--------|--------|-------------|----------|
|`[String]`|false   |named   |False        |STAR_COLOR|

#### **UseShaderTime**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

---

### Inputs
System.String

---

### Outputs
* [Object](https://learn.microsoft.com/en-us/dotnet/api/System.Object)

---

### Syntax
```PowerShell
Get-OBSNightSkyShader [[-Speed] <Float>] [-IncludeClouds <Switch>] [-IncludeMoon <Switch>] [[-CenterWidthPercentage] <Int>] [[-CenterHeightPercentage] <Int>] [[-AlphaPercentage] <Float>] [-ApplyToImage <Switch>] [-ReplaceImageColor <Switch>] [[-NumberStars] <Int>] [[-SKYCOLOR] <String>] [[-STARCOLOR] <String>] [[-LIGHTSKY] <String>] [[-SKYLIGHTNESS] <Float>] [[-MOONCOLOR] <String>] [[-MoonSize] <Float>] [[-MoonBumpSize] <Float>] [[-MoonPositionX] <Float>] [[-MoonPositionY] <Float>] [[-SourceName] <String>] [[-FilterName] <String>] [[-ShaderText] <String>] [-Force <Switch>] [-PassThru <Switch>] [-NoResponse <Switch>] [-UseShaderTime <Switch>] [<CommonParameters>]
```
