Get-OBSDisplacementMapAdvancedInvertShader
------------------------------------------

### Synopsis
Get-OBSDisplacementMapAdvancedInvertShader [[-DisplacementInfo] <string>] [[-DisplacementX] <float>] [[-DisplacementY] <float>] [[-DisplacementCurve] <int>] [[-BlurInfo] <string>] [[-BlurSize] <float>] [[-BlurQuality] <float>] [[-BlurDirections] <float>] [[-BlurAngle] <float>] [[-ChromaticAberrationInfo] <string>] [[-ChromaticAberration] <float>] [[-ColorizeInfo] <string>] [[-ColorizeColor] <string>] [[-FlagsInfo] <string>] [[-BackgroundLayer] <string>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-BlueAffectsStrength] [-BlueAffectsColorize] [-BlueAffectsBlur] [-AlphaAffectsStrength] [-ApplyAlpha] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **AlphaAffectsStrength**

|Type      |Required|Position|PipelineInput|Aliases               |
|----------|--------|--------|-------------|----------------------|
|`[Switch]`|false   |named   |False        |alpha_affects_strength|

#### **ApplyAlpha**

|Type      |Required|Position|PipelineInput|Aliases    |
|----------|--------|--------|-------------|-----------|
|`[Switch]`|false   |named   |False        |apply_alpha|

#### **BackgroundLayer**

|Type      |Required|Position|PipelineInput|Aliases         |
|----------|--------|--------|-------------|----------------|
|`[String]`|false   |named   |False        |background_layer|

#### **BlueAffectsBlur**

|Type      |Required|Position|PipelineInput|Aliases          |
|----------|--------|--------|-------------|-----------------|
|`[Switch]`|false   |named   |False        |blue_affects_blur|

#### **BlueAffectsColorize**

|Type      |Required|Position|PipelineInput|Aliases              |
|----------|--------|--------|-------------|---------------------|
|`[Switch]`|false   |named   |False        |blue_affects_colorize|

#### **BlueAffectsStrength**

|Type      |Required|Position|PipelineInput|Aliases              |
|----------|--------|--------|-------------|---------------------|
|`[Switch]`|false   |named   |False        |blue_affects_strength|

#### **BlurAngle**

|Type     |Required|Position|PipelineInput|Aliases   |
|---------|--------|--------|-------------|----------|
|`[Float]`|false   |named   |False        |blur_angle|

#### **BlurDirections**

|Type     |Required|Position|PipelineInput|Aliases        |
|---------|--------|--------|-------------|---------------|
|`[Float]`|false   |named   |False        |blur_directions|

#### **BlurInfo**

|Type      |Required|Position|PipelineInput|Aliases  |
|----------|--------|--------|-------------|---------|
|`[String]`|false   |named   |False        |blur_info|

#### **BlurQuality**

|Type     |Required|Position|PipelineInput|Aliases     |
|---------|--------|--------|-------------|------------|
|`[Float]`|false   |named   |False        |blur_quality|

#### **BlurSize**

|Type     |Required|Position|PipelineInput|Aliases  |
|---------|--------|--------|-------------|---------|
|`[Float]`|false   |named   |False        |blur_size|

#### **ChromaticAberration**

|Type     |Required|Position|PipelineInput|Aliases             |
|---------|--------|--------|-------------|--------------------|
|`[Float]`|false   |named   |False        |chromatic_aberration|

#### **ChromaticAberrationInfo**

|Type      |Required|Position|PipelineInput|Aliases                  |
|----------|--------|--------|-------------|-------------------------|
|`[String]`|false   |named   |False        |chromatic_aberration_info|

#### **ColorizeColor**

|Type      |Required|Position|PipelineInput|Aliases       |
|----------|--------|--------|-------------|--------------|
|`[String]`|false   |named   |False        |colorize_color|

#### **ColorizeInfo**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[String]`|false   |named   |False        |colorize_info|

#### **DisplacementCurve**

|Type   |Required|Position|PipelineInput|Aliases           |
|-------|--------|--------|-------------|------------------|
|`[Int]`|false   |named   |False        |displacement_curve|

#### **DisplacementInfo**

|Type      |Required|Position|PipelineInput|Aliases          |
|----------|--------|--------|-------------|-----------------|
|`[String]`|false   |named   |False        |displacement_info|

#### **DisplacementX**

|Type     |Required|Position|PipelineInput|Aliases       |
|---------|--------|--------|-------------|--------------|
|`[Float]`|false   |named   |False        |displacement_x|

#### **DisplacementY**

|Type     |Required|Position|PipelineInput|Aliases       |
|---------|--------|--------|-------------|--------------|
|`[Float]`|false   |named   |False        |displacement_y|

#### **FilterName**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |False        |

#### **FlagsInfo**

|Type      |Required|Position|PipelineInput|Aliases   |
|----------|--------|--------|-------------|----------|
|`[String]`|false   |named   |False        |flags_info|

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

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
Get-OBSDisplacementMapAdvancedInvertShader [[-DisplacementInfo] <String>] [[-DisplacementX] <Float>] [[-DisplacementY] <Float>] [[-DisplacementCurve] <Int>] [[-BlurInfo] <String>] [[-BlurSize] <Float>] [[-BlurQuality] <Float>] [[-BlurDirections] <Float>] [[-BlurAngle] <Float>] [[-ChromaticAberrationInfo] <String>] [[-ChromaticAberration] <Float>] [[-ColorizeInfo] <String>] [[-ColorizeColor] <String>] [[-FlagsInfo] <String>] [-BlueAffectsStrength <Switch>] [-BlueAffectsColorize <Switch>] [-BlueAffectsBlur <Switch>] [-AlphaAffectsStrength <Switch>] [-ApplyAlpha <Switch>] [[-BackgroundLayer] <String>] [[-SourceName] <String>] [[-FilterName] <String>] [[-ShaderText] <String>] [-Force <Switch>] [-PassThru <Switch>] [-NoResponse <Switch>] [-UseShaderTime <Switch>] [<CommonParameters>]
```
