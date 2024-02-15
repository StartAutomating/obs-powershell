Get-OBSGlitchAnalogShader
-------------------------

### Synopsis

Get-OBSGlitchAnalogShader [[-ScanLineJitterDisplacement] <float>] [[-ScanLineJitterThresholdPercent] <int>] [[-VerticalJumpAmount] <float>] [[-VerticalSpeed] <float>] [[-HorizontalShake] <float>] [[-ColorDriftAmount] <float>] [[-ColorDriftSpeed] <float>] [[-PulseSpeedPercent] <int>] [[-AlphaPercent] <int>] [[-ColorToReplace] <string>] [[-Notes] <string>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-RotateColors] [-ApplyToAlphaLayer] [-ReplaceImageColor] [-ApplyToSpecificColor] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **AlphaPercent**

|Type   |Required|Position|PipelineInput|Aliases      |
|-------|--------|--------|-------------|-------------|
|`[int]`|false   |8       |false        |alpha_percent|

#### **ApplyToAlphaLayer**

|Type      |Required|Position|PipelineInput|Aliases             |
|----------|--------|--------|-------------|--------------------|
|`[switch]`|false   |Named   |false        |Apply_To_Alpha_Layer|

#### **ApplyToSpecificColor**

|Type      |Required|Position|PipelineInput|Aliases                |
|----------|--------|--------|-------------|-----------------------|
|`[switch]`|false   |Named   |false        |Apply_To_Specific_Color|

#### **ColorDriftAmount**

|Type     |Required|Position|PipelineInput|Aliases           |
|---------|--------|--------|-------------|------------------|
|`[float]`|false   |5       |false        |color_drift_amount|

#### **ColorDriftSpeed**

|Type     |Required|Position|PipelineInput|Aliases          |
|---------|--------|--------|-------------|-----------------|
|`[float]`|false   |6       |false        |color_drift_speed|

#### **ColorToReplace**

|Type      |Required|Position|PipelineInput|Aliases         |
|----------|--------|--------|-------------|----------------|
|`[string]`|false   |9       |false        |Color_To_Replace|

#### **FilterName**

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[string]`|false   |12      |true (ByPropertyName)|

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **HorizontalShake**

|Type     |Required|Position|PipelineInput|Aliases         |
|---------|--------|--------|-------------|----------------|
|`[float]`|false   |4       |false        |horizontal_shake|

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **Notes**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[string]`|false   |10      |false        |

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **PulseSpeedPercent**

|Type   |Required|Position|PipelineInput|Aliases            |
|-------|--------|--------|-------------|-------------------|
|`[int]`|false   |7       |false        |pulse_speed_percent|

#### **ReplaceImageColor**

|Type      |Required|Position|PipelineInput|Aliases            |
|----------|--------|--------|-------------|-------------------|
|`[switch]`|false   |Named   |false        |Replace_Image_Color|

#### **RotateColors**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[switch]`|false   |Named   |false        |rotate_colors|

#### **ScanLineJitterDisplacement**

|Type     |Required|Position|PipelineInput|Aliases                      |
|---------|--------|--------|-------------|-----------------------------|
|`[float]`|false   |0       |false        |scan_line_jitter_displacement|

#### **ScanLineJitterThresholdPercent**

|Type   |Required|Position|PipelineInput|Aliases                           |
|-------|--------|--------|-------------|----------------------------------|
|`[int]`|false   |1       |false        |scan_line_jitter_threshold_percent|

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[string]`|false   |13      |false        |ShaderContent|

#### **SourceName**

|Type      |Required|Position|PipelineInput        |Aliases      |
|----------|--------|--------|---------------------|-------------|
|`[string]`|false   |11      |true (ByPropertyName)|SceneItemName|

#### **UseShaderTime**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **VerticalJumpAmount**

|Type     |Required|Position|PipelineInput|Aliases             |
|---------|--------|--------|-------------|--------------------|
|`[float]`|false   |2       |false        |vertical_jump_amount|

#### **VerticalSpeed**

|Type     |Required|Position|PipelineInput|Aliases       |
|---------|--------|--------|-------------|--------------|
|`[float]`|false   |3       |false        |vertical_speed|

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
{@{name=Get-OBSGlitchAnalogShader; CommonParameters=True; parameter=System.Object[]}}
```
