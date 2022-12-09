Set-OBSInputMute
----------------
### Synopsis
Set-OBSInputMute : SetInputMute

---
### Description

Sets the audio mute state of an input.


Set-OBSInputMute calls the OBS WebSocket with a request of type SetInputMute.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputmute](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputmute)



---
### Parameters
#### **inputName**

Name of the input to set the mute state of



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **inputMuted**

Whether to mute the input or not



> **Type**: ```[Switch]```

> **Required**: true

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Set-OBSInputMute [-inputName] <String> -inputMuted [<CommonParameters>]
```
---
