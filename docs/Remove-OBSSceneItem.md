Remove-OBSSceneItem
-------------------
### Synopsis
Remove-OBSSceneItem : RemoveSceneItem

---
### Description

Removes a scene item from a scene.

Scenes only


Remove-OBSSceneItem calls the OBS WebSocket with a request of type RemoveSceneItem.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#removesceneitem](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#removesceneitem)



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
Remove-OBSSceneItem [-SceneName] <String> [-SceneItemId] <Double> [-PassThru] [<CommonParameters>]
```
---
