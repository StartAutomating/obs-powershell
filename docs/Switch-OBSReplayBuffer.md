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
#### EXAMPLE 1
```PowerShell
Switch-OBSReplayBuffer
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
Switch-OBSReplayBuffer [-PassThru] [<CommonParameters>]
```
---
