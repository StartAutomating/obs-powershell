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
#### **sceneName**

Scene to set as the current preview scene



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Set-OBSCurrentPreviewScene [-sceneName] <String> [<CommonParameters>]
```
---
