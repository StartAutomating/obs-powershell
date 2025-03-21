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
#### **SourceName**
Name of the source to take a screenshot of

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |1       |true (ByPropertyName)|

#### **SourceUuid**
UUID of the source to take a screenshot of

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |2       |true (ByPropertyName)|

#### **ImageFormat**
Image compression format to use. Use `GetVersion` to get compatible image formats

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |3       |true (ByPropertyName)|

#### **ImageFilePath**
Path to save the screenshot file to. Eg. `C:\Users\user\Desktop\screenshot.png`

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |4       |true (ByPropertyName)|

#### **ImageWidth**
Width to scale the screenshot to

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |5       |true (ByPropertyName)|

#### **ImageHeight**
Height to scale the screenshot to

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |6       |true (ByPropertyName)|

#### **ImageCompressionQuality**
Compression quality to use. 0 for high compression, 100 for uncompressed. -1 to use "default" (whatever that means, idk)

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |7       |true (ByPropertyName)|

#### **PassThru**
If set, will return the information that would otherwise be sent to OBS.

|Type      |Required|Position|PipelineInput        |Aliases                      |
|----------|--------|--------|---------------------|-----------------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|OutputRequest<br/>OutputInput|

#### **NoResponse**
If set, will not attempt to receive a response from OBS.
This can increase performance, and also silently ignore critical errors

|Type      |Required|Position|PipelineInput        |Aliases                                                                |
|----------|--------|--------|---------------------|-----------------------------------------------------------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|NoReceive<br/>IgnoreResponse<br/>IgnoreReceive<br/>DoNotReceiveResponse|

---

### Syntax
```PowerShell
Save-OBSSourceScreenshot [[-SourceName] <String>] [[-SourceUuid] <String>] [-ImageFormat] <String> [-ImageFilePath] <String> [[-ImageWidth] <Double>] [[-ImageHeight] <Double>] [[-ImageCompressionQuality] <Double>] [-PassThru] [-NoResponse] [<CommonParameters>]
```
