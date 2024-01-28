Get-OBSMonitor
--------------

### Synopsis
Get-OBSMonitor : GetMonitorList

---

### Description

Gets a list of connected monitors and information about them.

Get-OBSMonitor calls the OBS WebSocket with a request of type GetMonitorList.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getmonitorlist](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getmonitorlist)

---

### Examples
> EXAMPLE 1

```PowerShell
Get-OBSMonitor
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
Get-OBSMonitor [-PassThru] [-NoResponse] [<CommonParameters>]
```
