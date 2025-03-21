Send-OBSPauseRecord
-------------------

### Synopsis
Send-OBSPauseRecord : PauseRecord

---

### Description

Pauses the record output.

Send-OBSPauseRecord calls the OBS WebSocket with a request of type PauseRecord.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#pauserecord](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#pauserecord)

---

### Examples
> EXAMPLE 1

```PowerShell
Send-OBSPauseRecord
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
Send-OBSPauseRecord [-PassThru] [-NoResponse] [<CommonParameters>]
```
