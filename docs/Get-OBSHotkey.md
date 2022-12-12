Get-OBSHotkey
-------------
### Synopsis
Get-OBSHotkey : GetHotkeyList

---
### Description

Gets an array of all hotkey names in OBS


Get-OBSHotkey calls the OBS WebSocket with a request of type GetHotkeyList.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#gethotkeylist](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#gethotkeylist)



---
### Examples
#### EXAMPLE 1
```PowerShell
Get-OBSHotkey
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
Get-OBSHotkey [-PassThru] [<CommonParameters>]
```
---
