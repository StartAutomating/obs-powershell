Get-OBSInputMute
----------------
### Synopsis
Get-OBSInputMute : GetInputMute

---
### Description

Gets the audio mute state of an input.


Get-OBSInputMute calls the OBS WebSocket with a request of type GetInputMute.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputmute](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputmute)



---
### Parameters
#### **inputName**

Name of input to get the mute state of



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Get-OBSInputMute [-inputName] <String> [<CommonParameters>]
```
---
