Get-OBSClockDigitalNixieShader
------------------------------

### Synopsis

Get-OBSClockDigitalNixieShader [[-CurrentTimeMs] <int>] [[-CurrentTimeSec] <int>] [[-CurrentTimeMin] <int>] [[-CurrentTimeHour] <int>] [[-TimeMode] <int>] [[-OffsetHours] <int>] [[-OffsetSeconds] <int>] [[-Corecolor] <float[]>] [[-Halocolor] <float[]>] [[-Flarecolor] <float[]>] [[-Anodecolor] <float[]>] [[-Anodehighlightscolor] <float[]>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **Anodecolor**

|Type       |Required|Position|PipelineInput|
|-----------|--------|--------|-------------|
|`[float[]]`|false   |10      |false        |

#### **Anodehighlightscolor**

|Type       |Required|Position|PipelineInput|
|-----------|--------|--------|-------------|
|`[float[]]`|false   |11      |false        |

#### **Corecolor**

|Type       |Required|Position|PipelineInput|
|-----------|--------|--------|-------------|
|`[float[]]`|false   |7       |false        |

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
|`[string]`|false   |13      |true (ByPropertyName)|

#### **Flarecolor**

|Type       |Required|Position|PipelineInput|
|-----------|--------|--------|-------------|
|`[float[]]`|false   |9       |false        |

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **Halocolor**

|Type       |Required|Position|PipelineInput|
|-----------|--------|--------|-------------|
|`[float[]]`|false   |8       |false        |

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **OffsetHours**

|Type   |Required|Position|PipelineInput|
|-------|--------|--------|-------------|
|`[int]`|false   |5       |false        |

#### **OffsetSeconds**

|Type   |Required|Position|PipelineInput|
|-------|--------|--------|-------------|
|`[int]`|false   |6       |false        |

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[string]`|false   |14      |false        |ShaderContent|

#### **SourceName**

|Type      |Required|Position|PipelineInput        |Aliases      |
|----------|--------|--------|---------------------|-------------|
|`[string]`|false   |12      |true (ByPropertyName)|SceneItemName|

#### **TimeMode**

|Type   |Required|Position|PipelineInput|
|-------|--------|--------|-------------|
|`[int]`|false   |4       |false        |

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
{@{name=Get-OBSClockDigitalNixieShader; CommonParameters=True; parameter=System.Object[]}}
```
