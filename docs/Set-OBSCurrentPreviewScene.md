Set-OBSCurrentPreviewScene
--------------------------
### Synopsis
Set-OBSCurrentPreviewScene : SetCurrentPreviewScene

---
### Description

Sets the current preview scene.

Only available when studio mode is enabled.


Set-OBSCurrentPreviewScene calls the OBS WebSocket with a request of type SetCurrentPreviewScene.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentpreviewscene](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentpreviewscene)



---
### Parameters
#### **SceneName**

Scene to set as the current preview scene



> **Type**: ```[String]```

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
Set-OBSCurrentPreviewScene [-SceneName] <String> [-PassThru] [<CommonParameters>]
```
---
