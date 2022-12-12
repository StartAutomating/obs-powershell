Get-OBSSourceFilter
-------------------
### Synopsis
Get-OBSSourceFilter : GetSourceFilter

---
### Description

Gets the info for a specific source filter.


Get-OBSSourceFilter calls the OBS WebSocket with a request of type GetSourceFilter.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsourcefilter](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsourcefilter)



---
### Parameters
#### **sourceName**

Name of the source



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **filterName**

Name of the filter



> **Type**: ```[String]```

> **Required**: true

> **Position**: 2

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
Get-OBSSourceFilter [-sourceName] <String> [-filterName] <String> [-PassThru] [<CommonParameters>]
```
---
