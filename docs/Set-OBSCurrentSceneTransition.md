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
#### **TransitionName**

Name of the transition to make active






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
Set-OBSCurrentSceneTransition [-TransitionName] <String> [-PassThru] [<CommonParameters>]
```
---
