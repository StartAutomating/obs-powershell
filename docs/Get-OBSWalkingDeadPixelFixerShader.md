Get-OBSWalkingDeadPixelFixerShader
----------------------------------

### Synopsis
Get-OBSWalkingDeadPixelFixerShader [[-ScanWidth] <int>] [[-ScanHeight] <int>] [[-ScanOffsetX] <int>] [[-ScanOffsetY] <int>] [[-ContrastThreshold] <float>] [[-MinClusterSize] <int>] [[-MaxClusterSize] <int>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-ShowBorder] [-ShowGreen] [-Bypass] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **Bypass**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **ContrastThreshold**

|Type     |Required|Position|PipelineInput|Aliases           |
|---------|--------|--------|-------------|------------------|
|`[Float]`|false   |named   |False        |Contrast_Threshold|

#### **FilterName**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |False        |

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **MaxClusterSize**

|Type   |Required|Position|PipelineInput|Aliases         |
|-------|--------|--------|-------------|----------------|
|`[Int]`|false   |named   |False        |Max_Cluster_Size|

#### **MinClusterSize**

|Type   |Required|Position|PipelineInput|Aliases         |
|-------|--------|--------|-------------|----------------|
|`[Int]`|false   |named   |False        |Min_Cluster_Size|

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **ScanHeight**

|Type   |Required|Position|PipelineInput|Aliases    |
|-------|--------|--------|-------------|-----------|
|`[Int]`|false   |named   |False        |Scan_Height|

#### **ScanOffsetX**

|Type   |Required|Position|PipelineInput|Aliases      |
|-------|--------|--------|-------------|-------------|
|`[Int]`|false   |named   |False        |Scan_Offset_X|

#### **ScanOffsetY**

|Type   |Required|Position|PipelineInput|Aliases      |
|-------|--------|--------|-------------|-------------|
|`[Int]`|false   |named   |False        |Scan_Offset_Y|

#### **ScanWidth**

|Type   |Required|Position|PipelineInput|Aliases   |
|-------|--------|--------|-------------|----------|
|`[Int]`|false   |named   |False        |Scan_Width|

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[String]`|false   |named   |False        |ShaderContent|

#### **ShowBorder**

|Type      |Required|Position|PipelineInput|Aliases    |
|----------|--------|--------|-------------|-----------|
|`[Switch]`|false   |named   |False        |Show_Border|

#### **ShowGreen**

|Type      |Required|Position|PipelineInput|Aliases   |
|----------|--------|--------|-------------|----------|
|`[Switch]`|false   |named   |False        |Show_Green|

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
Get-OBSWalkingDeadPixelFixerShader [[-ScanWidth] <Int>] [[-ScanHeight] <Int>] [[-ScanOffsetX] <Int>] [[-ScanOffsetY] <Int>] [-ShowBorder <Switch>] [[-ContrastThreshold] <Float>] [[-MinClusterSize] <Int>] [[-MaxClusterSize] <Int>] [-ShowGreen <Switch>] [-Bypass <Switch>] [[-SourceName] <String>] [[-FilterName] <String>] [[-ShaderText] <String>] [-Force <Switch>] [-PassThru <Switch>] [-NoResponse <Switch>] [-UseShaderTime <Switch>] [<CommonParameters>]
```
