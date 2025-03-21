Set-OBSMediaSource
------------------

### Synopsis
Adds a media source

---

### Description

Adds a media source to OBS.

---

### Related Links
* [Add-OBSInput](Add-OBSInput.md)

* [Set-OBSInputSettings](Set-OBSInputSettings.md)

---

### Examples
> EXAMPLE 1

```PowerShell
Set-OBSMediaSource -FilePath My.mp4
```

---

### Parameters
#### **FilePath**
The path to the media file.

|Type      |Required|Position|PipelineInput        |Aliases                              |
|----------|--------|--------|---------------------|-------------------------------------|
|`[String]`|false   |1       |true (ByPropertyName)|FullName<br/>LocalFile<br/>local_file|

#### **CloseWhenInactive**
If set, the source will close when it is inactive.    
By default, this will be set to true.    
To explicitly set it to false, use -CloseWhenInactive:$false

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **Loop**
If set, the source will automatically restart.

|Type      |Required|Position|PipelineInput        |Aliases|
|----------|--------|--------|---------------------|-------|
|`[Switch]`|false   |named   |true (ByPropertyName)|Looping|

#### **UseHardwareDecoding**
If set, will use hardware decoding, if available.

|Type      |Required|Position|PipelineInput        |Aliases                       |
|----------|--------|--------|---------------------|------------------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|HardwareDecoding<br/>hw_decode|

#### **ClearOnMediaEnd**
If set, will clear the output on the end of the media.    
If this is set to false, the media will freeze on the last frame.    
This is set to true by default.    
To explicitly set to false, use -ClearMediaEnd:$false

|Type      |Required|Position|PipelineInput        |Aliases                          |
|----------|--------|--------|---------------------|---------------------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|ClearOnEnd<br/>NoFreezeFrameOnEnd|

#### **FFMpegOption**
Any FFMpeg demuxer options.

|Type      |Required|Position|PipelineInput        |Aliases                         |
|----------|--------|--------|---------------------|--------------------------------|
|`[String]`|false   |2       |true (ByPropertyName)|FFMpegOptions<br/>FFMpeg_Options|

#### **Scene**
The name of the scene.    
If no scene name is provided, the current program scene will be used.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |3       |true (ByPropertyName)|

#### **Name**
The name of the input.    
If no name is provided, the last segment of the URI or file path will be the input name.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |4       |true (ByPropertyName)|

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
Set-OBSMediaSource [[-FilePath] <String>] [-CloseWhenInactive] [-Loop] [-UseHardwareDecoding] [-ClearOnMediaEnd] [[-FFMpegOption] <String>] [[-Scene] <String>] [[-Name] <String>] [-Force] [-FitToScreen] [<CommonParameters>]
```
