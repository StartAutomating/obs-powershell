Set-OBSVLCSource
----------------

### Synopsis
Adds a VLC playlist source

---

### Description

Adds or sets VLC playlist sources to OBS.    
VLC must be installed for this to work.

---

### Related Links
* [Add-OBSInput](Add-OBSInput.md)

* [Set-OBSInputSettings](Set-OBSInputSettings.md)

---

### Examples
> EXAMPLE 1

```PowerShell
Set-OBSVLCSource -FilePath .\*.mp3 # Creates a playlist of all MP3s in the current directory
```

---

### Parameters
#### **FilePath**
The path to the media file.

|Type        |Required|Position|PipelineInput        |Aliases                                           |
|------------|--------|--------|---------------------|--------------------------------------------------|
|`[String[]]`|false   |1       |true (ByPropertyName)|FullName<br/>LocalFile<br/>local_file<br/>Playlist|

#### **Select**
What to select in the playlist.    
If a number is provided, this will select an index.    
If a string is provided, this will select the whole name or last part of a name, accepting wildcards.    
If an `[IO.FileInfo]` is provided, this will be the exact file.

|Type      |Required|Position|PipelineInput        |Aliases                   |
|----------|--------|--------|---------------------|--------------------------|
|`[Object]`|false   |2       |true (ByPropertyName)|SelectIndex<br/>SelectName|

#### **Shuffle**
If set, will shuffle the playlist

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **Loop**
If set, the playlist will loop.

|Type      |Required|Position|PipelineInput        |Aliases|
|----------|--------|--------|---------------------|-------|
|`[Switch]`|false   |named   |true (ByPropertyName)|Looping|

#### **Subtitle**
If set, will show subtitles, if available.

|Type      |Required|Position|PipelineInput        |Aliases                    |
|----------|--------|--------|---------------------|---------------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|ShowSubtitles<br/>Subtitles|

#### **AudioTrack**
The selected audio track number.

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |3       |true (ByPropertyName)|

#### **SubtitleTrack**
The selected subtitle track number.

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |4       |true (ByPropertyName)|

#### **Scene**
The name of the scene.    
If no scene name is provided, the current program scene will be used.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |5       |true (ByPropertyName)|

#### **Name**
The name of the input.    
If no name is provided, the last segment of the URI or file path will be the input name.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |6       |true (ByPropertyName)|

#### **Force**
If set, will check if the source exists in the scene before creating it and removing any existing sources found.    
If not set, you will get an error if a source with the same name exists.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **FitToScreen**
If set, will fit the input to the screen.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

---

### Syntax
```PowerShell
Set-OBSVLCSource [[-FilePath] <String[]>] [[-Select] <Object>] [-Shuffle] [-Loop] [-Subtitle] [[-AudioTrack] <Int32>] [[-SubtitleTrack] <Int32>] [[-Scene] <String>] [[-Name] <String>] [-Force] [-FitToScreen] [<CommonParameters>]
```
