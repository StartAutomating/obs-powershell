Switch-OBSInputMute
-------------------
### Synopsis
Switch-OBSInputMute : ToggleInputMute

---
### Description

Toggles the audio mute state of an input.


Switch-OBSInputMute calls the OBS WebSocket with a request of type ToggleInputMute.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#toggleinputmute](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#toggleinputmute)



---
### Parameters
#### **inputName**

Name of the input to toggle the mute state of



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **PassThru**

> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Switch-OBSInputMute [-inputName] <String> [-PassThru] [<CommonParameters>]
```
---
