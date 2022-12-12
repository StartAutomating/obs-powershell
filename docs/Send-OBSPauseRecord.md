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
#### EXAMPLE 1
```PowerShell
Send-OBSPauseRecord
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
Send-OBSPauseRecord [-PassThru] [<CommonParameters>]
```
---
