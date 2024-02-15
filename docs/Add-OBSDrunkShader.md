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
|`[switch]`|false   |Named   |false        |Apply_To_Alpha_Layer|

#### **Blur**

|Type   |Required|Position|PipelineInput|
|-------|--------|--------|-------------|
|`[int]`|false   |2       |false        |

#### **ColorMatrix**

|Type         |Required|Position|PipelineInput|Aliases     |
|-------------|--------|--------|-------------|------------|
|`[float[][]]`|false   |0       |false        |color_matrix|

#### **Ease**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **FilterName**

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[string]`|false   |9       |true (ByPropertyName)|

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **Glitch**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **GlowColor**

|Type      |Required|Position|PipelineInput|Aliases   |
|----------|--------|--------|-------------|----------|
|`[string]`|false   |6       |false        |glow_color|

#### **GlowPercent**

|Type   |Required|Position|PipelineInput|Aliases     |
|-------|--------|--------|-------------|------------|
|`[int]`|false   |1       |false        |glow_percent|

#### **MaxBrightness**

|Type   |Required|Position|PipelineInput|Aliases       |
|-------|--------|--------|-------------|--------------|
|`[int]`|false   |4       |false        |max_brightness|

#### **MinBrightness**

|Type   |Required|Position|PipelineInput|Aliases       |
|-------|--------|--------|-------------|--------------|
|`[int]`|false   |3       |false        |min_brightness|

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **Notes**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[string]`|false   |7       |false        |

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **PulseSpeedPercent**

|Type   |Required|Position|PipelineInput|Aliases            |
|-------|--------|--------|-------------|-------------------|
|`[int]`|false   |5       |false        |pulse_speed_percent|

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[string]`|false   |10      |false        |ShaderContent|

#### **SourceName**

|Type      |Required|Position|PipelineInput        |Aliases      |
|----------|--------|--------|---------------------|-------------|
|`[string]`|false   |8       |true (ByPropertyName)|SceneItemName|

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
{@{name=Get-OBSDrunkShader; CommonParameters=True; parameter=System.Object[]}}
```
