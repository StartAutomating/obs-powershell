Set-OBSSceneItemTransform
-------------------------
### Synopsis
Set-OBSSceneItemTransform : SetSceneItemTransform

---
### Description

Sets the transform and crop info of a scene item.


Set-OBSSceneItemTransform calls the OBS WebSocket with a request of type SetSceneItemTransform.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsceneitemtransform](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsceneitemtransform)



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
#### **sceneItemTransform**

Object containing scene item transform info to update



> **Type**: ```[PSObject]```

> **Required**: true

> **Position**: 3

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Set-OBSSceneItemTransform [-sceneName] <String> [-sceneItemId] <Double> [-sceneItemTransform] <PSObject> [<CommonParameters>]
```
---
