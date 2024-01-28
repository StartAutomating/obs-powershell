Set-OBSDisplaySource
--------------------

### Synopsis
Adds a display source

---

### Description

Adds a display source to OBS.  This captures the contents of the display.

---

### Examples
> EXAMPLE 1

```PowerShell
Add-OBSDisplaySource  # Adds a display source of the primary monitor
```
> EXAMPLE 2

```PowerShell
Add-OBSDisplaySource -Display 2 # Adds a display source of the second monitor
```

---

### Parameters
#### **Monitor**
The monitor number.    
This the number of the monitor you would like to capture.

|Type     |Required|Position|PipelineInput        |Aliases                                    |
|---------|--------|--------|---------------------|-------------------------------------------|
|`[Int32]`|false   |1       |true (ByPropertyName)|MonitorNumber<br/>Display<br/>DisplayNumber|

#### **CaptureCursor**
If set, will capture the cursor.    
This will be set by default.    
If explicitly set to false, the cursor will not be captured.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **Scene**
The name of the scene.    
If no scene name is provided, the current program scene will be used.

|Type      |Required|Position|PipelineInput        |Aliases  |
|----------|--------|--------|---------------------|---------|
|`[String]`|false   |2       |true (ByPropertyName)|SceneName|

#### **Name**
The name of the input.    
If no name is provided, "Display $($Monitor + 1)" will be the input source name.

|Type      |Required|Position|PipelineInput        |Aliases  |
|----------|--------|--------|---------------------|---------|
|`[String]`|false   |3       |true (ByPropertyName)|InputName|

#### **Force**
If set, will check if the source exists in the scene before creating it and removing any existing sources found.    
If not set, you will get an error if a source with the same name exists.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

---

### Syntax
```PowerShell
Set-OBSDisplaySource [[-Monitor] <Int32>] [-CaptureCursor] [[-Scene] <String>] [[-Name] <String>] [-Force] [<CommonParameters>]
```
