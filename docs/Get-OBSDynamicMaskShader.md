Get-OBSDynamicMaskShader
------------------------

### Synopsis

Get-OBSDynamicMaskShader [[-InputSource] <string>] [[-RedBaseValue] <float>] [[-RedRedInputValue] <float>] [[-RedGreenInputValue] <float>] [[-RedBlueInputValue] <float>] [[-RedAlphaInputValue] <float>] [[-RedMultiplier] <float>] [[-GreenBaseValue] <float>] [[-GreenRedInputValue] <float>] [[-GreenGreenInputValue] <float>] [[-GreenBlueInputValue] <float>] [[-GreenAlphaInputValue] <float>] [[-GreenMultiplier] <float>] [[-BlueBaseValue] <float>] [[-BlueRedInputValue] <float>] [[-BlueGreenInputValue] <float>] [[-BlueBlueInputValue] <float>] [[-BlueAlphaInputValue] <float>] [[-BlueMultiplier] <float>] [[-AlphaBaseValue] <float>] [[-AlphaRedInputValue] <float>] [[-AlphaGreenInputValue] <float>] [[-AlphaBlueInputValue] <float>] [[-AlphaAlphaInputValue] <float>] [[-AlphaMultiplier] <float>] [[-SourceName] <string>] [[-FilterName] <string>] [[-ShaderText] <string>] [-Force] [-PassThru] [-NoResponse] [<CommonParameters>]

---

### Description

---

### Parameters
#### **AlphaAlphaInputValue**

|Type     |Required|Position|PipelineInput|Aliases                |
|---------|--------|--------|-------------|-----------------------|
|`[float]`|false   |23      |false        |alpha_alpha_input_value|

#### **AlphaBaseValue**

|Type     |Required|Position|PipelineInput|Aliases         |
|---------|--------|--------|-------------|----------------|
|`[float]`|false   |19      |false        |alpha_base_value|

#### **AlphaBlueInputValue**

|Type     |Required|Position|PipelineInput|Aliases               |
|---------|--------|--------|-------------|----------------------|
|`[float]`|false   |22      |false        |alpha_blue_input_value|

#### **AlphaGreenInputValue**

|Type     |Required|Position|PipelineInput|Aliases                |
|---------|--------|--------|-------------|-----------------------|
|`[float]`|false   |21      |false        |alpha_green_input_value|

#### **AlphaMultiplier**

|Type     |Required|Position|PipelineInput|Aliases         |
|---------|--------|--------|-------------|----------------|
|`[float]`|false   |24      |false        |alpha_multiplier|

#### **AlphaRedInputValue**

|Type     |Required|Position|PipelineInput|Aliases              |
|---------|--------|--------|-------------|---------------------|
|`[float]`|false   |20      |false        |alpha_red_input_value|

#### **BlueAlphaInputValue**

|Type     |Required|Position|PipelineInput|Aliases               |
|---------|--------|--------|-------------|----------------------|
|`[float]`|false   |17      |false        |blue_alpha_input_value|

#### **BlueBaseValue**

|Type     |Required|Position|PipelineInput|Aliases        |
|---------|--------|--------|-------------|---------------|
|`[float]`|false   |13      |false        |blue_base_value|

#### **BlueBlueInputValue**

|Type     |Required|Position|PipelineInput|Aliases              |
|---------|--------|--------|-------------|---------------------|
|`[float]`|false   |16      |false        |blue_blue_input_value|

#### **BlueGreenInputValue**

|Type     |Required|Position|PipelineInput|Aliases               |
|---------|--------|--------|-------------|----------------------|
|`[float]`|false   |15      |false        |blue_green_input_value|

#### **BlueMultiplier**

|Type     |Required|Position|PipelineInput|Aliases        |
|---------|--------|--------|-------------|---------------|
|`[float]`|false   |18      |false        |blue_multiplier|

#### **BlueRedInputValue**

|Type     |Required|Position|PipelineInput|Aliases             |
|---------|--------|--------|-------------|--------------------|
|`[float]`|false   |14      |false        |blue_red_input_value|

#### **FilterName**

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[string]`|false   |26      |true (ByPropertyName)|

#### **Force**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **GreenAlphaInputValue**

|Type     |Required|Position|PipelineInput|Aliases                |
|---------|--------|--------|-------------|-----------------------|
|`[float]`|false   |11      |false        |green_alpha_input_value|

#### **GreenBaseValue**

|Type     |Required|Position|PipelineInput|Aliases         |
|---------|--------|--------|-------------|----------------|
|`[float]`|false   |7       |false        |green_base_value|

#### **GreenBlueInputValue**

|Type     |Required|Position|PipelineInput|Aliases               |
|---------|--------|--------|-------------|----------------------|
|`[float]`|false   |10      |false        |green_blue_input_value|

#### **GreenGreenInputValue**

|Type     |Required|Position|PipelineInput|Aliases                |
|---------|--------|--------|-------------|-----------------------|
|`[float]`|false   |9       |false        |green_green_input_value|

#### **GreenMultiplier**

|Type     |Required|Position|PipelineInput|Aliases         |
|---------|--------|--------|-------------|----------------|
|`[float]`|false   |12      |false        |green_multiplier|

#### **GreenRedInputValue**

|Type     |Required|Position|PipelineInput|Aliases              |
|---------|--------|--------|-------------|---------------------|
|`[float]`|false   |8       |false        |green_red_input_value|

#### **InputSource**

|Type      |Required|Position|PipelineInput|Aliases     |
|----------|--------|--------|-------------|------------|
|`[string]`|false   |0       |false        |input_source|

#### **NoResponse**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **PassThru**

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[switch]`|false   |Named   |false        |

#### **RedAlphaInputValue**

|Type     |Required|Position|PipelineInput|Aliases              |
|---------|--------|--------|-------------|---------------------|
|`[float]`|false   |5       |false        |red_alpha_input_value|

#### **RedBaseValue**

|Type     |Required|Position|PipelineInput|Aliases       |
|---------|--------|--------|-------------|--------------|
|`[float]`|false   |1       |false        |red_base_value|

#### **RedBlueInputValue**

|Type     |Required|Position|PipelineInput|Aliases             |
|---------|--------|--------|-------------|--------------------|
|`[float]`|false   |4       |false        |red_blue_input_value|

#### **RedGreenInputValue**

|Type     |Required|Position|PipelineInput|Aliases              |
|---------|--------|--------|-------------|---------------------|
|`[float]`|false   |3       |false        |red_green_input_value|

#### **RedMultiplier**

|Type     |Required|Position|PipelineInput|Aliases       |
|---------|--------|--------|-------------|--------------|
|`[float]`|false   |6       |false        |red_multiplier|

#### **RedRedInputValue**

|Type     |Required|Position|PipelineInput|Aliases            |
|---------|--------|--------|-------------|-------------------|
|`[float]`|false   |2       |false        |red_red_input_value|

#### **ShaderText**

|Type      |Required|Position|PipelineInput|Aliases      |
|----------|--------|--------|-------------|-------------|
|`[string]`|false   |27      |false        |ShaderContent|

#### **SourceName**

|Type      |Required|Position|PipelineInput        |Aliases      |
|----------|--------|--------|---------------------|-------------|
|`[string]`|false   |25      |true (ByPropertyName)|SceneItemName|

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
{@{name=Get-OBSDynamicMaskShader; CommonParameters=True; parameter=System.Object[]}}
```
