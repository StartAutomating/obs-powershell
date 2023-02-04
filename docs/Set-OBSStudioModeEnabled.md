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
#### **StudioModeEnabled**

True == Enabled, False == Disabled






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|true    |named   |true (ByPropertyName)|



---
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
### Syntax
```PowerShell
Set-OBSStudioModeEnabled -StudioModeEnabled [-PassThru] [<CommonParameters>]
```
---
