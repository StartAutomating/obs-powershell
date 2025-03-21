Start-OBSVirtualCam
-------------------

### Synopsis
Start-OBSVirtualCam : StartVirtualCam

---

### Description

Starts the virtualcam output.

Start-OBSVirtualCam calls the OBS WebSocket with a request of type StartVirtualCam.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#startvirtualcam](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#startvirtualcam)

---

### Examples
> EXAMPLE 1

```PowerShell
Start-OBSVirtualCam
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
Start-OBSVirtualCam [-PassThru] [-NoResponse] [<CommonParameters>]
```
