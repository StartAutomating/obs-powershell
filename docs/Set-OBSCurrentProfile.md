Set-OBSCurrentProfile
---------------------
### Synopsis
Set-OBSCurrentProfile : SetCurrentProfile

---
### Description

Switches to a profile.


Set-OBSCurrentProfile calls the OBS WebSocket with a request of type SetCurrentProfile.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentprofile](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentprofile)



---
### Parameters
#### **ProfileName**

Name of the profile to switch to






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|



---
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
### Syntax
```PowerShell
Set-OBSCurrentProfile [-ProfileName] <String> [-PassThru] [<CommonParameters>]
```
---
