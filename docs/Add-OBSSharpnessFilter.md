Set-OBSSharpnessFilter
----------------------

### Synopsis
Sets a Sharpness filter.

---

### Description

Adds or Changes a Sharpness Filter on an OBS Input.    
This changes the sharpness of an image.

---

### Examples
> EXAMPLE 1

```PowerShell
Show-OBS -Uri https://pssvg.start-automating.com/Examples/Stars.svg |    
    Set-OBSSharpnessFilter -Sharpness .75
```

---

### Parameters
#### **Sharpness**
The Sharpness.

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
Set-OBSSharpnessFilter [[-Sharpness] <Double>] [-Force] [<CommonParameters>]
```
