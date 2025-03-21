Get-OBSFireShader
-----------------

### Synopsis
Get-OBSFireShader [[-AlphaPercentage] <int>] [[-Speed] <int>] [[-FlameSize] <int>] [[-FireType] <int>] [[-LumaMin] <float>] [[-LumaMinSmooth] <float>] [[-ColorToReplace] <string>] [[-Notes] <string>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-Invert] [-ApplyToImage] [-ReplaceImageColor] [-ApplyToSpecificColor] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **AlphaPercentage**

|Type   |Required|Position|PipelineInput|Aliases         |
|-------|--------|--------|-------------|----------------|
|`[Int]`|false   |named   |False        |Alpha_Percentage|

#### **ApplyToImage**

|Type      |Required|Position|PipelineInput|Aliases       |
|----------|--------|--------|-------------|--------------|
|`[Switch]`|false   |named   |False        |Apply_To_Image|

#### **ApplyToSpecificColor**

|Type      |Required|Position|PipelineInput|Aliases                |
|----------|--------|--------|-------------|-----------------------|
|`[Switch]`|false   |named   |False        |Apply_To_Specific_Color|

#### **ColorToReplace**

|Type      |Required|Position|PipelineInput|Aliases         |
|----------|--------|--------|-------------|----------------|
|`[String]`|false   |named   |False        |Color_To_Replace|

#### **FilterName**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |False        |

#### **FireType**

|Type   |Required|Position|PipelineInput|Aliases  |
|-------|--------|--------|-------------|---------|
|`[Int]`|false   |named   |False        |Fire_Type|

#### **FlameSize**

|Type   |Required|Position|PipelineInput|Aliases   |
|-------|--------|--------|-------------|----------|
|`[Int]`|false   |named   |False        |Flame_Size|

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **Invert**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **LumaMin**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[Float]`|false   |named   |False        |

#### **LumaMinSmooth**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[Float]`|false   |named   |False        |

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **Notes**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[String]`|false   |named   |False        |

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **ReplaceImageColor**

|Type      |Required|Position|PipelineInput|Aliases            |
|----------|--------|--------|-------------|-------------------|
|`[Switch]`|false   |named   |False        |Replace_Image_Color|

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[String]`|false   |named   |False        |ShaderContent|

#### **SourceName**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[String]`|false   |named   |False        |SceneItemName|

#### **Speed**

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
Get-OBSFireShader [[-AlphaPercentage] <Int>] [[-Speed] <Int>] [[-FlameSize] <Int>] [[-FireType] <Int>] [-Invert <Switch>] [[-LumaMin] <Float>] [[-LumaMinSmooth] <Float>] [-ApplyToImage <Switch>] [-ReplaceImageColor <Switch>] [-ApplyToSpecificColor <Switch>] [[-ColorToReplace] <String>] [[-Notes] <String>] [[-SourceName] <String>] [[-FilterName] <String>] [[-ShaderText] <String>] [-Force <Switch>] [-PassThru <Switch>] [-NoResponse <Switch>] [-UseShaderTime <Switch>] [<CommonParameters>]
```
