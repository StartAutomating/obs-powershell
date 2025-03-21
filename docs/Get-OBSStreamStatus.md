Get-OBSStreamStatus
-------------------

### Synopsis
Get-OBSStreamStatus : GetStreamStatus

---

### Description

Gets the status of the stream output.

Get-OBSStreamStatus calls the OBS WebSocket with a request of type GetStreamStatus.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getstreamstatus](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getstreamstatus)

---

### Examples
> EXAMPLE 1

```PowerShell
Get-OBSStreamStatus
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
Get-OBSStreamStatus [-PassThru] [-NoResponse] [<CommonParameters>]
```
