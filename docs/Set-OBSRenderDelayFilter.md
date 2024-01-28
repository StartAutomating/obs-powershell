Set-OBSRenderDelayFilter
------------------------

### Synopsis
Sets a RenderDelay filter.

---

### Description

Adds or Changes a RenderDelay Filter on an OBS Input.    
This changes the RenderDelay of an image.

---

### Examples
> EXAMPLE 1

```PowerShell
Show-OBS -Uri https://pssvg.start-automating.com/Examples/Stars.svg |    
    Set-OBSRenderDelayFilter -RenderDelay .75
```

---

### Parameters
#### **RenderDelay**
The RenderDelay.

|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[TimeSpan]`|false   |1       |true (ByPropertyName)|

#### **Force**
If set, will remove a filter if one already exists.    
If this is not provided and the filter already exists, the settings of the filter will be changed.

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |

---

### Syntax
```PowerShell
Set-OBSRenderDelayFilter [[-RenderDelay] <TimeSpan>] [-Force] [<CommonParameters>]
```
