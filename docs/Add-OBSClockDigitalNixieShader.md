Get-OBSClockDigitalNixieShader
------------------------------

### Synopsis
Get-OBSClockDigitalNixieShader [[-CurrentTimeMs] <int>] [[-CurrentTimeSec] <int>] [[-CurrentTimeMin] <int>] [[-CurrentTimeHour] <int>] [[-TimeMode] <int>] [[-OffsetHours] <int>] [[-OffsetSeconds] <int>] [[-Corecolor] <float[]>] [[-Halocolor] <float[]>] [[-Flarecolor] <float[]>] [[-Anodecolor] <float[]>] [[-Anodehighlightscolor] <float[]>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **Anodecolor**

|Type               |Required|Position|PipelineInput|
|-------------------|--------|--------|-------------|
|`[System.Single[]]`|false   |named   |False        |

#### **Anodehighlightscolor**

|Type               |Required|Position|PipelineInput|
|-------------------|--------|--------|-------------|
|`[System.Single[]]`|false   |named   |False        |

#### **Corecolor**

|Type               |Required|Position|PipelineInput|
|-------------------|--------|--------|-------------|
|`[System.Single[]]`|false   |named   |False        |

#### **CurrentTimeHour**

|Type   |Required|Position|PipelineInput|Aliases          |
|-------|--------|--------|-------------|-----------------|
|`[Int]`|false   |named   |False        |current_time_hour|

#### **CurrentTimeMin**

|Type   |Required|Position|PipelineInput|Aliases         |
|-------|--------|--------|-------------|----------------|
|`[Int]`|false   |named   |False        |current_time_min|

#### **CurrentTimeMs**

|Type   |Required|Position|PipelineInput|Aliases        |
|-------|--------|--------|-------------|---------------|
|`[Int]`|false   |named   |False        |current_time_ms|

#### **CurrentTimeSec**

|Type   |Required|Position|PipelineInput|Aliases         |
|-------|--------|--------|-------------|----------------|
|`[Int]`|false   |named   |False        |current_time_sec|

#### **FilterName**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |False        |

#### **Flarecolor**

|Type               |Required|Position|PipelineInput|
|-------------------|--------|--------|-------------|
|`[System.Single[]]`|false   |named   |False        |

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **Halocolor**

|Type               |Required|Position|PipelineInput|
|-------------------|--------|--------|-------------|
|`[System.Single[]]`|false   |named   |False        |

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **OffsetHours**

|Type   |Required|Position|PipelineInput|
|-------|--------|--------|-------------|
|`[Int]`|false   |named   |False        |

#### **OffsetSeconds**

|Type   |Required|Position|PipelineInput|
|-------|--------|--------|-------------|
|`[Int]`|false   |named   |False        |

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

#### **TimeMode**

|Type   |Required|Position|PipelineInput|
|-------|--------|--------|-------------|
|`[Int]`|false   |named   |False        |

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
Get-OBSClockDigitalNixieShader [[-CurrentTimeMs] <Int>] [[-CurrentTimeSec] <Int>] [[-CurrentTimeMin] <Int>] [[-CurrentTimeHour] <Int>] [[-TimeMode] <Int>] [[-OffsetHours] <Int>] [[-OffsetSeconds] <Int>] [[-Corecolor] <System.Single[]>] [[-Halocolor] <System.Single[]>] [[-Flarecolor] <System.Single[]>] [[-Anodecolor] <System.Single[]>] [[-Anodehighlightscolor] <System.Single[]>] [[-SourceName] <String>] [[-FilterName] <String>] [[-ShaderText] <String>] [-Force <Switch>] [-PassThru <Switch>] [-NoResponse <Switch>] [-UseShaderTime <Switch>] [<CommonParameters>]
```
