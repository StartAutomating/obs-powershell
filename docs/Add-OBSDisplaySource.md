Add-OBSDisplaySource
--------------------
### Synopsis
Adds a display source

---
### Description

Adds a display source to OBS.  This captures the contents of the display.

---
### Examples
#### EXAMPLE 1
```PowerShell
Add-OBSMonitorSource  # Adds a display source of the primary monitor
```

#### EXAMPLE 2
```PowerShell
Add-OBSMonitorSource -Display 2 # Adds a display source of the second monitor
```

---
### Parameters
#### **Monitor**

The monitor number.
This the number of the monitor you would like to capture.



> **Type**: ```[Int32]```

> **Required**: false

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **CaptureCursor**

If set, will capture the cursor.
This will be set by default.
If explicitly set to false, the cursor will not be captured.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Scene**

The name of the scene.
If no scene name is provided, the current program scene will be used.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **Name**

The name of the input.
If no name is provided, "Display $($Monitor + 1)" will be the input source name.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 3

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Add-OBSDisplaySource [[-Monitor] <Int32>] [-CaptureCursor] [[-Scene] <String>] [[-Name] <String>] [<CommonParameters>]
```
---
