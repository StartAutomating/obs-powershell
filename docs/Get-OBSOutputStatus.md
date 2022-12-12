Get-OBSOutputStatus
-------------------
### Synopsis
Get-OBSOutputStatus : GetOutputStatus

---
### Description

Gets the status of an output.


Get-OBSOutputStatus calls the OBS WebSocket with a request of type GetOutputStatus.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getoutputstatus](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getoutputstatus)



---
### Parameters
#### **outputName**

Output name



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Get-OBSOutputStatus [-outputName] <String> [-PassThru] [<CommonParameters>]
```
---
