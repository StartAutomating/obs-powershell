Get-OBSCurrentProgramScene
--------------------------
### Synopsis
Get-OBSCurrentProgramScene : GetCurrentProgramScene

---
### Description

Gets the current program scene.


Get-OBSCurrentProgramScene calls the OBS WebSocket with a request of type GetCurrentProgramScene.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getcurrentprogramscene](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getcurrentprogramscene)



---
### Examples
#### EXAMPLE 1
```PowerShell
Get-OBSCurrentProgramScene
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
Get-OBSCurrentProgramScene [-PassThru] [<CommonParameters>]
```
---
