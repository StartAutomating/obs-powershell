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

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |1       |true (ByPropertyName)|

#### **SceneUuid**
UUID of the scene or group to search in

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |2       |true (ByPropertyName)|

#### **SourceName**
Name of the source to find

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |3       |true (ByPropertyName)|

#### **SearchOffset**
Number of matches to skip during search. >= 0 means first forward. -1 means last (top) item

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |4       |true (ByPropertyName)|

#### **PassThru**
If set, will return the information that would otherwise be sent to OBS.

|Type      |Required|Position|PipelineInput        |Aliases                      |
|----------|--------|--------|---------------------|-----------------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|OutputRequest<br/>OutputInput|

#### **NoResponse**
If set, will not attempt to receive a response from OBS.
This can increase performance, and also silently ignore critical errors

|Type      |Required|Position|PipelineInput        |Aliases                                                                |
|----------|--------|--------|---------------------|-----------------------------------------------------------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|NoReceive<br/>IgnoreResponse<br/>IgnoreReceive<br/>DoNotReceiveResponse|

---

### Syntax
```PowerShell
Get-OBSSceneItemId [[-SceneName] <String>] [[-SceneUuid] <String>] [-SourceName] <String> [[-SearchOffset] <Double>] [-PassThru] [-NoResponse] [<CommonParameters>]
```
