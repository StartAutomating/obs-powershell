Set-OBSProfileParameter
-----------------------
### Synopsis
Set-OBSProfileParameter : SetProfileParameter

---
### Description

Sets the value of a parameter in the current profile's configuration.


Set-OBSProfileParameter calls the OBS WebSocket with a request of type SetProfileParameter.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setprofileparameter](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setprofileparameter)



---
### Parameters
#### **ParameterCategory**

Category of the parameter to set



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **ParameterName**

Name of the parameter to set



> **Type**: ```[String]```

> **Required**: true

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **ParameterValue**

Value of the parameter to set. Use `null` to delete



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
Set-OBSProfileParameter [-ParameterCategory] <String> [-ParameterName] <String> [-ParameterValue] <String> [-PassThru] [<CommonParameters>]
```
---
