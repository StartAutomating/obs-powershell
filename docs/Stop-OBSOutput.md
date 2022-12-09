Stop-OBSOutput
--------------
### Synopsis
Stop-OBSOutput : StopOutput

---
### Description

Stops an output.


Stop-OBSOutput calls the OBS WebSocket with a request of type StopOutput.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#stopoutput](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#stopoutput)



---
### Parameters
#### **outputName**

Output name



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Stop-OBSOutput [-outputName] <String> [<CommonParameters>]
```
---
