Get-OBSInputAudioMonitorType
----------------------------
### Synopsis
Get-OBSInputAudioMonitorType : GetInputAudioMonitorType

---
### Description

Gets the audio monitor type of an input.

The available audio monitor types are:

- `OBS_MONITORING_TYPE_NONE`
- `OBS_MONITORING_TYPE_MONITOR_ONLY`
- `OBS_MONITORING_TYPE_MONITOR_AND_OUTPUT`


Get-OBSInputAudioMonitorType calls the OBS WebSocket with a request of type GetInputAudioMonitorType.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputaudiomonitortype](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputaudiomonitortype)



---
### Parameters
#### **inputName**

Name of the input to get the audio monitor type of



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
Get-OBSInputAudioMonitorType [-inputName] <String> [-PassThru] [<CommonParameters>]
```
---
