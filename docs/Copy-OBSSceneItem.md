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
#### **destinationSceneName**

Name of the scene to create the duplicated item in



> **Type**: ```[String]```

> **Required**: false

> **Position**: 3

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
Copy-OBSSceneItem [-sceneName] <String> [-sceneItemId] <Double> [[-destinationSceneName] <String>] [-PassThru] [<CommonParameters>]
```
---
