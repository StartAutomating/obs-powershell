Get-OBSStats
------------

### Synopsis
Get-OBSStats : GetStats

---

### Description

Gets statistics about OBS, obs-websocket, and the current session.

Get-OBSStats calls the OBS WebSocket with a request of type GetStats.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getstats](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getstats)

---

### Examples
> EXAMPLE 1

```PowerShell
Get-OBSStats
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
Get-OBSStats [-PassThru] [-NoResponse] [<CommonParameters>]
```
