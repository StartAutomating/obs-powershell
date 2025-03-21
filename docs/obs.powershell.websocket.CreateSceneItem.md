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
#### **SceneName**
Name of the scene to create the new item in

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |1       |true (ByPropertyName)|

#### **SceneUuid**
UUID of the scene to create the new item in

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |2       |true (ByPropertyName)|

#### **SourceName**
Name of the source to add to the scene

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |3       |true (ByPropertyName)|

#### **SourceUuid**
UUID of the source to add to the scene

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |4       |true (ByPropertyName)|

#### **SceneItemEnabled**
Enable state to apply to the scene item on creation

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

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
Add-OBSSceneItem [[-SceneName] <String>] [[-SceneUuid] <String>] [[-SourceName] <String>] [[-SourceUuid] <String>] [-SceneItemEnabled] [-PassThru] [-NoResponse] [<CommonParameters>]
```
