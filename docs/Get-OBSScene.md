Get-OBSScene
------------
### Synopsis
Get-OBSScene : GetSceneList

---
### Description

Gets an array of all scenes in OBS.


Get-OBSScene calls the OBS WebSocket with a request of type GetSceneList.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getscenelist](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getscenelist)



---
### Examples
#### EXAMPLE 1
```PowerShell
Get-OBSScene
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
Get-OBSScene [-PassThru] [<CommonParameters>]
```
---
