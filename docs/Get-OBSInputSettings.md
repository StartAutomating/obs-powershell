Get-OBSInputSettings
--------------------
### Synopsis
Get-OBSInputSettings : GetInputSettings

---
### Description

Gets the settings of an input.

Note: Does not include defaults. To create the entire settings object, overlay `inputSettings` over the `defaultInputSettings` provided by `GetInputDefaultSettings`.


Get-OBSInputSettings calls the OBS WebSocket with a request of type GetInputSettings.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputsettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputsettings)



---
### Parameters
#### **InputName**

Name of the input to get the settings of



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
Get-OBSInputSettings [-InputName] <String> [-PassThru] [<CommonParameters>]
```
---
