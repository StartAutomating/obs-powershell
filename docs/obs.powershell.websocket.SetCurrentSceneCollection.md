Set-OBSCurrentSceneCollection
-----------------------------

### Synopsis
Set-OBSCurrentSceneCollection : SetCurrentSceneCollection

---

### Description

Switches to a scene collection.

Note: This will block until the collection has finished changing.

Set-OBSCurrentSceneCollection calls the OBS WebSocket with a request of type SetCurrentSceneCollection.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentscenecollection](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentscenecollection)

---

### Parameters
#### **SceneCollectionName**
Name of the scene collection to switch to

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|

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
Set-OBSCurrentSceneCollection [-SceneCollectionName] <String> [-PassThru] [-NoResponse] [<CommonParameters>]
```
