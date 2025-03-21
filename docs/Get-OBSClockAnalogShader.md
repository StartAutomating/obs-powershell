Get-OBSClockAnalogShader
------------------------

### Synopsis
Get-OBSClockAnalogShader [[-CurrentTimeMs] <int>] [[-CurrentTimeSec] <int>] [[-CurrentTimeMin] <int>] [[-CurrentTimeHour] <int>] [[-HourHandleColor] <float[]>] [[-MinuteHandleColor] <float[]>] [[-SecondHandleColor] <float[]>] [[-OutlineColor] <float[]>] [[-TopLineColor] <float[]>] [[-BackgroundColor] <float[]>] [[-TimeOffsetHours] <int>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **BackgroundColor**

|Type               |Required|Position|PipelineInput|Aliases         |
|-------------------|--------|--------|-------------|----------------|
|`[System.Single[]]`|false   |named   |False        |background_color|

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

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **HourHandleColor**

|Type               |Required|Position|PipelineInput|Aliases          |
|-------------------|--------|--------|-------------|-----------------|
|`[System.Single[]]`|false   |named   |False        |hour_handle_color|

#### **MinuteHandleColor**

|Type               |Required|Position|PipelineInput|Aliases            |
|-------------------|--------|--------|-------------|-------------------|
|`[System.Single[]]`|false   |named   |False        |minute_handle_color|

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **OutlineColor**

|Type               |Required|Position|PipelineInput|Aliases      |
|-------------------|--------|--------|-------------|-------------|
|`[System.Single[]]`|false   |named   |False        |outline_color|

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **SecondHandleColor**

|Type               |Required|Position|PipelineInput|Aliases            |
|-------------------|--------|--------|-------------|-------------------|
|`[System.Single[]]`|false   |named   |False        |second_handle_color|

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[String]`|false   |named   |False        |ShaderContent|

#### **SourceName**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[String]`|false   |named   |False        |SceneItemName|

#### **TimeOffsetHours**

|Type   |Required|Position|PipelineInput|Aliases          |
|-------|--------|--------|-------------|-----------------|
|`[Int]`|false   |named   |False        |time_offset_hours|

#### **TopLineColor**

|Type               |Required|Position|PipelineInput|Aliases       |
|-------------------|--------|--------|-------------|--------------|
|`[System.Single[]]`|false   |named   |False        |top_line_color|

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
Get-OBSClockAnalogShader [[-CurrentTimeMs] <Int>] [[-CurrentTimeSec] <Int>] [[-CurrentTimeMin] <Int>] [[-CurrentTimeHour] <Int>] [[-HourHandleColor] <System.Single[]>] [[-MinuteHandleColor] <System.Single[]>] [[-SecondHandleColor] <System.Single[]>] [[-OutlineColor] <System.Single[]>] [[-TopLineColor] <System.Single[]>] [[-BackgroundColor] <System.Single[]>] [[-TimeOffsetHours] <Int>] [[-SourceName] <String>] [[-FilterName] <String>] [[-ShaderText] <String>] [-Force <Switch>] [-PassThru <Switch>] [-NoResponse <Switch>] [-UseShaderTime <Switch>] [<CommonParameters>]
```
