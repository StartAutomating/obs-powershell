Set-OBS3DFilter
---------------

### Synopsis
Sets an OBS 3D Filter.

---

### Description

Adds or Changes a 3D Filter on an OBS Input.    
This requires the [3D Effect](https://github.com/exeldro/obs-3d-effect).

---

### Parameters
#### **FieldOfView**
The Field of View

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |1       |true (ByPropertyName)|

#### **RotationX**
The Rotation along the X-axis

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |2       |true (ByPropertyName)|

#### **RotationY**
The Rotation along the Y-axis

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |3       |true (ByPropertyName)|

#### **RotationZ**
The Rotation along the Z-axis

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |4       |true (ByPropertyName)|

#### **PositionX**
The Position along the X-axis

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |5       |true (ByPropertyName)|

#### **PositionY**
The Position along the Y-axis

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |6       |true (ByPropertyName)|

#### **PositionZ**
The Position along the Z-axis

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |7       |true (ByPropertyName)|

#### **ScaleX**
The scale of the source along the X-axis

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |8       |true (ByPropertyName)|

#### **ScaleY**
The scale of the source along the Y-axis

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |9       |true (ByPropertyName)|

#### **Force**
If set, will remove a filter if one already exists.    
If this is not provided and the filter already exists, the settings of the filter will be changed.

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |

---

### Syntax
```PowerShell
Set-OBS3DFilter [[-FieldOfView] <Double>] [[-RotationX] <Double>] [[-RotationY] <Double>] [[-RotationZ] <Double>] [[-PositionX] <Double>] [[-PositionY] <Double>] [[-PositionZ] <Double>] [[-ScaleX] <Double>] [[-ScaleY] <Double>] [-Force] [<CommonParameters>]
```
