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
|`[float]`|false   |13      |false        |density_b|

#### **DensityC**

|Type     |Required|Position|PipelineInput|Aliases  |
|---------|--------|--------|-------------|---------|
|`[float]`|false   |10      |false        |density_c|

#### **DensityG**

|Type     |Required|Position|PipelineInput|Aliases  |
|---------|--------|--------|-------------|---------|
|`[float]`|false   |7       |false        |density_g|

#### **DensityM**

|Type     |Required|Position|PipelineInput|Aliases  |
|---------|--------|--------|-------------|---------|
|`[float]`|false   |16      |false        |density_m|

#### **DensityR**

|Type     |Required|Position|PipelineInput|Aliases  |
|---------|--------|--------|-------------|---------|
|`[float]`|false   |1       |false        |density_r|

#### **DensityY**

|Type     |Required|Position|PipelineInput|Aliases  |
|---------|--------|--------|-------------|---------|
|`[float]`|false   |4       |false        |density_y|

#### **FilterName**

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[string]`|false   |22      |true (ByPropertyName)|

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **GlobalDensity**

|Type     |Required|Position|PipelineInput|Aliases       |
|---------|--------|--------|-------------|--------------|
|`[float]`|false   |19      |false        |global_density|

#### **GlobalSaturation**

|Type     |Required|Position|PipelineInput|Aliases          |
|---------|--------|--------|-------------|-----------------|
|`[float]`|false   |20      |false        |global_saturation|

#### **HueShiftB**

|Type     |Required|Position|PipelineInput|Aliases   |
|---------|--------|--------|-------------|----------|
|`[float]`|false   |15      |false        |hueShift_b|

#### **HueShiftC**

|Type     |Required|Position|PipelineInput|Aliases   |
|---------|--------|--------|-------------|----------|
|`[float]`|false   |12      |false        |hueShift_c|

#### **HueShiftG**

|Type     |Required|Position|PipelineInput|Aliases   |
|---------|--------|--------|-------------|----------|
|`[float]`|false   |9       |false        |hueShift_g|

#### **HueShiftM**

|Type     |Required|Position|PipelineInput|Aliases   |
|---------|--------|--------|-------------|----------|
|`[float]`|false   |18      |false        |hueShift_m|

#### **HueShiftR**

|Type     |Required|Position|PipelineInput|Aliases   |
|---------|--------|--------|-------------|----------|
|`[float]`|false   |3       |false        |hueShift_r|

#### **HueShiftY**

|Type     |Required|Position|PipelineInput|Aliases   |
|---------|--------|--------|-------------|----------|
|`[float]`|false   |6       |false        |hueShift_y|

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **Notes**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[string]`|false   |0       |false        |

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **SaturationB**

|Type     |Required|Position|PipelineInput|Aliases     |
|---------|--------|--------|-------------|------------|
|`[float]`|false   |14      |false        |saturation_b|

#### **SaturationC**

|Type     |Required|Position|PipelineInput|Aliases     |
|---------|--------|--------|-------------|------------|
|`[float]`|false   |11      |false        |saturation_c|

#### **SaturationG**

|Type     |Required|Position|PipelineInput|Aliases     |
|---------|--------|--------|-------------|------------|
|`[float]`|false   |8       |false        |saturation_g|

#### **SaturationM**

|Type     |Required|Position|PipelineInput|Aliases     |
|---------|--------|--------|-------------|------------|
|`[float]`|false   |17      |false        |saturation_m|

#### **SaturationR**

|Type     |Required|Position|PipelineInput|Aliases     |
|---------|--------|--------|-------------|------------|
|`[float]`|false   |2       |false        |saturation_r|

#### **SaturationY**

|Type     |Required|Position|PipelineInput|Aliases     |
|---------|--------|--------|-------------|------------|
|`[float]`|false   |5       |false        |saturation_y|

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[string]`|false   |23      |false        |ShaderContent|

#### **SourceName**

|Type      |Required|Position|PipelineInput        |Aliases      |
|----------|--------|--------|---------------------|-------------|
|`[string]`|false   |21      |true (ByPropertyName)|SceneItemName|

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
{@{name=Get-OBSDensitySatHueShader; CommonParameters=True; parameter=System.Object[]}}
```
