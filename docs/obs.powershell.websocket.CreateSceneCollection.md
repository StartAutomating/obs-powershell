Add-OBSSceneCollection
----------------------

### Synopsis
Add-OBSSceneCollection : CreateSceneCollection

---

### Description

Creates a new scene collection, switching to it in the process.

Note: This will block until the collection has finished changing.

Add-OBSSceneCollection calls the OBS WebSocket with a request of type CreateSceneCollection.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createscenecollection](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createscenecollection)

---

### Parameters
#### **SceneCollectionName**
Name for the new scene collection

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
Add-OBSSceneCollection [-SceneCollectionName] <String> [-PassThru] [-NoResponse] [<CommonParameters>]
```
