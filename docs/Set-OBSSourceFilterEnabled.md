Set-OBSSourceFilterEnabled
--------------------------
### Synopsis
Set-OBSSourceFilterEnabled : SetSourceFilterEnabled

---
### Description

Sets the enable state of a source filter.


Set-OBSSourceFilterEnabled calls the OBS WebSocket with a request of type SetSourceFilterEnabled.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsourcefilterenabled](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsourcefilterenabled)



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

Name of the filter



> **Type**: ```[String]```

> **Required**: true

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **filterEnabled**

New enable state of the filter



> **Type**: ```[Switch]```

> **Required**: true

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Set-OBSSourceFilterEnabled [-sourceName] <String> [-filterName] <String> -filterEnabled [<CommonParameters>]
```
---
