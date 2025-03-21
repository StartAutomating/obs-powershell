Stop-OBSStream
--------------

### Synopsis
Stop-OBSStream : StopStream

---

### Description

Stops the stream output.

Stop-OBSStream calls the OBS WebSocket with a request of type StopStream.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#stopstream](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#stopstream)

---

### Examples
> EXAMPLE 1

```PowerShell
Stop-OBSStream
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
Stop-OBSStream [-PassThru] [-NoResponse] [<CommonParameters>]
```
