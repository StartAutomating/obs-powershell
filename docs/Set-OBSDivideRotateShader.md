Get-OBSDivideRotateShader
-------------------------

### Synopsis
Get-OBSDivideRotateShader [[-IChannel0] <string>] [[-SpeedPercentage] <int>] [[-AlphaPercentage] <int>] [[-Notes] <string>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-ApplyToAlphaLayer] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **AlphaPercentage**

|Type   |Required|Position|PipelineInput|Aliases         |
|-------|--------|--------|-------------|----------------|
|`[Int]`|false   |named   |False        |alpha_percentage|

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

#### **IChannel0**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |False        |

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

#### **SpeedPercentage**

|Type   |Required|Position|PipelineInput|Aliases         |
|-------|--------|--------|-------------|----------------|
|`[Int]`|false   |named   |False        |speed_percentage|

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
Get-OBSDivideRotateShader [[-IChannel0] <String>] [[-SpeedPercentage] <Int>] [[-AlphaPercentage] <Int>] [-ApplyToAlphaLayer <Switch>] [[-Notes] <String>] [[-SourceName] <String>] [[-FilterName] <String>] [[-ShaderText] <String>] [-Force <Switch>] [-PassThru <Switch>] [-NoResponse <Switch>] [-UseShaderTime <Switch>] [<CommonParameters>]
```
