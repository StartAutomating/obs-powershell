Get-OBSClockAnalogShader
------------------------

### Synopsis

Get-OBSClockAnalogShader [[-CurrentTimeMs] <int>] [[-CurrentTimeSec] <int>] [[-CurrentTimeMin] <int>] [[-CurrentTimeHour] <int>] [[-HourHandleColor] <float[]>] [[-MinuteHandleColor] <float[]>] [[-SecondHandleColor] <float[]>] [[-OutlineColor] <float[]>] [[-TopLineColor] <float[]>] [[-BackgroundColor] <float[]>] [[-TimeOffsetHours] <int>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **BackgroundColor**

|Type       |Required|Position|PipelineInput|Aliases         |
|-----------|--------|--------|-------------|----------------|
|`[float[]]`|false   |9       |false        |background_color|

#### **CurrentTimeHour**

|Type   |Required|Position|PipelineInput|Aliases          |
|-------|--------|--------|-------------|-----------------|
|`[int]`|false   |3       |false        |current_time_hour|

#### **CurrentTimeMin**

|Type   |Required|Position|PipelineInput|Aliases         |
|-------|--------|--------|-------------|----------------|
|`[int]`|false   |2       |false        |current_time_min|

#### **CurrentTimeMs**

|Type   |Required|Position|PipelineInput|Aliases        |
|-------|--------|--------|-------------|---------------|
|`[int]`|false   |0       |false        |current_time_ms|

#### **CurrentTimeSec**

|Type   |Required|Position|PipelineInput|Aliases         |
|-------|--------|--------|-------------|----------------|
|`[int]`|false   |1       |false        |current_time_sec|

#### **FilterName**

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[string]`|false   |12      |true (ByPropertyName)|

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **HourHandleColor**

|Type       |Required|Position|PipelineInput|Aliases          |
|-----------|--------|--------|-------------|-----------------|
|`[float[]]`|false   |4       |false        |hour_handle_color|

#### **MinuteHandleColor**

|Type       |Required|Position|PipelineInput|Aliases            |
|-----------|--------|--------|-------------|-------------------|
|`[float[]]`|false   |5       |false        |minute_handle_color|

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **OutlineColor**

|Type       |Required|Position|PipelineInput|Aliases      |
|-----------|--------|--------|-------------|-------------|
|`[float[]]`|false   |7       |false        |outline_color|

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **SecondHandleColor**

|Type       |Required|Position|PipelineInput|Aliases            |
|-----------|--------|--------|-------------|-------------------|
|`[float[]]`|false   |6       |false        |second_handle_color|

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[string]`|false   |13      |false        |ShaderContent|

#### **SourceName**

|Type      |Required|Position|PipelineInput        |Aliases      |
|----------|--------|--------|---------------------|-------------|
|`[string]`|false   |11      |true (ByPropertyName)|SceneItemName|

#### **TimeOffsetHours**

|Type   |Required|Position|PipelineInput|Aliases          |
|-------|--------|--------|-------------|-----------------|
|`[int]`|false   |10      |false        |time_offset_hours|

#### **TopLineColor**

|Type       |Required|Position|PipelineInput|Aliases       |
|-----------|--------|--------|-------------|--------------|
|`[float[]]`|false   |8       |false        |top_line_color|

#### **UseShaderTime**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

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
{@{name=Get-OBSClockAnalogShader; CommonParameters=True; parameter=System.Object[]}}
```
