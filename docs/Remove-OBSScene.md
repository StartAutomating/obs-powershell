Remove-OBSScene
---------------

### Synopsis
Remove-OBSScene : RemoveScene

---

### Description

Removes a scene from OBS.

Remove-OBSScene calls the OBS WebSocket with a request of type RemoveScene.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#removescene](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#removescene)

---

### Parameters
#### **SceneName**
Name of the scene to remove

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |1       |true (ByPropertyName)|

#### **SceneUuid**
UUID of the scene to remove

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |2       |true (ByPropertyName)|

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
Remove-OBSScene [[-SceneName] <String>] [[-SceneUuid] <String>] [-PassThru] [-NoResponse] [<CommonParameters>]
```
