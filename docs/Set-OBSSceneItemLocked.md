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
#### **SceneName**

Name of the scene the item is in



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **SceneItemId**

Numeric ID of the scene item



> **Type**: ```[Double]```

> **Required**: true

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **SceneItemLocked**

New lock state of the scene item



> **Type**: ```[Switch]```

> **Required**: true

> **Position**: named

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
Set-OBSSceneItemLocked [-SceneName] <String> [-SceneItemId] <Double> -SceneItemLocked [-PassThru] [<CommonParameters>]
```
---
