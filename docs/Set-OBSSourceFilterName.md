Set-OBSSourceFilterName
-----------------------
### Synopsis
Set-OBSSourceFilterName : SetSourceFilterName

---
### Description

Sets the name of a source filter (rename).


Set-OBSSourceFilterName calls the OBS WebSocket with a request of type SetSourceFilterName.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsourcefiltername](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsourcefiltername)



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

Current name of the filter



> **Type**: ```[String]```

> **Required**: true

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **NewFilterName**

New name for the filter



> **Type**: ```[String]```

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
Set-OBSSourceFilterName [-SourceName] <String> [-FilterName] <String> [-NewFilterName] <String> [-PassThru] [<CommonParameters>]
```
---
