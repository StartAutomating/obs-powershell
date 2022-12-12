Get-OBSRecordStatus
-------------------
### Synopsis
Get-OBSRecordStatus : GetRecordStatus

---
### Description

Gets the status of the record output.


Get-OBSRecordStatus calls the OBS WebSocket with a request of type GetRecordStatus.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getrecordstatus](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getrecordstatus)



---
### Examples
#### EXAMPLE 1
```PowerShell
Get-OBSRecordStatus
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
Get-OBSRecordStatus [-PassThru] [<CommonParameters>]
```
---
