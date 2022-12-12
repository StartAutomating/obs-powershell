Get-OBSInputKind
----------------
### Synopsis
Get-OBSInputKind : GetInputKindList

---
### Description

Gets an array of all available input kinds in OBS.


Get-OBSInputKind calls the OBS WebSocket with a request of type GetInputKindList.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputkindlist](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputkindlist)



---
### Parameters
#### **unversioned**

True == Return all kinds as unversioned, False == Return with version suffixes (if available)



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

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
Get-OBSInputKind [-unversioned] [-PassThru] [<CommonParameters>]
```
---
