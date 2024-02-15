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
|`[string]`|false   |5       |false        |color_1|

#### **Color10**

|Type      |Required|Position|PipelineInput|Aliases |
|----------|--------|--------|-------------|--------|
|`[string]`|false   |23      |false        |color_10|

#### **Color2**

|Type      |Required|Position|PipelineInput|Aliases|
|----------|--------|--------|-------------|-------|
|`[string]`|false   |7       |false        |color_2|

#### **Color3**

|Type      |Required|Position|PipelineInput|Aliases|
|----------|--------|--------|-------------|-------|
|`[string]`|false   |9       |false        |color_3|

#### **Color4**

|Type      |Required|Position|PipelineInput|Aliases|
|----------|--------|--------|-------------|-------|
|`[string]`|false   |11      |false        |color_4|

#### **Color5**

|Type      |Required|Position|PipelineInput|Aliases|
|----------|--------|--------|-------------|-------|
|`[string]`|false   |13      |false        |color_5|

#### **Color6**

|Type      |Required|Position|PipelineInput|Aliases|
|----------|--------|--------|-------------|-------|
|`[string]`|false   |15      |false        |color_6|

#### **Color7**

|Type      |Required|Position|PipelineInput|Aliases|
|----------|--------|--------|-------------|-------|
|`[string]`|false   |17      |false        |color_7|

#### **Color8**

|Type      |Required|Position|PipelineInput|Aliases|
|----------|--------|--------|-------------|-------|
|`[string]`|false   |19      |false        |color_8|

#### **Color9**

|Type      |Required|Position|PipelineInput|Aliases|
|----------|--------|--------|-------------|-------|
|`[string]`|false   |21      |false        |color_9|

#### **FilterName**

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[string]`|false   |25      |true (ByPropertyName)|

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **InnerRadius**

|Type     |Required|Position|PipelineInput|Aliases     |
|---------|--------|--------|-------------|------------|
|`[float]`|false   |0       |false        |inner_radius|

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **OuterRadius**

|Type     |Required|Position|PipelineInput|Aliases     |
|---------|--------|--------|-------------|------------|
|`[float]`|false   |1       |false        |outer_radius|

#### **Part1**

|Type   |Required|Position|PipelineInput|Aliases|
|-------|--------|--------|-------------|-------|
|`[int]`|false   |4       |false        |part_1 |

#### **Part10**

|Type   |Required|Position|PipelineInput|Aliases|
|-------|--------|--------|-------------|-------|
|`[int]`|false   |22      |false        |part_10|

#### **Part2**

|Type   |Required|Position|PipelineInput|Aliases|
|-------|--------|--------|-------------|-------|
|`[int]`|false   |6       |false        |part_2 |

#### **Part3**

|Type   |Required|Position|PipelineInput|Aliases|
|-------|--------|--------|-------------|-------|
|`[int]`|false   |8       |false        |part_3 |

#### **Part4**

|Type   |Required|Position|PipelineInput|Aliases|
|-------|--------|--------|-------------|-------|
|`[int]`|false   |10      |false        |part_4 |

#### **Part5**

|Type   |Required|Position|PipelineInput|Aliases|
|-------|--------|--------|-------------|-------|
|`[int]`|false   |12      |false        |part_5 |

#### **Part6**

|Type   |Required|Position|PipelineInput|Aliases|
|-------|--------|--------|-------------|-------|
|`[int]`|false   |14      |false        |part_6 |

#### **Part7**

|Type   |Required|Position|PipelineInput|Aliases|
|-------|--------|--------|-------------|-------|
|`[int]`|false   |16      |false        |part_7 |

#### **Part8**

|Type   |Required|Position|PipelineInput|Aliases|
|-------|--------|--------|-------------|-------|
|`[int]`|false   |18      |false        |part_8 |

#### **Part9**

|Type   |Required|Position|PipelineInput|Aliases|
|-------|--------|--------|-------------|-------|
|`[int]`|false   |20      |false        |part_9 |

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[string]`|false   |26      |false        |ShaderContent|

#### **SourceName**

|Type      |Required|Position|PipelineInput        |Aliases      |
|----------|--------|--------|---------------------|-------------|
|`[string]`|false   |24      |true (ByPropertyName)|SceneItemName|

#### **StartAngle**

|Type     |Required|Position|PipelineInput|Aliases    |
|---------|--------|--------|-------------|-----------|
|`[float]`|false   |2       |false        |start_angle|

#### **Total**

|Type   |Required|Position|PipelineInput|
|-------|--------|--------|-------------|
|`[int]`|false   |3       |false        |

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
{@{name=Get-OBSPieChartShader; CommonParameters=True; parameter=System.Object[]}}
```
