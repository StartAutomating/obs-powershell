Set-OBSEqualizerFilter
----------------------

### Synopsis
Sets a Equalizer filter.

---

### Description

Adds or Changes a 3-band Equalizer Filter on an OBS Input.

---

### Parameters
#### **Low**
The change in low frequencies.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |1       |true (ByPropertyName)|

#### **Mid**
The change in mid frequencies.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |2       |true (ByPropertyName)|

#### **High**
The change in high frequencies.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |3       |true (ByPropertyName)|

#### **Force**
If set, will remove a filter if one already exists.    
If this is not provided and the filter already exists, the settings of the filter will be changed.

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |

---

### Syntax
```PowerShell
Set-OBSEqualizerFilter [[-Low] <Double>] [[-Mid] <Double>] [[-High] <Double>] [-Force] [<CommonParameters>]
```
