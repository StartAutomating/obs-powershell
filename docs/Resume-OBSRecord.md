Resume-OBSRecord
----------------
### Synopsis
Resume-OBSRecord : ResumeRecord

---
### Description

Resumes the record output.


Resume-OBSRecord calls the OBS WebSocket with a request of type ResumeRecord.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#resumerecord](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#resumerecord)



---
### Examples
#### EXAMPLE 1
```PowerShell
Resume-OBSRecord
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
Resume-OBSRecord [-PassThru] [<CommonParameters>]
```
---
