Remove-OBSScene
---------------
### Synopsis
Remove-OBSScene : RemoveScene

---
### Description

Removes a scene from OBS.


Remove-OBSScene calls the OBS WebSocket with a request of type RemoveScene.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#removescene](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#removescene)



---
### Parameters
#### **sceneName**

Name of the scene to remove



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
Remove-OBSScene [-sceneName] <String> [-PassThru] [<CommonParameters>]
```
---
