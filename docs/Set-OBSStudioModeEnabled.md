Set-OBSStudioModeEnabled
------------------------
### Synopsis
Set-OBSStudioModeEnabled : SetStudioModeEnabled

---
### Description

Enables or disables studio mode


Set-OBSStudioModeEnabled calls the OBS WebSocket with a request of type SetStudioModeEnabled.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setstudiomodeenabled](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setstudiomodeenabled)



---
### Parameters
#### **studioModeEnabled**

True == Enabled, False == Disabled



> **Type**: ```[Switch]```

> **Required**: true

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
Set-OBSStudioModeEnabled -studioModeEnabled [-PassThru] [<CommonParameters>]
```
---
