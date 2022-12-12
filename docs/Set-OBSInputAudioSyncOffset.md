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
#### **inputName**

Name of the input to set the audio sync offset of



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **inputAudioSyncOffset**

New audio sync offset in milliseconds



> **Type**: ```[Double]```

> **Required**: true

> **Position**: 2

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
Set-OBSInputAudioSyncOffset [-inputName] <String> [-inputAudioSyncOffset] <Double> [-PassThru] [<CommonParameters>]
```
---
