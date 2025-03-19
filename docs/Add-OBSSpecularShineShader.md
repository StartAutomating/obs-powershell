Get-OBSSpecularShineShader
--------------------------

### Synopsis

Get-OBSSpecularShineShader [[-Hint] <string>] [[-Roughness] <float>] [[-LightStrength] <float>] [[-LightPositionX] <float>] [[-LightPositionY] <float>] [[-FlattenNormal] <float>] [[-StretchNormalX] <float>] [[-StretchNormalY] <float>] [[-LightColor] <float[]>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-Force] [-PassThru] [-NoResponse] [-UseShaderTime] [<CommonParameters>]

---

### Description

---

### Parameters
#### **FilterName**

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[string]`|false   |10      |true (ByPropertyName)|

#### **FlattenNormal**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[float]`|false   |5       |false        |

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **Hint**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[string]`|false   |0       |false        |

#### **LightColor**

|Type       |Required|Position|PipelineInput|Aliases    |
|-----------|--------|--------|-------------|-----------|
|`[float[]]`|false   |8       |false        |Light_Color|

#### **LightPositionX**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[float]`|false   |3       |false        |

#### **LightPositionY**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[float]`|false   |4       |false        |

#### **LightStrength**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[float]`|false   |2       |false        |

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **Roughness**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[float]`|false   |1       |false        |

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[string]`|false   |11      |false        |ShaderContent|

#### **SourceName**

|Type      |Required|Position|PipelineInput        |Aliases      |
|----------|--------|--------|---------------------|-------------|
|`[string]`|false   |9       |true (ByPropertyName)|SceneItemName|

#### **StretchNormalX**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[float]`|false   |6       |false        |

#### **StretchNormalY**

|Type     |Required|Position|PipelineInput|
|---------|--------|--------|-------------|
|`[float]`|false   |7       |false        |

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
{@{name=Get-OBSSpecularShineShader; CommonParameters=True; parameter=System.Object[]}}
```
