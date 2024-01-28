Add-OBSScene
------------

### Synopsis
Add-OBSScene : CreateScene

---

### Description

Creates a new scene in OBS.

Add-OBSScene calls the OBS WebSocket with a request of type CreateScene.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createscene](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createscene)

---

### Parameters
#### **SceneName**
Name for the new scene

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
Add-OBSScene [-SceneName] <String> [-PassThru] [-NoResponse] [<CommonParameters>]
```
