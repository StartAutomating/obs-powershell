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
#### **inputName**

Current input name



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **newInputName**

New name for the input



> **Type**: ```[String]```

> **Required**: true

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Set-OBSInputName [-inputName] <String> [-newInputName] <String> [<CommonParameters>]
```
---
