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
#### **FilterEnabled**

New enable state of the filter



> **Type**: ```[Switch]```

> **Required**: true

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
Set-OBSSourceFilterEnabled [-SourceName] <String> [-FilterName] <String> -FilterEnabled [-PassThru] [<CommonParameters>]
```
---
