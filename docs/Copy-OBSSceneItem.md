Copy-OBSSceneItem
-----------------
### Synopsis
Copy-OBSSceneItem : DuplicateSceneItem

---
### Description

Duplicates a scene item, copying all transform and crop info.

Scenes only


Copy-OBSSceneItem calls the OBS WebSocket with a request of type DuplicateSceneItem.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#duplicatesceneitem](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#duplicatesceneitem)



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
#### **DestinationSceneName**

Name of the scene to create the duplicated item in



> **Type**: ```[String]```

> **Required**: false

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
Copy-OBSSceneItem [-SceneName] <String> [-SceneItemId] <Double> [[-DestinationSceneName] <String>] [-PassThru] [<CommonParameters>]
```
---
