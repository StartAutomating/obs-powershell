Open-OBSInputInteractDialog
---------------------------
### Synopsis
Open-OBSInputInteractDialog : OpenInputInteractDialog

---
### Description

Opens the interact dialog of an input.


Open-OBSInputInteractDialog calls the OBS WebSocket with a request of type OpenInputInteractDialog.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#openinputinteractdialog](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#openinputinteractdialog)



---
### Parameters
#### **inputName**

Name of the input to open the dialog of



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

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
Open-OBSInputInteractDialog [-inputName] <String> [-PassThru] [<CommonParameters>]
```
---
