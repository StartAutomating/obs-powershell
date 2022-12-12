Get-OBSRecordDirectory
----------------------
### Synopsis
Get-OBSRecordDirectory : GetRecordDirectory

---
### Description

Gets the current directory that the record output is set to.


Get-OBSRecordDirectory calls the OBS WebSocket with a request of type GetRecordDirectory.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getrecorddirectory](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getrecorddirectory)



---
### Examples
#### EXAMPLE 1
```PowerShell
Get-OBSRecordDirectory
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
Get-OBSRecordDirectory [-PassThru] [<CommonParameters>]
```
---
