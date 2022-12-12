Get-OBSCurrentPreviewScene
--------------------------
### Synopsis
Get-OBSCurrentPreviewScene : GetCurrentPreviewScene

---
### Description

Gets the current preview scene.

Only available when studio mode is enabled.


Get-OBSCurrentPreviewScene calls the OBS WebSocket with a request of type GetCurrentPreviewScene.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getcurrentpreviewscene](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getcurrentpreviewscene)



---
### Examples
#### EXAMPLE 1
```PowerShell
Get-OBSCurrentPreviewScene
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
Get-OBSCurrentPreviewScene [-PassThru] [<CommonParameters>]
```
---
