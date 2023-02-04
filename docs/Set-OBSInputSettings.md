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
#### **InputName**

Name of the input to set the settings of






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|



---
#### **InputSettings**

Object of settings to apply






|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[PSObject]`|true    |2       |true (ByPropertyName)|



---
#### **Overlay**

True == apply the settings on top of existing ones, False == reset the input to its defaults, then apply settings.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
### Syntax
```PowerShell
Set-OBSInputSettings [-InputName] <String> [-InputSettings] <PSObject> [-Overlay] [-PassThru] [<CommonParameters>]
```
---
