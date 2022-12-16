Set-OBSInputName
----------------
### Synopsis
Set-OBSInputName : SetInputName

---
### Description

Sets the name of an input (rename).


Set-OBSInputName calls the OBS WebSocket with a request of type SetInputName.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputname](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputname)



---
### Parameters
#### **InputName**

Current input name



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **NewInputName**

New name for the input



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
Set-OBSInputName [-InputName] <String> [-NewInputName] <String> [-PassThru] [<CommonParameters>]
```
---
