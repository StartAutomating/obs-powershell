Set-OBSInputVolume
------------------
### Synopsis
Set-OBSInputVolume : SetInputVolume

---
### Description

Sets the volume setting of an input.


Set-OBSInputVolume calls the OBS WebSocket with a request of type SetInputVolume.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputvolume](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputvolume)



---
### Parameters
#### **inputName**

Name of the input to set the volume of



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **inputVolumeMul**

Volume setting in mul



> **Type**: ```[Double]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **inputVolumeDb**

Volume setting in dB



> **Type**: ```[Double]```

> **Required**: false

> **Position**: 3

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
Set-OBSInputVolume [-inputName] <String> [[-inputVolumeMul] <Double>] [[-inputVolumeDb] <Double>] [-PassThru] [<CommonParameters>]
```
---
