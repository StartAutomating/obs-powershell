Set-OBSInputAudioSyncOffset
---------------------------

### Synopsis
Set-OBSInputAudioSyncOffset : SetInputAudioSyncOffset

---

### Description

Sets the audio sync offset of an input.

Set-OBSInputAudioSyncOffset calls the OBS WebSocket with a request of type SetInputAudioSyncOffset.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputaudiosyncoffset](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputaudiosyncoffset)

---

### Parameters
#### **InputName**
Name of the input to set the audio sync offset of

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |1       |true (ByPropertyName)|

#### **InputUuid**
UUID of the input to set the audio sync offset of

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |2       |true (ByPropertyName)|

#### **InputAudioSyncOffset**
New audio sync offset in milliseconds

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|true    |3       |true (ByPropertyName)|

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
Set-OBSInputAudioSyncOffset [[-InputName] <String>] [[-InputUuid] <String>] [-InputAudioSyncOffset] <Double> [-PassThru] [-NoResponse] [<CommonParameters>]
```
