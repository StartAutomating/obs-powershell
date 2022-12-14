Get-OBSSourceFilterDefaultSettings
----------------------------------
### Synopsis
Get-OBSSourceFilterDefaultSettings : GetSourceFilterDefaultSettings

---
### Description

Gets the default settings for a filter kind.


Get-OBSSourceFilterDefaultSettings calls the OBS WebSocket with a request of type GetSourceFilterDefaultSettings.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsourcefilterdefaultsettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsourcefilterdefaultsettings)



---
### Parameters
#### **FilterKind**

Filter kind to get the default settings for



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
Get-OBSSourceFilterDefaultSettings [-FilterKind] <String> [-PassThru] [<CommonParameters>]
```
---
