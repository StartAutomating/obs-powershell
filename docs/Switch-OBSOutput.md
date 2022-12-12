Switch-OBSOutput
----------------
### Synopsis
Switch-OBSOutput : ToggleOutput

---
### Description

Toggles the status of an output.


Switch-OBSOutput calls the OBS WebSocket with a request of type ToggleOutput.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#toggleoutput](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#toggleoutput)



---
### Parameters
#### **outputName**

Output name



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
Switch-OBSOutput [-outputName] <String> [-PassThru] [<CommonParameters>]
```
---
