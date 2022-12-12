Get-OBSCurrentSceneTransitionCursor
-----------------------------------
### Synopsis
Get-OBSCurrentSceneTransitionCursor : GetCurrentSceneTransitionCursor

---
### Description

Gets the cursor position of the current scene transition.

Note: `transitionCursor` will return 1.0 when the transition is inactive.


Get-OBSCurrentSceneTransitionCursor calls the OBS WebSocket with a request of type GetCurrentSceneTransitionCursor.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getcurrentscenetransitioncursor](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getcurrentscenetransitioncursor)



---
### Examples
#### EXAMPLE 1
```PowerShell
Get-OBSCurrentSceneTransitionCursor
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
Get-OBSCurrentSceneTransitionCursor [-PassThru] [<CommonParameters>]
```
---
