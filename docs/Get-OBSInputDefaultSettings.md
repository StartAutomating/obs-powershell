Get-OBSInputDefaultSettings
---------------------------
### Synopsis
Get-OBSInputDefaultSettings : GetInputDefaultSettings

---
### Description

Gets the default settings for an input kind.


Get-OBSInputDefaultSettings calls the OBS WebSocket with a request of type GetInputDefaultSettings.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputdefaultsettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputdefaultsettings)



---
### Parameters
#### **InputKind**

Input kind to get the default settings for



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
Get-OBSInputDefaultSettings [-InputKind] <String> [-PassThru] [<CommonParameters>]
```
---
