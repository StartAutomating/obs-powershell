Add-OBSBrowserSource
--------------------
### Synopsis
Adds a browser source

---
### Description

Adds a browser source to OBS.

---
### Examples
#### EXAMPLE 1
```PowerShell
Add-OBSBrowserSource
```

---
### Parameters
#### **Uri**

The uri or file path to display.
If the uri points to a local file, this will be preferred



> **Type**: ```[Uri]```

> **Required**: false

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **Width**

The width of the browser source.
If none is provided, this will be the output width of the video settings.



> **Type**: ```[Int32]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **Height**

The width of the browser source.
If none is provided, this will be the output height of the video settings.



> **Type**: ```[Int32]```

> **Required**: false

> **Position**: 3

> **PipelineInput**:true (ByPropertyName)



---
#### **CSS**

The css style used to render the browser page.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 4

> **PipelineInput**:true (ByPropertyName)



---
#### **ShutdownWhenHidden**

If set, the browser source will shutdown when it is hidden



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **RestartWhenActived**

If set, the browser source will restart when it is activated.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **RerouteAudio**

If set, audio from the browser source will be rerouted into OBS.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **FramesPerSecond**

If provided, the browser source will render at a custom frame rate.



> **Type**: ```[Int32]```

> **Required**: false

> **Position**: 5

> **PipelineInput**:true (ByPropertyName)



---
#### **Scene**

The name of the scene.
If no scene name is provided, the current program scene will be used.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 6

> **PipelineInput**:true (ByPropertyName)



---
#### **Name**

The name of the input.
If no name is provided, the last segment of the URI or file path will be the input name.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 7

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Add-OBSBrowserSource [[-Uri] <Uri>] [[-Width] <Int32>] [[-Height] <Int32>] [[-CSS] <String>] [-ShutdownWhenHidden] [-RestartWhenActived] [-RerouteAudio] [[-FramesPerSecond] <Int32>] [[-Scene] <String>] [[-Name] <String>] [<CommonParameters>]
```
---
