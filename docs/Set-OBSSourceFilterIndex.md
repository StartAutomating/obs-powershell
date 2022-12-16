Set-OBSSourceFilterIndex
------------------------
### Synopsis
Set-OBSSourceFilterIndex : SetSourceFilterIndex

---
### Description

Sets the index position of a filter on a source.


Set-OBSSourceFilterIndex calls the OBS WebSocket with a request of type SetSourceFilterIndex.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsourcefilterindex](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsourcefilterindex)



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

Name of the filter



> **Type**: ```[String]```

> **Required**: true

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **FilterIndex**

New index position of the filter



> **Type**: ```[Double]```

> **Required**: true

> **Position**: 3

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
Set-OBSSourceFilterIndex [-SourceName] <String> [-FilterName] <String> [-FilterIndex] <Double> [-PassThru] [<CommonParameters>]
```
---
