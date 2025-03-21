Get-OBSEmbossColorShader
------------------------

### Synopsis
Get-OBSEmbossColorShader [[-AngleSteps] <int>] [[-RadiusSteps] <int>] [[-AmpFactor] <float>] [[-UpDownPercent] <int>] [[-Notes] <string>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-ApplyToAlphaLayer] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **AmpFactor**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[Float]`|false   |named   |False        |

#### **AngleSteps**

|Type   |Required|Position|PipelineInput|Aliases    |
|-------|--------|--------|-------------|-----------|
|`[Int]`|false   |named   |False        |Angle_Steps|

#### **ApplyToAlphaLayer**

|Type      |Required|Position|PipelineInput|Aliases             |
|----------|--------|--------|-------------|--------------------|
|`[Switch]`|false   |named   |False        |Apply_To_Alpha_Layer|

#### **FilterName**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |False        |

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

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

#### **RadiusSteps**

|Type   |Required|Position|PipelineInput|Aliases     |
|-------|--------|--------|-------------|------------|
|`[Int]`|false   |named   |False        |Radius_Steps|

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[String]`|false   |named   |False        |ShaderContent|

#### **SourceName**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[String]`|false   |named   |False        |SceneItemName|

#### **UpDownPercent**

|Type   |Required|Position|PipelineInput|Aliases        |
|-------|--------|--------|-------------|---------------|
|`[Int]`|false   |named   |False        |Up_Down_Percent|

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
Get-OBSEmbossColorShader [[-AngleSteps] <Int>] [[-RadiusSteps] <Int>] [[-AmpFactor] <Float>] [[-UpDownPercent] <Int>] [-ApplyToAlphaLayer <Switch>] [[-Notes] <String>] [[-SourceName] <String>] [[-FilterName] <String>] [[-ShaderText] <String>] [-Force <Switch>] [-PassThru <Switch>] [-NoResponse <Switch>] [-UseShaderTime <Switch>] [<CommonParameters>]
```
