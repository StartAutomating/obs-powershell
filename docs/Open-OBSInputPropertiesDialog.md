Open-OBSInputPropertiesDialog
-----------------------------
### Synopsis
Open-OBSInputPropertiesDialog : OpenInputPropertiesDialog

---
### Description

Opens the properties dialog of an input.


Open-OBSInputPropertiesDialog calls the OBS WebSocket with a request of type OpenInputPropertiesDialog.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#openinputpropertiesdialog](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#openinputpropertiesdialog)



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
Open-OBSInputPropertiesDialog [-inputName] <String> [-PassThru] [<CommonParameters>]
```
---
