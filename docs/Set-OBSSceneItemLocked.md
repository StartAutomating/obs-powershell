Set-OBSSceneItemLocked
----------------------
### Synopsis
Set-OBSSceneItemLocked : SetSceneItemLocked

---
### Description

Sets the lock state of a scene item.

Scenes and Group


Set-OBSSceneItemLocked calls the OBS WebSocket with a request of type SetSceneItemLocked.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsceneitemlocked](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsceneitemlocked)



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
#### **sceneItemLocked**

New lock state of the scene item



> **Type**: ```[Switch]```

> **Required**: true

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Set-OBSSceneItemLocked [-sceneName] <String> [-sceneItemId] <Double> -sceneItemLocked [<CommonParameters>]
```
---
