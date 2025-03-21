Set-OBSScaleFilter
------------------

### Synopsis
Sets a Scale filter.

---

### Description

Adds or Changes a Scale Filter on an OBS Input.    
This allows you to resize the image source.

---

### Examples
> EXAMPLE 1

```PowerShell
Show-OBS -Uri https://pssvg.start-automating.com/Examples/Stars.svg |    
    Set-OBSScaleFilter -Resolution "16:9"
```

---

### Parameters
#### **Resolution**
The Resolution.  Can either width x height (e.g. 1920x1080) or an aspect ratio (16:9).

|Type      |Required|Position|PipelineInput        |Aliases|
|----------|--------|--------|---------------------|-------|
|`[String]`|false   |1       |true (ByPropertyName)|Scale  |

#### **Sampling**
The sampling method.  It will default to "lanczos".

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |2       |true (ByPropertyName)|

#### **KeepAspectRatio**
If set, will keep the aspect ratio when scaling.    
This is only valid if the sampling method is set to "lanczos".

|Type      |Required|Position|PipelineInput        |Aliases  |
|----------|--------|--------|---------------------|---------|
|`[Switch]`|false   |named   |true (ByPropertyName)|Undistort|

#### **Force**
If set, will remove a filter if one already exists.    
If this is not provided and the filter already exists, the settings of the filter will be changed.

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |

---

### Syntax
```PowerShell
Set-OBSScaleFilter [[-Resolution] <String>] [[-Sampling] <String>] [-KeepAspectRatio] [-Force] [<CommonParameters>]
```
