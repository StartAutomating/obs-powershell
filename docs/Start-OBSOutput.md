Start-OBSOutput
---------------
### Synopsis
Start-OBSOutput : StartOutput

---
### Description

Starts an output.


Start-OBSOutput calls the OBS WebSocket with a request of type StartOutput.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#startoutput](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#startoutput)



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

> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Start-OBSOutput [-outputName] <String> [-PassThru] [<CommonParameters>]
```
---
