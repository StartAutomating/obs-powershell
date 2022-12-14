Set-OBSStreamServiceSettings
----------------------------
### Synopsis
Set-OBSStreamServiceSettings : SetStreamServiceSettings

---
### Description

Sets the current stream service settings (stream destination).

Note: Simple RTMP settings can be set with type `rtmp_custom` and the settings fields `server` and `key`.


Set-OBSStreamServiceSettings calls the OBS WebSocket with a request of type SetStreamServiceSettings.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setstreamservicesettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setstreamservicesettings)



---
### Parameters
#### **StreamServiceType**

Type of stream service to apply. Example: `rtmp_common` or `rtmp_custom`



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **StreamServiceSettings**

Settings to apply to the service



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
Set-OBSStreamServiceSettings [-StreamServiceType] <String> [-StreamServiceSettings] <PSObject> [-PassThru] [<CommonParameters>]
```
---
