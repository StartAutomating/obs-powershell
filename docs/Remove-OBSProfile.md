Remove-OBSProfile
-----------------
### Synopsis
Remove-OBSProfile : RemoveProfile

---
### Description

Removes a profile. If the current profile is chosen, it will change to a different profile first.


Remove-OBSProfile calls the OBS WebSocket with a request of type RemoveProfile.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#removeprofile](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#removeprofile)



---
### Parameters
#### **profileName**

Name of the profile to remove



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **PassThru**

> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Remove-OBSProfile [-profileName] <String> [-PassThru] [<CommonParameters>]
```
---
