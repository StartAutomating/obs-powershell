Set-OBSCurrentSceneTransitionDuration
-------------------------------------
### Synopsis
Set-OBSCurrentSceneTransitionDuration : SetCurrentSceneTransitionDuration

---
### Description

Sets the duration of the current scene transition, if it is not fixed.


Set-OBSCurrentSceneTransitionDuration calls the OBS WebSocket with a request of type SetCurrentSceneTransitionDuration.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentscenetransitionduration](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentscenetransitionduration)



---
### Parameters
#### **TransitionDuration**

Duration in milliseconds



> **Type**: ```[Double]```

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
Set-OBSCurrentSceneTransitionDuration [-TransitionDuration] <Double> [-PassThru] [<CommonParameters>]
```
---
