Switch-OBSRecord
----------------

### Synopsis
Switch-OBSRecord : ToggleRecord

---

### Description

Toggles the status of the record output.

Switch-OBSRecord calls the OBS WebSocket with a request of type ToggleRecord.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#togglerecord](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#togglerecord)

---

### Examples
> EXAMPLE 1

```PowerShell
Switch-OBSRecord
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
Switch-OBSRecord [-PassThru] [-NoResponse] [<CommonParameters>]
```
