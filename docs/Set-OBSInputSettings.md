Set-OBSInputSettings
--------------------
### Synopsis
Set-OBSInputSettings : SetInputSettings

---
### Description

Sets the settings of an input.


Set-OBSInputSettings calls the OBS WebSocket with a request of type SetInputSettings.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputsettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputsettings)



---
### Parameters
#### **inputName**

Name of the input to set the settings of



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **inputSettings**

Object of settings to apply



> **Type**: ```[PSObject]```

> **Required**: true

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **overlay**

True == apply the settings on top of existing ones, False == reset the input to its defaults, then apply settings.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

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
Set-OBSInputSettings [-inputName] <String> [-inputSettings] <PSObject> [-overlay] [-PassThru] [<CommonParameters>]
```
---
