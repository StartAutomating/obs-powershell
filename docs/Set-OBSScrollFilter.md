Set-OBSScrollFilter
-------------------

### Synopsis
Sets a scroll filter.

---

### Description

Adds or Changes a Scroll Filter on an OBS Input.    
This allows you to scroll horizontally or vertically.

---

### Examples
> EXAMPLE 1

```PowerShell
Show-OBS -Uri https://pssvg.start-automating.com/Examples/Stars.svg |    
    Set-OBSScrollFilter -HorizontalSpeed 100 -VerticalSpeed 100
```

---

### Parameters
#### **HorizontalSpeed**
The horizontal scroll speed.

|Type      |Required|Position|PipelineInput        |Aliases                      |
|----------|--------|--------|---------------------|-----------------------------|
|`[Double]`|false   |1       |true (ByPropertyName)|SpeedX<br/>Speed_X<br/>HSpeed|

#### **VerticalSpeed**
The vertical scroll speed.

|Type      |Required|Position|PipelineInput        |Aliases                      |
|----------|--------|--------|---------------------|-----------------------------|
|`[Double]`|false   |2       |true (ByPropertyName)|SpeedY<br/>Speed_Y<br/>VSpeed|

#### **NoLoop**
If set, will not loop

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **LimitWidth**
If provided, will limit the width.

|Type      |Required|Position|PipelineInput        |Aliases                           |
|----------|--------|--------|---------------------|----------------------------------|
|`[Double]`|false   |3       |true (ByPropertyName)|LimitX<br/>Limit_CX<br/>WidthLimit|

#### **LimitHeight**
If provided, will limit the height.

|Type      |Required|Position|PipelineInput        |Aliases                            |
|----------|--------|--------|---------------------|-----------------------------------|
|`[Double]`|false   |4       |true (ByPropertyName)|LimitY<br/>Limit_CY<br/>HeightLimit|

#### **Force**
If set, will remove a filter if one already exists.    
If this is not provided and the filter already exists, the settings of the filter will be changed.

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |

---

### Syntax
```PowerShell
Set-OBSScrollFilter [[-HorizontalSpeed] <Double>] [[-VerticalSpeed] <Double>] [-NoLoop] [[-LimitWidth] <Double>] [[-LimitHeight] <Double>] [-Force] [<CommonParameters>]
```
