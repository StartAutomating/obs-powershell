Get-OBSGradientShader
---------------------

### Synopsis
Get-OBSGradientShader [[-StartColor] <string>] [[-StartStep] <float>] [[-MiddleColor] <string>] [[-MiddleStep] <float>] [[-EndColor] <string>] [[-EndStep] <float>] [[-AlphaPercent] <int>] [[-PulseSpeed] <int>] [[-ColorToReplace] <string>] [[-GradientCenterWidthPercentage] <int>] [[-GradientCenterHeightPercentage] <int>] [[-Notes] <string>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-Ease] [-RotateColors] [-ApplyToAlphaLayer] [-ApplyToSpecificColor] [-Horizontal] [-Vertical] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **AlphaPercent**

|Type   |Required|Position|PipelineInput|Aliases      |
|-------|--------|--------|-------------|-------------|
|`[Int]`|false   |named   |False        |alpha_percent|

#### **ApplyToAlphaLayer**

|Type      |Required|Position|PipelineInput|Aliases             |
|----------|--------|--------|-------------|--------------------|
|`[Switch]`|false   |named   |False        |Apply_To_Alpha_Layer|

#### **ApplyToSpecificColor**

|Type      |Required|Position|PipelineInput|Aliases                |
|----------|--------|--------|-------------|-----------------------|
|`[Switch]`|false   |named   |False        |Apply_To_Specific_Color|

#### **ColorToReplace**

|Type      |Required|Position|PipelineInput|Aliases         |
|----------|--------|--------|-------------|----------------|
|`[String]`|false   |named   |False        |Color_To_Replace|

#### **Ease**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **EndColor**

|Type      |Required|Position|PipelineInput|Aliases  |
|----------|--------|--------|-------------|---------|
|`[String]`|false   |named   |False        |end_color|

#### **EndStep**

|Type     |Required|Position|PipelineInput|Aliases |
|---------|--------|--------|-------------|--------|
|`[Float]`|false   |named   |False        |end_step|

#### **FilterName**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |False        |

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **GradientCenterHeightPercentage**

|Type   |Required|Position|PipelineInput|Aliases                          |
|-------|--------|--------|-------------|---------------------------------|
|`[Int]`|false   |named   |False        |gradient_center_height_percentage|

#### **GradientCenterWidthPercentage**

|Type   |Required|Position|PipelineInput|Aliases                         |
|-------|--------|--------|-------------|--------------------------------|
|`[Int]`|false   |named   |False        |gradient_center_width_percentage|

#### **Horizontal**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **MiddleColor**

|Type      |Required|Position|PipelineInput|Aliases     |
|----------|--------|--------|-------------|------------|
|`[String]`|false   |named   |False        |middle_color|

#### **MiddleStep**

|Type     |Required|Position|PipelineInput|Aliases    |
|---------|--------|--------|-------------|-----------|
|`[Float]`|false   |named   |False        |middle_step|

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

#### **PulseSpeed**

|Type   |Required|Position|PipelineInput|Aliases    |
|-------|--------|--------|-------------|-----------|
|`[Int]`|false   |named   |False        |pulse_speed|

#### **RotateColors**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[Switch]`|false   |named   |False        |rotate_colors|

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[String]`|false   |named   |False        |ShaderContent|

#### **SourceName**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[String]`|false   |named   |False        |SceneItemName|

#### **StartColor**

|Type      |Required|Position|PipelineInput|Aliases    |
|----------|--------|--------|-------------|-----------|
|`[String]`|false   |named   |False        |start_color|

#### **StartStep**

|Type     |Required|Position|PipelineInput|Aliases   |
|---------|--------|--------|-------------|----------|
|`[Float]`|false   |named   |False        |start_step|

#### **UseShaderTime**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **Vertical**

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
Get-OBSGradientShader [[-StartColor] <String>] [[-StartStep] <Float>] [[-MiddleColor] <String>] [[-MiddleStep] <Float>] [[-EndColor] <String>] [[-EndStep] <Float>] [[-AlphaPercent] <Int>] [[-PulseSpeed] <Int>] [-Ease <Switch>] [-RotateColors <Switch>] [-ApplyToAlphaLayer <Switch>] [-ApplyToSpecificColor <Switch>] [[-ColorToReplace] <String>] [-Horizontal <Switch>] [-Vertical <Switch>] [[-GradientCenterWidthPercentage] <Int>] [[-GradientCenterHeightPercentage] <Int>] [[-Notes] <String>] [[-SourceName] <String>] [[-FilterName] <String>] [[-ShaderText] <String>] [-Force <Switch>] [-PassThru <Switch>] [-NoResponse <Switch>] [-UseShaderTime <Switch>] [<CommonParameters>]
```
