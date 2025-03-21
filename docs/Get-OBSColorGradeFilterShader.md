Get-OBSColorGradeFilterShader
-----------------------------

### Synopsis
Get-OBSColorGradeFilterShader [[-Notes] <string>] [[-Lut] <string>] [[-LutAmountPercent] <int>] [[-LutScalePercent] <int>] [[-LutOffsetPercent] <int>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **FilterName**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |False        |

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **Lut**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |False        |

#### **LutAmountPercent**

|Type   |Required|Position|PipelineInput|Aliases           |
|-------|--------|--------|-------------|------------------|
|`[Int]`|false   |named   |False        |lut_amount_percent|

#### **LutOffsetPercent**

|Type   |Required|Position|PipelineInput|Aliases           |
|-------|--------|--------|-------------|------------------|
|`[Int]`|false   |named   |False        |lut_offset_percent|

#### **LutScalePercent**

|Type   |Required|Position|PipelineInput|Aliases          |
|-------|--------|--------|-------------|-----------------|
|`[Int]`|false   |named   |False        |lut_scale_percent|

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
Get-OBSColorGradeFilterShader [[-Notes] <String>] [[-Lut] <String>] [[-LutAmountPercent] <Int>] [[-LutScalePercent] <Int>] [[-LutOffsetPercent] <Int>] [[-SourceName] <String>] [[-FilterName] <String>] [[-ShaderText] <String>] [-Force <Switch>] [-PassThru <Switch>] [-NoResponse <Switch>] [-UseShaderTime <Switch>] [<CommonParameters>]
```
