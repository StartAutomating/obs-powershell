Stop-OBSReplayBuffer
--------------------
### Synopsis
Stop-OBSReplayBuffer : StopReplayBuffer

---
### Description

Stops the replay buffer output.


Stop-OBSReplayBuffer calls the OBS WebSocket with a request of type StopReplayBuffer.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#stopreplaybuffer](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#stopreplaybuffer)



---
### Examples
#### EXAMPLE 1
```PowerShell
Stop-OBSReplayBuffer
```

---
### Parameters
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
### Syntax
```PowerShell
Stop-OBSReplayBuffer [-PassThru] [<CommonParameters>]
```
---
