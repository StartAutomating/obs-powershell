Get-OBSGbCameraShader
---------------------

### Synopsis

Get-OBSGbCameraShader [[-PixelSize] <float>] [[-DitherFactor] <float>] [[-Brightness] <float>] [[-Contrast] <float>] [[-Gamma] <float>] [[-Color1] <string>] [[-Color2] <string>] [[-Color3] <string>] [[-Color4] <string>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-AlternativeBayer] [-Force] [-PassThru] [-NoResponse] [<CommonParameters>]

---

### Description

---

### Parameters
#### **AlternativeBayer**

|Type      |Required|Position|PipelineInput|Aliases          |
|----------|--------|--------|-------------|-----------------|
|`[switch]`|false   |Named   |false        |alternative_bayer|

#### **Brightness**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[float]`|false   |2       |false        |

#### **Color1**

|Type      |Required|Position|PipelineInput|Aliases|
|----------|--------|--------|-------------|-------|
|`[string]`|false   |5       |false        |color_1|

#### **Color2**

|Type      |Required|Position|PipelineInput|Aliases|
|----------|--------|--------|-------------|-------|
|`[string]`|false   |6       |false        |color_2|

#### **Color3**

|Type      |Required|Position|PipelineInput|Aliases|
|----------|--------|--------|-------------|-------|
|`[string]`|false   |7       |false        |color_3|

#### **Color4**

|Type      |Required|Position|PipelineInput|Aliases|
|----------|--------|--------|-------------|-------|
|`[string]`|false   |8       |false        |color_4|

#### **Contrast**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[float]`|false   |3       |false        |

#### **DitherFactor**

|Type     |Required|Position|PipelineInput|Aliases      |
|---------|--------|--------|-------------|-------------|
|`[float]`|false   |1       |false        |dither_factor|

#### **FilterName**

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[string]`|false   |10      |true (ByPropertyName)|

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **Gamma**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[float]`|false   |4       |false        |

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **PixelSize**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[float]`|false   |0       |false        |

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[string]`|false   |11      |false        |ShaderContent|

#### **SourceName**

|Type      |Required|Position|PipelineInput        |Aliases      |
|----------|--------|--------|---------------------|-------------|
|`[string]`|false   |9       |true (ByPropertyName)|SceneItemName|

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
{@{name=Get-OBSGbCameraShader; CommonParameters=True; parameter=System.Object[]}}
```
