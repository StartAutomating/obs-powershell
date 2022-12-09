Get-OBSSceneItemLocked
----------------------
### Synopsis
Get-OBSSceneItemLocked : GetSceneItemLocked

---
### Description

Gets the lock state of a scene item.

Scenes and Groups


Get-OBSSceneItemLocked calls the OBS WebSocket with a request of type GetSceneItemLocked.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemlocked](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemlocked)



---
### Parameters
#### **sceneName**

Name of the scene the item is in



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **sceneItemId**

Numeric ID of the scene item



> **Type**: ```[Double]```

> **Required**: true

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Get-OBSSceneItemLocked [-sceneName] <String> [-sceneItemId] <Double> [<CommonParameters>]
```
---
