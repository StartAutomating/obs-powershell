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
#### EXAMPLE 1
```PowerShell
Start-OBSReplayBuffer
```

---
### Parameters
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Start-OBSReplayBuffer [-PassThru] [<CommonParameters>]
```
---
