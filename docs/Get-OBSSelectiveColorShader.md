Get-OBSSelectiveColorShader
---------------------------

### Synopsis
Get-OBSSelectiveColorShader [[-CutoffRed] <float>] [[-CutoffGreen] <float>] [[-CutoffBlue] <float>] [[-CutoffYellow] <float>] [[-AcceptanceAmplifier] <float>] [[-Notes] <string>] [[-BackgroundType] <int>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-ShowRed] [-ShowGreen] [-ShowBlue] [-ShowYellow] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **AcceptanceAmplifier**

|Type     |Required|Position|PipelineInput|Aliases             |
|---------|--------|--------|-------------|--------------------|
|`[Float]`|false   |named   |False        |acceptance_Amplifier|

#### **BackgroundType**

|Type   |Required|Position|PipelineInput|Aliases        |
|-------|--------|--------|-------------|---------------|
|`[Int]`|false   |named   |False        |background_type|

#### **CutoffBlue**

|Type     |Required|Position|PipelineInput|Aliases    |
|---------|--------|--------|-------------|-----------|
|`[Float]`|false   |named   |False        |cutoff_Blue|

#### **CutoffGreen**

|Type     |Required|Position|PipelineInput|Aliases     |
|---------|--------|--------|-------------|------------|
|`[Float]`|false   |named   |False        |cutoff_Green|

#### **CutoffRed**

|Type     |Required|Position|PipelineInput|Aliases   |
|---------|--------|--------|-------------|----------|
|`[Float]`|false   |named   |False        |cutoff_Red|

#### **CutoffYellow**

|Type     |Required|Position|PipelineInput|Aliases      |
|---------|--------|--------|-------------|-------------|
|`[Float]`|false   |named   |False        |cutoff_Yellow|

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

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[String]`|false   |named   |False        |ShaderContent|

#### **ShowBlue**

|Type      |Required|Position|PipelineInput|Aliases  |
|----------|--------|--------|-------------|---------|
|`[Switch]`|false   |named   |False        |show_Blue|

#### **ShowGreen**

|Type      |Required|Position|PipelineInput|Aliases   |
|----------|--------|--------|-------------|----------|
|`[Switch]`|false   |named   |False        |show_Green|

#### **ShowRed**

|Type      |Required|Position|PipelineInput|Aliases |
|----------|--------|--------|-------------|--------|
|`[Switch]`|false   |named   |False        |show_Red|

#### **ShowYellow**

|Type      |Required|Position|PipelineInput|Aliases    |
|----------|--------|--------|-------------|-----------|
|`[Switch]`|false   |named   |False        |show_Yellow|

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
Get-OBSSelectiveColorShader [[-CutoffRed] <Float>] [[-CutoffGreen] <Float>] [[-CutoffBlue] <Float>] [[-CutoffYellow] <Float>] [[-AcceptanceAmplifier] <Float>] [-ShowRed <Switch>] [-ShowGreen <Switch>] [-ShowBlue <Switch>] [-ShowYellow <Switch>] [[-Notes] <String>] [[-BackgroundType] <Int>] [[-SourceName] <String>] [[-FilterName] <String>] [[-ShaderText] <String>] [-Force <Switch>] [-PassThru <Switch>] [-NoResponse <Switch>] [-UseShaderTime <Switch>] [<CommonParameters>]
```
