Add-OBSColorSource
------------------
### Synopsis
Adds a color source

---
### Description

Adds a color source to OBS.  This displays a single 32-bit color (RGBA).

---
### Examples
#### EXAMPLE 1
```PowerShell
Add-OBSColorSource
```

---
### Parameters
#### **Scene**

The name of the scene.
If no scene name is provided, the current program scene will be used.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **Name**

The name of the input.
If no name is provided, "Display $($Monitor + 1)" will be the input source name.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **Color**

> **Type**: ```[String]```

> **Required**: false

> **Position**: 3

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Add-OBSColorSource [[-Scene] <String>] [[-Name] <String>] [[-Color] <String>] [<CommonParameters>]
```
---
