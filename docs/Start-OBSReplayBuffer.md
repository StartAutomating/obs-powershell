Start-OBSReplayBuffer
---------------------

### Synopsis
Start-OBSReplayBuffer : StartReplayBuffer

---

### Description

Starts the replay buffer output.

Start-OBSReplayBuffer calls the OBS WebSocket with a request of type StartReplayBuffer.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#startreplaybuffer](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#startreplaybuffer)

---

### Examples
> EXAMPLE 1

```PowerShell
Start-OBSReplayBuffer
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
Start-OBSReplayBuffer [-PassThru] [-NoResponse] [<CommonParameters>]
```
