Get-OBSDensitySatHueShader
--------------------------

### Synopsis
Get-OBSDensitySatHueShader [[-Notes] <string>] [[-DensityR] <float>] [[-SaturationR] <float>] [[-HueShiftR] <float>] [[-DensityY] <float>] [[-SaturationY] <float>] [[-HueShiftY] <float>] [[-DensityG] <float>] [[-SaturationG] <float>] [[-HueShiftG] <float>] [[-DensityC] <float>] [[-SaturationC] <float>] [[-HueShiftC] <float>] [[-DensityB] <float>] [[-SaturationB] <float>] [[-HueShiftB] <float>] [[-DensityM] <float>] [[-SaturationM] <float>] [[-HueShiftM] <float>] [[-GlobalDensity] <float>] [[-GlobalSaturation] <float>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **DensityB**

|Type     |Required|Position|PipelineInput|Aliases  |
|---------|--------|--------|-------------|---------|
|`[Float]`|false   |named   |False        |density_b|

#### **DensityC**

|Type     |Required|Position|PipelineInput|Aliases  |
|---------|--------|--------|-------------|---------|
|`[Float]`|false   |named   |False        |density_c|

#### **DensityG**

|Type     |Required|Position|PipelineInput|Aliases  |
|---------|--------|--------|-------------|---------|
|`[Float]`|false   |named   |False        |density_g|

#### **DensityM**

|Type     |Required|Position|PipelineInput|Aliases  |
|---------|--------|--------|-------------|---------|
|`[Float]`|false   |named   |False        |density_m|

#### **DensityR**

|Type     |Required|Position|PipelineInput|Aliases  |
|---------|--------|--------|-------------|---------|
|`[Float]`|false   |named   |False        |density_r|

#### **DensityY**

|Type     |Required|Position|PipelineInput|Aliases  |
|---------|--------|--------|-------------|---------|
|`[Float]`|false   |named   |False        |density_y|

#### **FilterName**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |False        |

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **GlobalDensity**

|Type     |Required|Position|PipelineInput|Aliases       |
|---------|--------|--------|-------------|--------------|
|`[Float]`|false   |named   |False        |global_density|

#### **GlobalSaturation**

|Type     |Required|Position|PipelineInput|Aliases          |
|---------|--------|--------|-------------|-----------------|
|`[Float]`|false   |named   |False        |global_saturation|

#### **HueShiftB**

|Type     |Required|Position|PipelineInput|Aliases   |
|---------|--------|--------|-------------|----------|
|`[Float]`|false   |named   |False        |hueShift_b|

#### **HueShiftC**

|Type     |Required|Position|PipelineInput|Aliases   |
|---------|--------|--------|-------------|----------|
|`[Float]`|false   |named   |False        |hueShift_c|

#### **HueShiftG**

|Type     |Required|Position|PipelineInput|Aliases   |
|---------|--------|--------|-------------|----------|
|`[Float]`|false   |named   |False        |hueShift_g|

#### **HueShiftM**

|Type     |Required|Position|PipelineInput|Aliases   |
|---------|--------|--------|-------------|----------|
|`[Float]`|false   |named   |False        |hueShift_m|

#### **HueShiftR**

|Type     |Required|Position|PipelineInput|Aliases   |
|---------|--------|--------|-------------|----------|
|`[Float]`|false   |named   |False        |hueShift_r|

#### **HueShiftY**

|Type     |Required|Position|PipelineInput|Aliases   |
|---------|--------|--------|-------------|----------|
|`[Float]`|false   |named   |False        |hueShift_y|

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

#### **SaturationB**

|Type     |Required|Position|PipelineInput|Aliases     |
|---------|--------|--------|-------------|------------|
|`[Float]`|false   |named   |False        |saturation_b|

#### **SaturationC**

|Type     |Required|Position|PipelineInput|Aliases     |
|---------|--------|--------|-------------|------------|
|`[Float]`|false   |named   |False        |saturation_c|

#### **SaturationG**

|Type     |Required|Position|PipelineInput|Aliases     |
|---------|--------|--------|-------------|------------|
|`[Float]`|false   |named   |False        |saturation_g|

#### **SaturationM**

|Type     |Required|Position|PipelineInput|Aliases     |
|---------|--------|--------|-------------|------------|
|`[Float]`|false   |named   |False        |saturation_m|

#### **SaturationR**

|Type     |Required|Position|PipelineInput|Aliases     |
|---------|--------|--------|-------------|------------|
|`[Float]`|false   |named   |False        |saturation_r|

#### **SaturationY**

|Type     |Required|Position|PipelineInput|Aliases     |
|---------|--------|--------|-------------|------------|
|`[Float]`|false   |named   |False        |saturation_y|

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
Get-OBSDensitySatHueShader [[-Notes] <String>] [[-DensityR] <Float>] [[-SaturationR] <Float>] [[-HueShiftR] <Float>] [[-DensityY] <Float>] [[-SaturationY] <Float>] [[-HueShiftY] <Float>] [[-DensityG] <Float>] [[-SaturationG] <Float>] [[-HueShiftG] <Float>] [[-DensityC] <Float>] [[-SaturationC] <Float>] [[-HueShiftC] <Float>] [[-DensityB] <Float>] [[-SaturationB] <Float>] [[-HueShiftB] <Float>] [[-DensityM] <Float>] [[-SaturationM] <Float>] [[-HueShiftM] <Float>] [[-GlobalDensity] <Float>] [[-GlobalSaturation] <Float>] [[-SourceName] <String>] [[-FilterName] <String>] [[-ShaderText] <String>] [-Force <Switch>] [-PassThru <Switch>] [-NoResponse <Switch>] [-UseShaderTime <Switch>] [<CommonParameters>]
```
