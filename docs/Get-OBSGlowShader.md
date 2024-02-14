Get-OBSGlowShader
-----------------

### Synopsis

Get-OBSGlowShader [[-GlowPercent] <int>] [[-Blur] <int>] [[-MinBrightness] <int>] [[-MaxBrightness] <int>] [[-PulseSpeed] <int>] [[-Notes] <string>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-Ease] [-Force] [-PassThru] [-NoResponse] [<CommonParameters>]

---

### Description

---

### Parameters
#### **Blur**

|Type   |Required|Position|PipelineInput|
|-------|--------|--------|-------------|
|`[int]`|false   |1       |false        |

#### **Ease**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **FilterName**

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[string]`|false   |7       |true (ByPropertyName)|

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **GlowPercent**

|Type   |Required|Position|PipelineInput|Aliases     |
|-------|--------|--------|-------------|------------|
|`[int]`|false   |0       |false        |glow_percent|

#### **MaxBrightness**

|Type   |Required|Position|PipelineInput|Aliases       |
|-------|--------|--------|-------------|--------------|
|`[int]`|false   |3       |false        |max_brightness|

#### **MinBrightness**

|Type   |Required|Position|PipelineInput|Aliases       |
|-------|--------|--------|-------------|--------------|
|`[int]`|false   |2       |false        |min_brightness|

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **Notes**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[string]`|false   |5       |false        |

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **PulseSpeed**

|Type   |Required|Position|PipelineInput|Aliases    |
|-------|--------|--------|-------------|-----------|
|`[int]`|false   |4       |false        |pulse_speed|

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[string]`|false   |8       |false        |ShaderContent|

#### **SourceName**

|Type      |Required|Position|PipelineInput        |Aliases      |
|----------|--------|--------|---------------------|-------------|
|`[string]`|false   |6       |true (ByPropertyName)|SceneItemName|

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
{@{name=Get-OBSGlowShader; CommonParameters=True; parameter=System.Object[]}}
```
