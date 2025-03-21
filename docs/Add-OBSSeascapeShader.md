Get-OBSSeascapeShader
---------------------

### Synopsis
Get-OBSSeascapeShader [[-SEAHEIGHT] <float>] [[-SEACHOPPY] <float>] [[-SEASPEED] <float>] [[-SEAFREQ] <float>] [[-SEABASE] <string>] [[-SEAWATERCOLOR] <string>] [[-CAMERASPEED] <float>] [[-CAMERATURNSPEED] <float>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-AA] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **AA**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **CAMERASPEED**

|Type     |Required|Position|PipelineInput|Aliases     |
|---------|--------|--------|-------------|------------|
|`[Float]`|false   |named   |False        |CAMERA_SPEED|

#### **CAMERATURNSPEED**

|Type     |Required|Position|PipelineInput|Aliases          |
|---------|--------|--------|-------------|-----------------|
|`[Float]`|false   |named   |False        |CAMERA_TURN_SPEED|

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

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **SEABASE**

|Type      |Required|Position|PipelineInput|Aliases |
|----------|--------|--------|-------------|--------|
|`[String]`|false   |named   |False        |SEA_BASE|

#### **SEACHOPPY**

|Type     |Required|Position|PipelineInput|Aliases   |
|---------|--------|--------|-------------|----------|
|`[Float]`|false   |named   |False        |SEA_CHOPPY|

#### **SEAFREQ**

|Type     |Required|Position|PipelineInput|Aliases |
|---------|--------|--------|-------------|--------|
|`[Float]`|false   |named   |False        |SEA_FREQ|

#### **SEAHEIGHT**

|Type     |Required|Position|PipelineInput|Aliases   |
|---------|--------|--------|-------------|----------|
|`[Float]`|false   |named   |False        |SEA_HEIGHT|

#### **SEASPEED**

|Type     |Required|Position|PipelineInput|Aliases  |
|---------|--------|--------|-------------|---------|
|`[Float]`|false   |named   |False        |SEA_SPEED|

#### **SEAWATERCOLOR**

|Type      |Required|Position|PipelineInput|Aliases        |
|----------|--------|--------|-------------|---------------|
|`[String]`|false   |named   |False        |SEA_WATER_COLOR|

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
Get-OBSSeascapeShader [-AA <Switch>] [[-SEAHEIGHT] <Float>] [[-SEACHOPPY] <Float>] [[-SEASPEED] <Float>] [[-SEAFREQ] <Float>] [[-SEABASE] <String>] [[-SEAWATERCOLOR] <String>] [[-CAMERASPEED] <Float>] [[-CAMERATURNSPEED] <Float>] [[-SourceName] <String>] [[-FilterName] <String>] [[-ShaderText] <String>] [-Force <Switch>] [-PassThru <Switch>] [-NoResponse <Switch>] [-UseShaderTime <Switch>] [<CommonParameters>]
```
