Save-OBSSourceScreenshot
------------------------
### Synopsis
Save-OBSSourceScreenshot : SaveSourceScreenshot

---
### Description

Saves a screenshot of a source to the filesystem.

The `imageWidth` and `imageHeight` parameters are treated as "scale to inner", meaning the smallest ratio will be used and the aspect ratio of the original resolution is kept.
If `imageWidth` and `imageHeight` are not specified, the compressed image will use the full resolution of the source.

**Compatible with inputs and scenes.**


Save-OBSSourceScreenshot calls the OBS WebSocket with a request of type SaveSourceScreenshot.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#savesourcescreenshot](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#savesourcescreenshot)



---
### Parameters
#### **sourceName**

Name of the source to take a screenshot of



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **imageFormat**

Image compression format to use. Use `GetVersion` to get compatible image formats



> **Type**: ```[String]```

> **Required**: true

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **imageFilePath**

Path to save the screenshot file to. Eg. `C:\Users\user\Desktop\screenshot.png`



> **Type**: ```[String]```

> **Required**: true

> **Position**: 3

> **PipelineInput**:true (ByPropertyName)



---
#### **imageWidth**

Width to scale the screenshot to



> **Type**: ```[Double]```

> **Required**: false

> **Position**: 4

> **PipelineInput**:true (ByPropertyName)



---
#### **imageHeight**

Height to scale the screenshot to



> **Type**: ```[Double]```

> **Required**: false

> **Position**: 5

> **PipelineInput**:true (ByPropertyName)



---
#### **imageCompressionQuality**

Compression quality to use. 0 for high compression, 100 for uncompressed. -1 to use "default" (whatever that means, idk)



> **Type**: ```[Double]```

> **Required**: false

> **Position**: 6

> **PipelineInput**:true (ByPropertyName)



---
#### **PassThru**

> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Save-OBSSourceScreenshot [-sourceName] <String> [-imageFormat] <String> [-imageFilePath] <String> [[-imageWidth] <Double>] [[-imageHeight] <Double>] [[-imageCompressionQuality] <Double>] [-PassThru] [<CommonParameters>]
```
---
