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
#### **profileName**

Name of the profile to switch to



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
Set-OBSCurrentProfile [-profileName] <String> [-PassThru] [<CommonParameters>]
```
---
