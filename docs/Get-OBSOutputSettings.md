Get-OBSOutputSettings
---------------------
### Synopsis
Get-OBSOutputSettings : GetOutputSettings

---
### Description

Gets the settings of an output.


Get-OBSOutputSettings calls the OBS WebSocket with a request of type GetOutputSettings.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getoutputsettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getoutputsettings)



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
Get-OBSOutputSettings [-outputName] <String> [-PassThru] [<CommonParameters>]
```
---
