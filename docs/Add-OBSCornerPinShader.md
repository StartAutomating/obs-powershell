Get-OBSCornerPinShader
----------------------

### Synopsis
Get-OBSCornerPinShader [[-TopLeftX] <float>] [[-TopLeftY] <float>] [[-TopRightX] <float>] [[-TopRightY] <float>] [[-BottomLeftX] <float>] [[-BottomLeftY] <float>] [[-BottomRightX] <float>] [[-BottomRightY] <float>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-AntialiasEdges] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **AntialiasEdges**

|Type      |Required|Position|PipelineInput|Aliases        |
|----------|--------|--------|-------------|---------------|
|`[Switch]`|false   |named   |False        |Antialias_Edges|

#### **BottomLeftX**

|Type     |Required|Position|PipelineInput|Aliases      |
|---------|--------|--------|-------------|-------------|
|`[Float]`|false   |named   |False        |Bottom_Left_X|

#### **BottomLeftY**

|Type     |Required|Position|PipelineInput|Aliases      |
|---------|--------|--------|-------------|-------------|
|`[Float]`|false   |named   |False        |Bottom_Left_Y|

#### **BottomRightX**

|Type     |Required|Position|PipelineInput|Aliases       |
|---------|--------|--------|-------------|--------------|
|`[Float]`|false   |named   |False        |Bottom_Right_X|

#### **BottomRightY**

|Type     |Required|Position|PipelineInput|Aliases       |
|---------|--------|--------|-------------|--------------|
|`[Float]`|false   |named   |False        |Bottom_Right_Y|

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

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[String]`|false   |named   |False        |ShaderContent|

#### **SourceName**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[String]`|false   |named   |False        |SceneItemName|

#### **TopLeftX**

|Type     |Required|Position|PipelineInput|Aliases   |
|---------|--------|--------|-------------|----------|
|`[Float]`|false   |named   |False        |Top_Left_X|

#### **TopLeftY**

|Type     |Required|Position|PipelineInput|Aliases   |
|---------|--------|--------|-------------|----------|
|`[Float]`|false   |named   |False        |Top_Left_Y|

#### **TopRightX**

|Type     |Required|Position|PipelineInput|Aliases    |
|---------|--------|--------|-------------|-----------|
|`[Float]`|false   |named   |False        |Top_Right_X|

#### **TopRightY**

|Type     |Required|Position|PipelineInput|Aliases    |
|---------|--------|--------|-------------|-----------|
|`[Float]`|false   |named   |False        |Top_Right_Y|

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
Get-OBSCornerPinShader [-AntialiasEdges <Switch>] [[-TopLeftX] <Float>] [[-TopLeftY] <Float>] [[-TopRightX] <Float>] [[-TopRightY] <Float>] [[-BottomLeftX] <Float>] [[-BottomLeftY] <Float>] [[-BottomRightX] <Float>] [[-BottomRightY] <Float>] [[-SourceName] <String>] [[-FilterName] <String>] [[-ShaderText] <String>] [-Force <Switch>] [-PassThru <Switch>] [-NoResponse <Switch>] [-UseShaderTime <Switch>] [<CommonParameters>]
```
