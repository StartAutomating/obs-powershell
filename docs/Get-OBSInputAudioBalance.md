Get-OBSInputAudioBalance
------------------------
### Synopsis
Get-OBSInputAudioBalance : GetInputAudioBalance

---
### Description

Gets the audio balance of an input.


Get-OBSInputAudioBalance calls the OBS WebSocket with a request of type GetInputAudioBalance.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputaudiobalance](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputaudiobalance)



---
### Parameters
#### **InputName**

Name of the input to get the audio balance of



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
Get-OBSInputAudioBalance [-InputName] <String> [-PassThru] [<CommonParameters>]
```
---
