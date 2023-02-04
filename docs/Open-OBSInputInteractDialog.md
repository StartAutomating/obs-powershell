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
#### **InputName**

Name of the input to open the dialog of






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|



---
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
### Syntax
```PowerShell
Open-OBSInputInteractDialog [-InputName] <String> [-PassThru] [<CommonParameters>]
```
---
