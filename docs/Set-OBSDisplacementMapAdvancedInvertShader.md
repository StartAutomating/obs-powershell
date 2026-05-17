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
|`[switch]`|false   |Named   |false        |alpha_affects_strength|

#### **ApplyAlpha**

|Type      |Required|Position|PipelineInput|Aliases    |
|----------|--------|--------|-------------|-----------|
|`[switch]`|false   |Named   |false        |apply_alpha|

#### **BackgroundLayer**

|Type      |Required|Position|PipelineInput|Aliases         |
|----------|--------|--------|-------------|----------------|
|`[string]`|false   |14      |false        |background_layer|

#### **BlueAffectsBlur**

|Type      |Required|Position|PipelineInput|Aliases          |
|----------|--------|--------|-------------|-----------------|
|`[switch]`|false   |Named   |false        |blue_affects_blur|

#### **BlueAffectsColorize**

|Type      |Required|Position|PipelineInput|Aliases              |
|----------|--------|--------|-------------|---------------------|
|`[switch]`|false   |Named   |false        |blue_affects_colorize|

#### **BlueAffectsStrength**

|Type      |Required|Position|PipelineInput|Aliases              |
|----------|--------|--------|-------------|---------------------|
|`[switch]`|false   |Named   |false        |blue_affects_strength|

#### **BlurAngle**

|Type     |Required|Position|PipelineInput|Aliases   |
|---------|--------|--------|-------------|----------|
|`[float]`|false   |8       |false        |blur_angle|

#### **BlurDirections**

|Type     |Required|Position|PipelineInput|Aliases        |
|---------|--------|--------|-------------|---------------|
|`[float]`|false   |7       |false        |blur_directions|

#### **BlurInfo**

|Type      |Required|Position|PipelineInput|Aliases  |
|----------|--------|--------|-------------|---------|
|`[string]`|false   |4       |false        |blur_info|

#### **BlurQuality**

|Type     |Required|Position|PipelineInput|Aliases     |
|---------|--------|--------|-------------|------------|
|`[float]`|false   |6       |false        |blur_quality|

#### **BlurSize**

|Type     |Required|Position|PipelineInput|Aliases  |
|---------|--------|--------|-------------|---------|
|`[float]`|false   |5       |false        |blur_size|

#### **ChromaticAberration**

|Type     |Required|Position|PipelineInput|Aliases             |
|---------|--------|--------|-------------|--------------------|
|`[float]`|false   |10      |false        |chromatic_aberration|

#### **ChromaticAberrationInfo**

|Type      |Required|Position|PipelineInput|Aliases                  |
|----------|--------|--------|-------------|-------------------------|
|`[string]`|false   |9       |false        |chromatic_aberration_info|

#### **ColorizeColor**

|Type      |Required|Position|PipelineInput|Aliases       |
|----------|--------|--------|-------------|--------------|
|`[string]`|false   |12      |false        |colorize_color|

#### **ColorizeInfo**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[string]`|false   |11      |false        |colorize_info|

#### **DisplacementCurve**

|Type   |Required|Position|PipelineInput|Aliases           |
|-------|--------|--------|-------------|------------------|
|`[int]`|false   |3       |false        |displacement_curve|

#### **DisplacementInfo**

|Type      |Required|Position|PipelineInput|Aliases          |
|----------|--------|--------|-------------|-----------------|
|`[string]`|false   |0       |false        |displacement_info|

#### **DisplacementX**

|Type     |Required|Position|PipelineInput|Aliases       |
|---------|--------|--------|-------------|--------------|
|`[float]`|false   |1       |false        |displacement_x|

#### **DisplacementY**

|Type     |Required|Position|PipelineInput|Aliases       |
|---------|--------|--------|-------------|--------------|
|`[float]`|false   |2       |false        |displacement_y|

#### **FilterName**

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[string]`|false   |16      |true (ByPropertyName)|

#### **FlagsInfo**

|Type      |Required|Position|PipelineInput|Aliases   |
|----------|--------|--------|-------------|----------|
|`[string]`|false   |13      |false        |flags_info|

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

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
|`[string]`|false   |17      |false        |ShaderContent|

#### **SourceName**

|Type      |Required|Position|PipelineInput        |Aliases      |
|----------|--------|--------|---------------------|-------------|
|`[string]`|false   |15      |true (ByPropertyName)|SceneItemName|

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
{@{name=Get-OBSDisplacementMapAdvancedInvertShader; CommonParameters=True; parameter=System.Object[]}}
```
