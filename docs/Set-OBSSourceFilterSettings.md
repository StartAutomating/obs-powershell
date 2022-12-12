Set-OBSSourceFilterSettings
---------------------------
### Synopsis
Set-OBSSourceFilterSettings : SetSourceFilterSettings

---
### Description

Sets the settings of a source filter.


Set-OBSSourceFilterSettings calls the OBS WebSocket with a request of type SetSourceFilterSettings.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsourcefiltersettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsourcefiltersettings)



---
### Parameters
#### **sourceName**

Name of the source the filter is on



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **filterName**

Name of the filter to set the settings of



> **Type**: ```[String]```

> **Required**: true

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **filterSettings**

Object of settings to apply



> **Type**: ```[PSObject]```

> **Required**: true

> **Position**: 3

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
Set-OBSSourceFilterSettings [-sourceName] <String> [-filterName] <String> [-filterSettings] <PSObject> [-overlay] [-PassThru] [<CommonParameters>]
```
---
