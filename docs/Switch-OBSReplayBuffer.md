Switch-OBSReplayBuffer
----------------------

### Synopsis
Switch-OBSReplayBuffer : ToggleReplayBuffer

---

### Description

Toggles the state of the replay buffer output.

Switch-OBSReplayBuffer calls the OBS WebSocket with a request of type ToggleReplayBuffer.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#togglereplaybuffer](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#togglereplaybuffer)

---

### Examples
> EXAMPLE 1

```PowerShell
Switch-OBSReplayBuffer
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
Switch-OBSReplayBuffer [-PassThru] [-NoResponse] [<CommonParameters>]
```
