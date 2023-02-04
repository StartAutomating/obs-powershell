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






|Type   |Required|Position|PipelineInput        |
|-------|--------|--------|---------------------|
|`[Uri]`|false   |1       |true (ByPropertyName)|



---
#### **Width**

The width of the browser source.
If none is provided, this will be the output width of the video settings.






|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |2       |true (ByPropertyName)|



---
#### **Height**

The width of the browser source.
If none is provided, this will be the output height of the video settings.






|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |3       |true (ByPropertyName)|



---
#### **CSS**

The css style used to render the browser page.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |4       |true (ByPropertyName)|



---
#### **ShutdownWhenHidden**

If set, the browser source will shutdown when it is hidden






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
#### **RestartWhenActived**

If set, the browser source will restart when it is activated.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
#### **RerouteAudio**

If set, audio from the browser source will be rerouted into OBS.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
#### **FramesPerSecond**

If provided, the browser source will render at a custom frame rate.






|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |5       |true (ByPropertyName)|



---
#### **Scene**

The name of the scene.
If no scene name is provided, the current program scene will be used.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |6       |true (ByPropertyName)|



---
#### **Name**

The name of the input.
If no name is provided, the last segment of the URI or file path will be the input name.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |7       |true (ByPropertyName)|



---
### Syntax
```PowerShell
Add-OBSBrowserSource [[-Uri] <Uri>] [[-Width] <Int32>] [[-Height] <Int32>] [[-CSS] <String>] [-ShutdownWhenHidden] [-RestartWhenActived] [-RerouteAudio] [[-FramesPerSecond] <Int32>] [[-Scene] <String>] [[-Name] <String>] [<CommonParameters>]
```
---
