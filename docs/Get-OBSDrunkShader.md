Get-OBSDrunkShader
------------------

### Synopsis
Get-OBSDrunkShader [[-ColorMatrix] <float[][]>] [[-GlowPercent] <int>] [[-Blur] <int>] [[-MinBrightness] <int>] [[-MaxBrightness] <int>] [[-PulseSpeedPercent] <int>] [[-GlowColor] <string>] [[-Notes] <string>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-ApplyToAlphaLayer] [-Ease] [-Glitch] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **ApplyToAlphaLayer**

|Type      |Required|Position|PipelineInput|Aliases             |
|----------|--------|--------|-------------|--------------------|
|`[Switch]`|false   |named   |False        |Apply_To_Alpha_Layer|

#### **Blur**

|Type   |Required|Position|PipelineInput|
|-------|--------|--------|-------------|
|`[Int]`|false   |named   |False        |

#### **ColorMatrix**

|Type                 |Required|Position|PipelineInput|Aliases     |
|---------------------|--------|--------|-------------|------------|
|`[System.Single[][]]`|false   |named   |False        |color_matrix|

#### **Ease**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **FilterName**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |False        |

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **Glitch**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **GlowColor**

|Type      |Required|Position|PipelineInput|Aliases   |
|----------|--------|--------|-------------|----------|
|`[String]`|false   |named   |False        |glow_color|

#### **GlowPercent**

|Type   |Required|Position|PipelineInput|Aliases     |
|-------|--------|--------|-------------|------------|
|`[Int]`|false   |named   |False        |glow_percent|

#### **MaxBrightness**

|Type   |Required|Position|PipelineInput|Aliases       |
|-------|--------|--------|-------------|--------------|
|`[Int]`|false   |named   |False        |max_brightness|

#### **MinBrightness**

|Type   |Required|Position|PipelineInput|Aliases       |
|-------|--------|--------|-------------|--------------|
|`[Int]`|false   |named   |False        |min_brightness|

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

#### **PulseSpeedPercent**

|Type   |Required|Position|PipelineInput|Aliases            |
|-------|--------|--------|-------------|-------------------|
|`[Int]`|false   |named   |False        |pulse_speed_percent|

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

---

### Inputs
System.String

---

### Outputs
* [Object](https://learn.microsoft.com/en-us/dotnet/api/System.Object)

---

### Syntax
```PowerShell
Get-OBSDrunkShader [[-ColorMatrix] <System.Single[][]>] [[-GlowPercent] <Int>] [[-Blur] <Int>] [[-MinBrightness] <Int>] [[-MaxBrightness] <Int>] [[-PulseSpeedPercent] <Int>] [-ApplyToAlphaLayer <Switch>] [[-GlowColor] <String>] [-Ease <Switch>] [-Glitch <Switch>] [[-Notes] <String>] [[-SourceName] <String>] [[-FilterName] <String>] [[-ShaderText] <String>] [-Force <Switch>] [-PassThru <Switch>] [-NoResponse <Switch>] [-UseShaderTime <Switch>] [<CommonParameters>]
```
