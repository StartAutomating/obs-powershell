Get-OBSVideoSettings
--------------------
### Synopsis
Get-OBSVideoSettings : GetVideoSettings

---
### Description

Gets the current video settings.

Note: To get the true FPS value, divide the FPS numerator by the FPS denominator. Example: `60000/1001`


Get-OBSVideoSettings calls the OBS WebSocket with a request of type GetVideoSettings.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getvideosettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getvideosettings)



---
### Examples
#### EXAMPLE 1
```PowerShell
Get-OBSVideoSettings
```

---
### Parameters
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Get-OBSVideoSettings [-PassThru] [<CommonParameters>]
```
---
