Get-OBSSceneItemId
------------------
### Synopsis
Get-OBSSceneItemId : GetSceneItemId

---
### Description

Searches a scene for a source, and returns its id.

Scenes and Groups


Get-OBSSceneItemId calls the OBS WebSocket with a request of type GetSceneItemId.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemid](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemid)



---
### Parameters
#### **SceneName**

Name of the scene or group to search in



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **SourceName**

Name of the source to find



> **Type**: ```[String]```

> **Required**: true

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **SearchOffset**

Number of matches to skip during search. >= 0 means first forward. -1 means last (top) item



> **Type**: ```[Double]```

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
Get-OBSSceneItemId [-SceneName] <String> [-SourceName] <String> [[-SearchOffset] <Double>] [-PassThru] [<CommonParameters>]
```
---
