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



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **CloseWhenInactive**

If set, the source will close when it is inactive.
By default, this will be set to true.
To explicitly set it to false, use -CloseWhenInactive:$false



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **Loop**

If set, the source will automatically restart.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **UseHardwareDecoding**

If set, will use hardware decoding, if available.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **ClearOnMediaEnd**

If set, will clear the output on the end of the media.
If this is set to false, the media will freeze on the last frame.
This is set to true by default.
To explicitly set to false, use -ClearMediaEnd:$false



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **FFMpegOption**

Any FFMpeg demuxer options.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **Scene**

The name of the scene.
If no scene name is provided, the current program scene will be used.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 3

> **PipelineInput**:true (ByPropertyName)



---
#### **Name**

The name of the input.
If no name is provided, the last segment of the URI or file path will be the input name.



> **Type**: ```[String]```

> **Required**: false

> **Position**: 4

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Add-OBSMediaSource [-FilePath] <String> [-CloseWhenInactive] [-Loop] [-UseHardwareDecoding] [-ClearOnMediaEnd] [[-FFMpegOption] <String>] [[-Scene] <String>] [[-Name] <String>] [<CommonParameters>]
```
---
