Get-OBSSourceFilterList
-----------------------
### Synopsis
Get-OBSSourceFilterList : GetSourceFilterList

---
### Description

Gets an array of all of a source's filters.


Get-OBSSourceFilterList calls the OBS WebSocket with a request of type GetSourceFilterList.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsourcefilterlist](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsourcefilterlist)



---
### Parameters
#### **sourceName**

Name of the source



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **PassThru**

> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Get-OBSSourceFilterList [-sourceName] <String> [-PassThru] [<CommonParameters>]
```
---
