Get-OBSVirtualCamStatus
-----------------------

### Synopsis
Get-OBSVirtualCamStatus : GetVirtualCamStatus

---

### Description

Gets the status of the virtualcam output.

Get-OBSVirtualCamStatus calls the OBS WebSocket with a request of type GetVirtualCamStatus.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getvirtualcamstatus](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getvirtualcamstatus)

---

### Examples
> EXAMPLE 1

```PowerShell
Get-OBSVirtualCamStatus
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
Get-OBSVirtualCamStatus [-PassThru] [-NoResponse] [<CommonParameters>]
```
