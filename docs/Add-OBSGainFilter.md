Set-OBSGainFilter
-----------------

### Synopsis
Sets a Gain filter.

---

### Description

Adds or Changes a Gain Filter on an OBS Input.    
This allows you to make the audio louder or softer.

---

### Examples
> EXAMPLE 1

```PowerShell
Show-OBS -Uri https://pssvg.start-automating.com/Examples/Stars.svg |    
    Set-OBSGainFilter -Gain 1.1 # Gains Audio by 1.1 decibels
```

---

### Parameters
#### **Gain**
The Audio Gain, in decibels.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |1       |true (ByPropertyName)|

#### **Force**
If set, will remove a filter if one already exists.    
If this is not provided and the filter already exists, the settings of the filter will be changed.

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |

---

### Syntax
```PowerShell
Set-OBSGainFilter [[-Gain] <Double>] [-Force] [<CommonParameters>]
```
