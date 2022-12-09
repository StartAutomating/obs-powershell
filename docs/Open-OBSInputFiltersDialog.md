Open-OBSInputFiltersDialog
--------------------------
### Synopsis
Open-OBSInputFiltersDialog : OpenInputFiltersDialog

---
### Description

Opens the filters dialog of an input.


Open-OBSInputFiltersDialog calls the OBS WebSocket with a request of type OpenInputFiltersDialog.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#openinputfiltersdialog](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#openinputfiltersdialog)



---
### Parameters
#### **inputName**

Name of the input to open the dialog of



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Open-OBSInputFiltersDialog [-inputName] <String> [<CommonParameters>]
```
---
