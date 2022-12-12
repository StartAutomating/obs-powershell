Get-OBSSceneTransition
----------------------
### Synopsis
Get-OBSSceneTransition : GetSceneTransitionList

---
### Description

Gets an array of all scene transitions in OBS.


Get-OBSSceneTransition calls the OBS WebSocket with a request of type GetSceneTransitionList.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getscenetransitionlist](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getscenetransitionlist)



---
### Examples
#### EXAMPLE 1
```PowerShell
Get-OBSSceneTransition
```

---
### Parameters
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Get-OBSSceneTransition [-PassThru] [<CommonParameters>]
```
---
