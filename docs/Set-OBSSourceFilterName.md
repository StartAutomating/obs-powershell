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
#### **sourceName**

Name of the source the filter is on



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **filterName**

Current name of the filter



> **Type**: ```[String]```

> **Required**: true

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **newFilterName**

New name for the filter



> **Type**: ```[String]```

> **Required**: true

> **Position**: 3

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Set-OBSSourceFilterName [-sourceName] <String> [-filterName] <String> [-newFilterName] <String> [<CommonParameters>]
```
---
