Get-OBSInputAudioTracks
-----------------------
### Synopsis
Get-OBSInputAudioTracks : GetInputAudioTracks

---
### Description

Gets the enable state of all audio tracks of an input.


Get-OBSInputAudioTracks calls the OBS WebSocket with a request of type GetInputAudioTracks.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputaudiotracks](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputaudiotracks)



---
### Parameters
#### **inputName**

Name of the input



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
Get-OBSInputAudioTracks [-inputName] <String> [-PassThru] [<CommonParameters>]
```
---
