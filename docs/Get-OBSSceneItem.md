Get-OBSSceneItem
----------------
### Synopsis
Get-OBSSceneItem : GetSceneItemList

---
### Description

Gets a list of all scene items in a scene.

Scenes only


Get-OBSSceneItem calls the OBS WebSocket with a request of type GetSceneItemList.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemlist](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemlist)



---
### Parameters
#### **SceneName**

Name of the scene to get the items of



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

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
Get-OBSSceneItem [-SceneName] <String> [-PassThru] [<CommonParameters>]
```
---
