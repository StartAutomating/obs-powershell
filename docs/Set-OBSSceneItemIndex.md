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
#### **sceneItemIndex**

New index position of the scene item



> **Type**: ```[Double]```

> **Required**: true

> **Position**: 3

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Set-OBSSceneItemIndex [-sceneName] <String> [-sceneItemId] <Double> [-sceneItemIndex] <Double> [<CommonParameters>]
```
---
