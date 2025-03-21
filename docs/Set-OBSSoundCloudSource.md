Set-OBSSoundCloudSource
-----------------------

### Synopsis
Sets a Sound Cloud Source

---

### Description

Adds or changes a Sound Cloud source OBS.    
Sound Cloud Sources are Browser Sources that display a [SoundCloud Player Widget](https://developers.soundcloud.com/docs/api/html5-widget).

---

### Examples
> EXAMPLE 1

```PowerShell
Set-obssoundCloudSource -Uri https://soundcloud.com/outertone/sets/new-earth
```

---

### Parameters
#### **Uri**
The uri to display.  This must point to a SoundCloud URL.

|Type   |Required|Position|PipelineInput        |Aliases                                |
|-------|--------|--------|---------------------|---------------------------------------|
|`[Uri]`|false   |1       |true (ByPropertyName)|Url<br/>SoundCloudUri<br/>SoundCloudUrl|

#### **NoAutoPlay**
If set, will not autoplay.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **NoArtwork**
If set, will not display album artwork.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **NoPlayCount**
If set, will not display play count.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **NoUploaderInfo**
If set, will not display uploader info.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **TrackNumber**
If provided, will start playing at a given track number.

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |2       |true (ByPropertyName)|

#### **ShowShare**
If set, will show a share link.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **ShowDownload**
If set, will show a download link.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **ShowBuy**
If set, will show a buy link.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **Color**
The color used for the SoundCloud audio bars and buttons.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |3       |true (ByPropertyName)|

#### **Width**
The width of the browser source.    
If none is provided, this will be the output width of the video settings.

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |4       |true (ByPropertyName)|

#### **Height**
The width of the browser source.    
If none is provided, this will be the output height of the video settings.

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |5       |true (ByPropertyName)|

#### **CSS**
The css style used to render the browser page.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |6       |true (ByPropertyName)|

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
|`[Int32]`|false   |7       |true (ByPropertyName)|FPS    |

#### **Scene**
The name of the scene.    
If no scene name is provided, the current program scene will be used.

|Type      |Required|Position|PipelineInput        |Aliases  |
|----------|--------|--------|---------------------|---------|
|`[String]`|false   |8       |true (ByPropertyName)|SceneName|

#### **Name**
The name of the input.    
If no name is provided, then "SoundCloud" will be used.

|Type      |Required|Position|PipelineInput        |Aliases                 |
|----------|--------|--------|---------------------|------------------------|
|`[String]`|false   |9       |true (ByPropertyName)|InputName<br/>SourceName|

#### **Force**
If set, will check if the source exists in the scene before creating it and removing any existing sources found.    
If not set, you will get an error if a source with the same name exists.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

---

### Syntax
```PowerShell
Set-OBSSoundCloudSource [[-Uri] <Uri>] [-NoAutoPlay] [-NoArtwork] [-NoPlayCount] [-NoUploaderInfo] [[-TrackNumber] <Int32>] [-ShowShare] [-ShowDownload] [-ShowBuy] [[-Color] <String>] [[-Width] <Int32>] [[-Height] <Int32>] [[-CSS] <String>] [-ShutdownWhenHidden] [-RestartWhenActived] [-RerouteAudio] [[-FramesPerSecond] <Int32>] [[-Scene] <String>] [[-Name] <String>] [-Force] [<CommonParameters>]
```
