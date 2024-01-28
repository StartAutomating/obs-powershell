Get-OBSVersion
--------------

### Synopsis
Get-OBSVersion : GetVersion

---

### Description

Gets data about the current plugin and RPC version.

Get-OBSVersion calls the OBS WebSocket with a request of type GetVersion.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getversion](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getversion)

---

### Examples
> EXAMPLE 1

```PowerShell
Get-OBSVersion
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
Get-OBSVersion [-PassThru] [-NoResponse] [<CommonParameters>]
```
