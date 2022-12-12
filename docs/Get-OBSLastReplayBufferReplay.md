Get-OBSLastReplayBufferReplay
-----------------------------
### Synopsis
Get-OBSLastReplayBufferReplay : GetLastReplayBufferReplay

---
### Description

Gets the filename of the last replay buffer save file.


Get-OBSLastReplayBufferReplay calls the OBS WebSocket with a request of type GetLastReplayBufferReplay.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getlastreplaybufferreplay](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getlastreplaybufferreplay)



---
### Examples
#### EXAMPLE 1
```PowerShell
Get-OBSLastReplayBufferReplay
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
Get-OBSLastReplayBufferReplay [-PassThru] [<CommonParameters>]
```
---
