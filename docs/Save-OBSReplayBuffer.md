Save-OBSReplayBuffer
--------------------

### Synopsis
Save-OBSReplayBuffer : SaveReplayBuffer

---

### Description

Saves the contents of the replay buffer output.

Save-OBSReplayBuffer calls the OBS WebSocket with a request of type SaveReplayBuffer.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#savereplaybuffer](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#savereplaybuffer)

---

### Examples
> EXAMPLE 1

```PowerShell
Save-OBSReplayBuffer
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
Save-OBSReplayBuffer [-PassThru] [-NoResponse] [<CommonParameters>]
```
