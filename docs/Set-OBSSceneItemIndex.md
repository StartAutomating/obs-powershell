Set-OBSSceneItemIndex
---------------------
### Synopsis
Set-OBSSceneItemIndex : SetSceneItemIndex

---
### Description

Sets the index position of a scene item in a scene.

Scenes and Groups


Set-OBSSceneItemIndex calls the OBS WebSocket with a request of type SetSceneItemIndex.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsceneitemindex](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsceneitemindex)



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
#### **SceneItemIndex**

New index position of the scene item



> **Type**: ```[Double]```

> **Required**: true

> **Position**: 3

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
Set-OBSSceneItemIndex [-SceneName] <String> [-SceneItemId] <Double> [-SceneItemIndex] <Double> [-PassThru] [<CommonParameters>]
```
---
