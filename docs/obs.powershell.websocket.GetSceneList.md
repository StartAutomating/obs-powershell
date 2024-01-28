Get-OBSScene
------------

### Synopsis
Get-OBSScene : GetSceneList

---

### Description

Gets an array of all scenes in OBS.

Get-OBSScene calls the OBS WebSocket with a request of type GetSceneList.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getscenelist](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getscenelist)

---

### Examples
> EXAMPLE 1

```PowerShell
Get-OBSScene
```

---

### Parameters
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
Get-OBSScene [-PassThru] [-NoResponse] [<CommonParameters>]
```
