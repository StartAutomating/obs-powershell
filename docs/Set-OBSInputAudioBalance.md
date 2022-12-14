Set-OBSInputAudioBalance
------------------------
### Synopsis
Set-OBSInputAudioBalance : SetInputAudioBalance

---
### Description

Sets the audio balance of an input.


Set-OBSInputAudioBalance calls the OBS WebSocket with a request of type SetInputAudioBalance.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputaudiobalance](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputaudiobalance)



---
### Parameters
#### **InputName**

Name of the input to set the audio balance of



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **InputAudioBalance**

New audio balance value



> **Type**: ```[Double]```

> **Required**: true

> **Position**: 2

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
Set-OBSInputAudioBalance [-InputName] <String> [-InputAudioBalance] <Double> [-PassThru] [<CommonParameters>]
```
---
