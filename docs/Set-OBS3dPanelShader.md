Get-OBS3dPanelShader
--------------------

### Synopsis
Get-OBS3dPanelShader [[-Credits] <string>] [[-Scale] <float>] [[-TiltXDeg] <float>] [[-TiltYDeg] <float>] [[-TiltZDeg] <float>] [[-PosX] <float>] [[-PosY] <float>] [[-Thickness] <float>] [[-RadiusFb] <float>] [[-Brightness] <float>] [[-LightPosition] <int>] [[-Wiggle] <float>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-WiggleRot] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **Brightness**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[Float]`|false   |named   |False        |

#### **Credits**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |False        |

#### **FilterName**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |False        |

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **LightPosition**

|Type   |Required|Position|PipelineInput|Aliases       |
|-------|--------|--------|-------------|--------------|
|`[Int]`|false   |named   |False        |light_position|

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **PosX**

|Type     |Required|Position|PipelineInput|Aliases|
|---------|--------|--------|-------------|-------|
|`[Float]`|false   |named   |False        |pos_x  |

#### **PosY**

|Type     |Required|Position|PipelineInput|Aliases|
|---------|--------|--------|-------------|-------|
|`[Float]`|false   |named   |False        |pos_y  |

#### **RadiusFb**

|Type     |Required|Position|PipelineInput|Aliases  |
|---------|--------|--------|-------------|---------|
|`[Float]`|false   |named   |False        |radius_fb|

#### **Scale**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[Float]`|false   |named   |False        |

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[String]`|false   |named   |False        |ShaderContent|

#### **SourceName**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[String]`|false   |named   |False        |SceneItemName|

#### **Thickness**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[Float]`|false   |named   |False        |

#### **TiltXDeg**

|Type     |Required|Position|PipelineInput|Aliases   |
|---------|--------|--------|-------------|----------|
|`[Float]`|false   |named   |False        |tilt_x_deg|

#### **TiltYDeg**

|Type     |Required|Position|PipelineInput|Aliases   |
|---------|--------|--------|-------------|----------|
|`[Float]`|false   |named   |False        |tilt_y_deg|

#### **TiltZDeg**

|Type     |Required|Position|PipelineInput|Aliases   |
|---------|--------|--------|-------------|----------|
|`[Float]`|false   |named   |False        |tilt_z_deg|

#### **UseShaderTime**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **Wiggle**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[Float]`|false   |named   |False        |

#### **WiggleRot**

|Type      |Required|Position|PipelineInput|Aliases   |
|----------|--------|--------|-------------|----------|
|`[Switch]`|false   |named   |False        |wiggle_rot|

---

### Inputs
System.String

---

### Outputs
* [Object](https://learn.microsoft.com/en-us/dotnet/api/System.Object)

---

### Syntax
```PowerShell
Get-OBS3dPanelShader [[-Credits] <String>] [[-Scale] <Float>] [[-TiltXDeg] <Float>] [[-TiltYDeg] <Float>] [[-TiltZDeg] <Float>] [[-PosX] <Float>] [[-PosY] <Float>] [[-Thickness] <Float>] [[-RadiusFb] <Float>] [[-Brightness] <Float>] [[-LightPosition] <Int>] [[-Wiggle] <Float>] [-WiggleRot <Switch>] [[-SourceName] <String>] [[-FilterName] <String>] [[-ShaderText] <String>] [-Force <Switch>] [-PassThru <Switch>] [-NoResponse <Switch>] [-UseShaderTime <Switch>] [<CommonParameters>]
```
