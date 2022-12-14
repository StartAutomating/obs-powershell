Remove-OBSSourceFilter
----------------------
### Synopsis
Remove-OBSSourceFilter : RemoveSourceFilter

---
### Description

Removes a filter from a source.


Remove-OBSSourceFilter calls the OBS WebSocket with a request of type RemoveSourceFilter.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#removesourcefilter](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#removesourcefilter)



---
### Parameters
#### **SourceName**

Name of the source the filter is on



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **FilterName**

Name of the filter to remove



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
Remove-OBSSourceFilter [-SourceName] <String> [-FilterName] <String> [-PassThru] [<CommonParameters>]
```
---
