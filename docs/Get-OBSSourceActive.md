Get-OBSSourceActive
-------------------
### Synopsis
Get-OBSSourceActive : GetSourceActive

---
### Description

Gets the active and show state of a source.

**Compatible with inputs and scenes.**


Get-OBSSourceActive calls the OBS WebSocket with a request of type GetSourceActive.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsourceactive](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsourceactive)



---
### Parameters
#### **SourceName**

Name of the source to get the active state of



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
Get-OBSSourceActive [-SourceName] <String> [-PassThru] [<CommonParameters>]
```
---
