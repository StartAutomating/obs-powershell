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
#### **SceneItemTransform**

Object containing scene item transform info to update



> **Type**: ```[PSObject]```

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
Set-OBSSceneItemTransform [-SceneName] <String> [-SceneItemId] <Double> [-SceneItemTransform] <PSObject> [-PassThru] [<CommonParameters>]
```
---
