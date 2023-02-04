Get-OBSInputAudioSyncOffset
---------------------------
### Synopsis
Get-OBSInputAudioSyncOffset : GetInputAudioSyncOffset

---
### Description

Gets the audio sync offset of an input.

Note: The audio sync offset can be negative too!


Get-OBSInputAudioSyncOffset calls the OBS WebSocket with a request of type GetInputAudioSyncOffset.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputaudiosyncoffset](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputaudiosyncoffset)



---
### Parameters
#### **InputName**

Name of the input to get the audio sync offset of






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|



---
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
### Syntax
```PowerShell
Get-OBSInputAudioSyncOffset [-InputName] <String> [-PassThru] [<CommonParameters>]
```
---
