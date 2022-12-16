Set-OBSOutputSettings
---------------------
### Synopsis
Set-OBSOutputSettings : SetOutputSettings

---
### Description

Sets the settings of an output.


Set-OBSOutputSettings calls the OBS WebSocket with a request of type SetOutputSettings.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setoutputsettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setoutputsettings)



---
### Parameters
#### **OutputName**

Output name



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **OutputSettings**

Output settings



> **Type**: ```[PSObject]```

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
Set-OBSOutputSettings [-OutputName] <String> [-OutputSettings] <PSObject> [-PassThru] [<CommonParameters>]
```
---
