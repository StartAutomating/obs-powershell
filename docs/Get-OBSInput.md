Get-OBSInput
------------
### Synopsis
Get-OBSInput : GetInputList

---
### Description

Gets an array of all inputs in OBS.


Get-OBSInput calls the OBS WebSocket with a request of type GetInputList.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputlist](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputlist)



---
### Parameters
#### **InputKind**

Restrict the array to only inputs of the specified kind



> **Type**: ```[String]```

> **Required**: false

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
Get-OBSInput [[-InputKind] <String>] [-PassThru] [<CommonParameters>]
```
---
