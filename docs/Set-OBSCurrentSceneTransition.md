Set-OBSCurrentSceneTransition
-----------------------------
### Synopsis
Set-OBSCurrentSceneTransition : SetCurrentSceneTransition

---
### Description

Sets the current scene transition.

Small note: While the namespace of scene transitions is generally unique, that uniqueness is not a guarantee as it is with other resources like inputs.


Set-OBSCurrentSceneTransition calls the OBS WebSocket with a request of type SetCurrentSceneTransition.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentscenetransition](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentscenetransition)



---
### Parameters
#### **transitionName**

Name of the transition to make active



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
Set-OBSCurrentSceneTransition [-transitionName] <String> [-PassThru] [<CommonParameters>]
```
---
