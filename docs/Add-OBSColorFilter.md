Set-OBSColorFilter
------------------

### Synopsis
Sets a color filter

---

### Description

Adds or Changes a Color Correction Filter on an OBS Input.    
This allows you to:    
* Change Opacity on any source    
* Correct gamma    
* Spin the hue    
* Saturate or Desaturate an image    
* Change the contrast    
* Brighten the image    
* Multiply pixels by a color    
* Add a color to all pixels

---

### Examples
> EXAMPLE 1

```PowerShell
Show-OBS -Uri .\Assets\obs-powershell-animated-icon.svg |    
    Set-OBSColorFilter -Opacity .5
```

---

### Parameters
#### **Opacity**
The opacity, as a number between 0 and 1.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |1       |true (ByPropertyName)|

#### **Brightness**
The brightness, as a number between -1 and 1.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |2       |true (ByPropertyName)|

#### **Contrast**
The constrast, as a number between -4 and 4.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |3       |true (ByPropertyName)|

#### **Gamma**
The gamma correction, as a number between -3 and 3.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |4       |true (ByPropertyName)|

#### **Saturation**
The saturation, as a number between -1 and 5.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |5       |true (ByPropertyName)|

#### **Hue**
The change in hue, as represented in degrees around a color cicrle

|Type      |Required|Position|PipelineInput        |Aliases|
|----------|--------|--------|---------------------|-------|
|`[Double]`|false   |6       |true (ByPropertyName)|Spin   |

#### **MultiplyColor**
Multiply this color by all pixels within the source.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |7       |true (ByPropertyName)|

#### **AddColor**
Add all this color to all pixels within the source.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |8       |true (ByPropertyName)|

#### **Force**
If set, will remove a filter if one already exists.    
If this is not provided and the filter already exists, the settings of the filter will be changed.

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |

---

### Syntax
```PowerShell
Set-OBSColorFilter [[-Opacity] <Double>] [[-Brightness] <Double>] [[-Contrast] <Double>] [[-Gamma] <Double>] [[-Saturation] <Double>] [[-Hue] <Double>] [[-MultiplyColor] <String>] [[-AddColor] <String>] [-Force] [<CommonParameters>]
```
