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



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Get-OBSInputAudioSyncOffset [-InputName] <String> [-PassThru] [<CommonParameters>]
```
---
