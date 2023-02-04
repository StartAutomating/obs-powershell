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
|`[String]`|true    |1       |true (ByPropertyName)|



---
#### **InputAudioSyncOffset**

New audio sync offset in milliseconds






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|true    |2       |true (ByPropertyName)|



---
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
### Syntax
```PowerShell
Set-OBSInputAudioSyncOffset [-InputName] <String> [-InputAudioSyncOffset] <Double> [-PassThru] [<CommonParameters>]
```
---
