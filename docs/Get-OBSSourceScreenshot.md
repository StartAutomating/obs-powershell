Get-OBSSourceScreenshot
-----------------------
### Synopsis
Get-OBSSourceScreenshot : GetSourceScreenshot

---
### Description

Gets a Base64-encoded screenshot of a source.

The `imageWidth` and `imageHeight` parameters are treated as "scale to inner", meaning the smallest ratio will be used and the aspect ratio of the original resolution is kept.
If `imageWidth` and `imageHeight` are not specified, the compressed image will use the full resolution of the source.

**Compatible with inputs and scenes.**


Get-OBSSourceScreenshot calls the OBS WebSocket with a request of type GetSourceScreenshot.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsourcescreenshot](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsourcescreenshot)



---
### Parameters
#### **SourceName**

Name of the source to take a screenshot of






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|



---
#### **ImageFormat**

Image compression format to use. Use `GetVersion` to get compatible image formats






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |2       |true (ByPropertyName)|



---
#### **ImageWidth**

Width to scale the screenshot to






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |3       |true (ByPropertyName)|



---
#### **ImageHeight**

Height to scale the screenshot to






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |4       |true (ByPropertyName)|



---
#### **ImageCompressionQuality**

Compression quality to use. 0 for high compression, 100 for uncompressed. -1 to use "default" (whatever that means, idk)






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |5       |true (ByPropertyName)|



---
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
### Syntax
```PowerShell
Get-OBSSourceScreenshot [-SourceName] <String> [-ImageFormat] <String> [[-ImageWidth] <Double>] [[-ImageHeight] <Double>] [[-ImageCompressionQuality] <Double>] [-PassThru] [<CommonParameters>]
```
---
