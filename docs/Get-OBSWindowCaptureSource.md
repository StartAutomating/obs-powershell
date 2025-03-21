Set-OBSWindowSource
-------------------

### Synopsis
Adds or sets a window capture source

---

### Description

Adds or sets a windows capture source in OBS.  This captures the contents of a window.

---

### Examples
> EXAMPLE 1

```PowerShell
Get-Process -id $PID | Set-OBSWindowCaptureSource -Name CurrentWindow
```

---

### Parameters
#### **WindowTitle**
The monitor number.    
This the number of the monitor you would like to capture.

|Type      |Required|Position|PipelineInput        |Aliases                                                  |
|----------|--------|--------|---------------------|---------------------------------------------------------|
|`[String]`|false   |1       |true (ByPropertyName)|ItemValue<br/>ItemName<br/>WindowName<br/>MainWindowTitle|

#### **CaptureMethod**
The number of the capture method.  By default, automatic (0).

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |2       |true (ByPropertyName)|

#### **CapturePriority**
The capture priority.
Valid Values:

* ExactMatch
* SameType
* SameExecutable

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |3       |true (ByPropertyName)|

#### **CaptureCursor**
If set, will capture the cursor.    
This will be set by default.    
If explicitly set to false, the cursor will not be captured.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **ClientArea**
If set, will capture the client area.    
This will be set by default.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **ForceSDR**
If set, will force SDR.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **Scene**
The name of the scene.    
If no scene name is provided, the current program scene will be used.

|Type      |Required|Position|PipelineInput        |Aliases  |
|----------|--------|--------|---------------------|---------|
|`[String]`|false   |4       |true (ByPropertyName)|SceneName|

#### **Name**
The name of the input.    
If no name is provided, "Display $($Monitor + 1)" will be the input source name.

|Type      |Required|Position|PipelineInput        |Aliases  |
|----------|--------|--------|---------------------|---------|
|`[String]`|false   |5       |true (ByPropertyName)|InputName|

#### **Force**
If set, will check if the source exists in the scene before creating it and removing any existing sources found.    
If not set, you will get an error if a source with the same name exists.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

---

### Syntax
```PowerShell
Set-OBSWindowSource [[-WindowTitle] <String>] [[-CaptureMethod] <Int32>] [[-CapturePriority] <String>] [-CaptureCursor] [-ClientArea] [-ForceSDR] [[-Scene] <String>] [[-Name] <String>] [-Force] [<CommonParameters>]
```
