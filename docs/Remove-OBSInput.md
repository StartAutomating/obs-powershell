Remove-OBSInput
---------------
### Synopsis
Remove-OBSInput : RemoveInput

---
### Description

Removes an existing input.

Note: Will immediately remove all associated scene items.


Remove-OBSInput calls the OBS WebSocket with a request of type RemoveInput.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#removeinput](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#removeinput)



---
### Parameters
#### **inputName**

Name of the input to remove



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Remove-OBSInput [-inputName] <String> [<CommonParameters>]
```
---
