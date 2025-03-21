Get-OBSPieChartShader
---------------------

### Synopsis
Get-OBSPieChartShader [[-InnerRadius] <float>] [[-OuterRadius] <float>] [[-StartAngle] <float>] [[-Total] <int>] [[-Part1] <int>] [[-Color1] <string>] [[-Part2] <int>] [[-Color2] <string>] [[-Part3] <int>] [[-Color3] <string>] [[-Part4] <int>] [[-Color4] <string>] [[-Part5] <int>] [[-Color5] <string>] [[-Part6] <int>] [[-Color6] <string>] [[-Part7] <int>] [[-Color7] <string>] [[-Part8] <int>] [[-Color8] <string>] [[-Part9] <int>] [[-Color9] <string>] [[-Part10] <int>] [[-Color10] <string>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **Color1**

|Type      |Required|Position|PipelineInput|Aliases|
|----------|--------|--------|-------------|-------|
|`[String]`|false   |named   |False        |color_1|

#### **Color10**

|Type      |Required|Position|PipelineInput|Aliases |
|----------|--------|--------|-------------|--------|
|`[String]`|false   |named   |False        |color_10|

#### **Color2**

|Type      |Required|Position|PipelineInput|Aliases|
|----------|--------|--------|-------------|-------|
|`[String]`|false   |named   |False        |color_2|

#### **Color3**

|Type      |Required|Position|PipelineInput|Aliases|
|----------|--------|--------|-------------|-------|
|`[String]`|false   |named   |False        |color_3|

#### **Color4**

|Type      |Required|Position|PipelineInput|Aliases|
|----------|--------|--------|-------------|-------|
|`[String]`|false   |named   |False        |color_4|

#### **Color5**

|Type      |Required|Position|PipelineInput|Aliases|
|----------|--------|--------|-------------|-------|
|`[String]`|false   |named   |False        |color_5|

#### **Color6**

|Type      |Required|Position|PipelineInput|Aliases|
|----------|--------|--------|-------------|-------|
|`[String]`|false   |named   |False        |color_6|

#### **Color7**

|Type      |Required|Position|PipelineInput|Aliases|
|----------|--------|--------|-------------|-------|
|`[String]`|false   |named   |False        |color_7|

#### **Color8**

|Type      |Required|Position|PipelineInput|Aliases|
|----------|--------|--------|-------------|-------|
|`[String]`|false   |named   |False        |color_8|

#### **Color9**

|Type      |Required|Position|PipelineInput|Aliases|
|----------|--------|--------|-------------|-------|
|`[String]`|false   |named   |False        |color_9|

#### **FilterName**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |False        |

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **InnerRadius**

|Type     |Required|Position|PipelineInput|Aliases     |
|---------|--------|--------|-------------|------------|
|`[Float]`|false   |named   |False        |inner_radius|

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **OuterRadius**

|Type     |Required|Position|PipelineInput|Aliases     |
|---------|--------|--------|-------------|------------|
|`[Float]`|false   |named   |False        |outer_radius|

#### **Part1**

|Type   |Required|Position|PipelineInput|Aliases|
|-------|--------|--------|-------------|-------|
|`[Int]`|false   |named   |False        |part_1 |

#### **Part10**

|Type   |Required|Position|PipelineInput|Aliases|
|-------|--------|--------|-------------|-------|
|`[Int]`|false   |named   |False        |part_10|

#### **Part2**

|Type   |Required|Position|PipelineInput|Aliases|
|-------|--------|--------|-------------|-------|
|`[Int]`|false   |named   |False        |part_2 |

#### **Part3**

|Type   |Required|Position|PipelineInput|Aliases|
|-------|--------|--------|-------------|-------|
|`[Int]`|false   |named   |False        |part_3 |

#### **Part4**

|Type   |Required|Position|PipelineInput|Aliases|
|-------|--------|--------|-------------|-------|
|`[Int]`|false   |named   |False        |part_4 |

#### **Part5**

|Type   |Required|Position|PipelineInput|Aliases|
|-------|--------|--------|-------------|-------|
|`[Int]`|false   |named   |False        |part_5 |

#### **Part6**

|Type   |Required|Position|PipelineInput|Aliases|
|-------|--------|--------|-------------|-------|
|`[Int]`|false   |named   |False        |part_6 |

#### **Part7**

|Type   |Required|Position|PipelineInput|Aliases|
|-------|--------|--------|-------------|-------|
|`[Int]`|false   |named   |False        |part_7 |

#### **Part8**

|Type   |Required|Position|PipelineInput|Aliases|
|-------|--------|--------|-------------|-------|
|`[Int]`|false   |named   |False        |part_8 |

#### **Part9**

|Type   |Required|Position|PipelineInput|Aliases|
|-------|--------|--------|-------------|-------|
|`[Int]`|false   |named   |False        |part_9 |

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

#### **StartAngle**

|Type     |Required|Position|PipelineInput|Aliases    |
|---------|--------|--------|-------------|-----------|
|`[Float]`|false   |named   |False        |start_angle|

#### **Total**

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
Get-OBSPieChartShader [[-InnerRadius] <Float>] [[-OuterRadius] <Float>] [[-StartAngle] <Float>] [[-Total] <Int>] [[-Part1] <Int>] [[-Color1] <String>] [[-Part2] <Int>] [[-Color2] <String>] [[-Part3] <Int>] [[-Color3] <String>] [[-Part4] <Int>] [[-Color4] <String>] [[-Part5] <Int>] [[-Color5] <String>] [[-Part6] <Int>] [[-Color6] <String>] [[-Part7] <Int>] [[-Color7] <String>] [[-Part8] <Int>] [[-Color8] <String>] [[-Part9] <Int>] [[-Color9] <String>] [[-Part10] <Int>] [[-Color10] <String>] [[-SourceName] <String>] [[-FilterName] <String>] [[-ShaderText] <String>] [-Force <Switch>] [-PassThru <Switch>] [-NoResponse <Switch>] [-UseShaderTime <Switch>] [<CommonParameters>]
```
