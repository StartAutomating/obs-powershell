Get-OBSSceneItemIndex
---------------------
### Synopsis
Get-OBSSceneItemIndex : GetSceneItemIndex

---
### Description

Gets the index position of a scene item in a scene.

An index of 0 is at the bottom of the source list in the UI.

Scenes and Groups


Get-OBSSceneItemIndex calls the OBS WebSocket with a request of type GetSceneItemIndex.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemindex](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemindex)



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
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Get-OBSSceneItemIndex [-SceneName] <String> [-SceneItemId] <Double> [-PassThru] [<CommonParameters>]
```
---
