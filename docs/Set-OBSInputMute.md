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
#### **InputName**

Name of the input to set the mute state of



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **InputMuted**

Whether to mute the input or not



> **Type**: ```[Switch]```

> **Required**: true

> **Position**: named

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
Set-OBSInputMute [-InputName] <String> -InputMuted [-PassThru] [<CommonParameters>]
```
---
