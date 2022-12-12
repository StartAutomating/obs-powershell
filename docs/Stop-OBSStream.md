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
#### EXAMPLE 1
```PowerShell
Stop-OBSStream
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
Stop-OBSStream [-PassThru] [<CommonParameters>]
```
---
