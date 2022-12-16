Get-OBSInputVolume
------------------
### Synopsis
Get-OBSInputVolume : GetInputVolume

---
### Description

Gets the current volume setting of an input.


Get-OBSInputVolume calls the OBS WebSocket with a request of type GetInputVolume.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputvolume](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputvolume)



---
### Parameters
#### **InputName**

Name of the input to get the volume of



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
Get-OBSInputVolume [-InputName] <String> [-PassThru] [<CommonParameters>]
```
---
