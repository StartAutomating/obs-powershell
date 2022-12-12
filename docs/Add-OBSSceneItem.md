Add-OBSSceneItem
----------------
### Synopsis
Add-OBSSceneItem : CreateSceneItem

---
### Description

Creates a new scene item using a source.

Scenes only


Add-OBSSceneItem calls the OBS WebSocket with a request of type CreateSceneItem.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createsceneitem](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createsceneitem)



---
### Parameters
#### **sceneName**

Name of the scene to create the new item in



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **sourceName**

Name of the source to add to the scene



> **Type**: ```[String]```

> **Required**: true

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **sceneItemEnabled**

Enable state to apply to the scene item on creation



> **Type**: ```[Switch]```

> **Required**: false

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
Add-OBSSceneItem [-sceneName] <String> [-sourceName] <String> [-sceneItemEnabled] [-PassThru] [<CommonParameters>]
```
---
