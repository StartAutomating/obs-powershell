Get-OBSSceneItemTransform
-------------------------
### Synopsis
Get-OBSSceneItemTransform : GetSceneItemTransform

---
### Description

Gets the transform and crop info of a scene item.

Scenes and Groups


Get-OBSSceneItemTransform calls the OBS WebSocket with a request of type GetSceneItemTransform.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemtransform](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemtransform)



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
#### **PassThru**

> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Get-OBSSceneItemTransform [-sceneName] <String> [-sceneItemId] <Double> [-PassThru] [<CommonParameters>]
```
---
