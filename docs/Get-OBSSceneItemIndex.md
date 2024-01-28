Get-OBSSceneItemIndex
---------------------

### Synopsis
Get-OBSSceneItemIndex : GetSceneItemIndex

---

### Description

Gets the index position of a scene item in a scene.

An index of 0 is at the bottom of the source list in the UI.

Scenes and Groups

Get-OBSSceneItemIndex calls the OBS WebSocket with a request of type GetSceneItemIndex.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemindex](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemindex)

---

### Parameters
#### **SceneName**
Name of the scene the item is in

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |1       |true (ByPropertyName)|

#### **SceneUuid**
UUID of the scene the item is in

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |2       |true (ByPropertyName)|

#### **SceneItemId**
Numeric ID of the scene item

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|true    |3       |true (ByPropertyName)|

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
Get-OBSSceneItemIndex [[-SceneName] <String>] [[-SceneUuid] <String>] [-SceneItemId] <Double> [-PassThru] [-NoResponse] [<CommonParameters>]
```
