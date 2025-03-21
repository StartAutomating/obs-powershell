Set-OBSBrowserSource
--------------------

### Synopsis
Sets a browser source

---

### Description

Adds or changes a browser source in OBS.

---

### Examples
> EXAMPLE 1

```PowerShell
Set-OBSBrowserSource -Uri https://pssvg.start-automating.com/Examples/Stars.svg
```

---

### Parameters
#### **Uri**
The uri or file path to display.    
If the uri points to a local file, this will be preferred

|Type   |Required|Position|PipelineInput        |Aliases                                        |
|-------|--------|--------|---------------------|-----------------------------------------------|
|`[Uri]`|false   |1       |true (ByPropertyName)|Url<br/>Href<br/>Path<br/>FilePath<br/>FullName|

#### **Width**
The width of the browser source.    
If none is provided, this will be the output width of the video settings.

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |2       |true (ByPropertyName)|

#### **Height**
The width of the browser source.    
If none is provided, this will be the output height of the video settings.

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |3       |true (ByPropertyName)|

#### **CSS**
The css style used to render the browser page.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |4       |true (ByPropertyName)|

#### **ShutdownWhenHidden**
If set, the browser source will shutdown when it is hidden

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **RestartWhenActived**
If set, the browser source will restart when it is activated.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **RerouteAudio**
If set, audio from the browser source will be rerouted into OBS.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **FramesPerSecond**
If provided, the browser source will render at a custom frame rate.

|Type     |Required|Position|PipelineInput        |Aliases|
|---------|--------|--------|---------------------|-------|
|`[Int32]`|false   |5       |true (ByPropertyName)|FPS    |

#### **Scene**
The name of the scene.    
If no scene name is provided, the current program scene will be used.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |6       |true (ByPropertyName)|

#### **Name**
The name of the input.    
If no name is provided, the last segment of the URI or file path will be the input name.

|Type      |Required|Position|PipelineInput        |Aliases                 |
|----------|--------|--------|---------------------|------------------------|
|`[String]`|false   |7       |true (ByPropertyName)|InputName<br/>SourceName|

#### **Force**
If set, will check if the source exists in the scene before creating it and removing any existing sources found.    
If not set, you will get an error if a source with the same name exists.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

---

### Syntax
```PowerShell
Set-OBSBrowserSource [[-Uri] <Uri>] [[-Width] <Int32>] [[-Height] <Int32>] [[-CSS] <String>] [-ShutdownWhenHidden] [-RestartWhenActived] [-RerouteAudio] [[-FramesPerSecond] <Int32>] [[-Scene] <String>] [[-Name] <String>] [-Force] [<CommonParameters>]
```
