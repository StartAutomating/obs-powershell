Get-OBSRainbowShader
--------------------

### Synopsis
Get-OBSRainbowShader [[-Saturation] <float>] [[-Luminosity] <float>] [[-Spread] <float>] [[-Speed] <float>] [[-AlphaPercentage] <float>] [[-RotationOffset] <float>] [[-ColorToReplace] <string>] [[-Notes] <string>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-Vertical] [-Rotational] [-ApplyToImage] [-ReplaceImageColor] [-ApplyToSpecificColor] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **AlphaPercentage**

|Type     |Required|Position|PipelineInput|Aliases         |
|---------|--------|--------|-------------|----------------|
|`[Float]`|false   |named   |False        |Alpha_Percentage|

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

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **Luminosity**

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

#### **Rotational**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **RotationOffset**

|Type     |Required|Position|PipelineInput|Aliases        |
|---------|--------|--------|-------------|---------------|
|`[Float]`|false   |named   |False        |Rotation_Offset|

#### **Saturation**

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

#### **Speed**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[Float]`|false   |named   |False        |

#### **Spread**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[Float]`|false   |named   |False        |

#### **UseShaderTime**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |False        |

#### **Vertical**

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
Get-OBSRainbowShader [[-Saturation] <Float>] [[-Luminosity] <Float>] [[-Spread] <Float>] [[-Speed] <Float>] [[-AlphaPercentage] <Float>] [-Vertical <Switch>] [-Rotational <Switch>] [[-RotationOffset] <Float>] [-ApplyToImage <Switch>] [-ReplaceImageColor <Switch>] [-ApplyToSpecificColor <Switch>] [[-ColorToReplace] <String>] [[-Notes] <String>] [[-SourceName] <String>] [[-FilterName] <String>] [[-ShaderText] <String>] [-Force <Switch>] [-PassThru <Switch>] [-NoResponse <Switch>] [-UseShaderTime <Switch>] [<CommonParameters>]
```
