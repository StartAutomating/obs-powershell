Add-OBSMediaSource
------------------
### Synopsis
Adds a media source

---
### Description

Adds a media source to OBS.

---
### Related Links
* [Add-OBSInput](Add-OBSInput.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
Add-OBSMediaSource -FilePath My.mp4
```

---
### Parameters
#### **FilePath**

The path to the media file.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|



---
#### **CloseWhenInactive**

If set, the source will close when it is inactive.
By default, this will be set to true.
To explicitly set it to false, use -CloseWhenInactive:$false






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
#### **Loop**

If set, the source will automatically restart.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
#### **UseHardwareDecoding**

If set, will use hardware decoding, if available.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
#### **ClearOnMediaEnd**

If set, will clear the output on the end of the media.
If this is set to false, the media will freeze on the last frame.
This is set to true by default.
To explicitly set to false, use -ClearMediaEnd:$false






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
#### **FFMpegOption**

Any FFMpeg demuxer options.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |2       |true (ByPropertyName)|



---
#### **Scene**

The name of the scene.
If no scene name is provided, the current program scene will be used.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |3       |true (ByPropertyName)|



---
#### **Name**

The name of the input.
If no name is provided, the last segment of the URI or file path will be the input name.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |4       |true (ByPropertyName)|



---
### Syntax
```PowerShell
Add-OBSMediaSource [-FilePath] <String> [-CloseWhenInactive] [-Loop] [-UseHardwareDecoding] [-ClearOnMediaEnd] [[-FFMpegOption] <String>] [[-Scene] <String>] [[-Name] <String>] [<CommonParameters>]
```
---
