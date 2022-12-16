Send-OBSTriggerHotkeyByName
---------------------------
### Synopsis
Send-OBSTriggerHotkeyByName : TriggerHotkeyByName

---
### Description

Triggers a hotkey using its name. See `GetHotkeyList`


Send-OBSTriggerHotkeyByName calls the OBS WebSocket with a request of type TriggerHotkeyByName.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#triggerhotkeybyname](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#triggerhotkeybyname)



---
### Parameters
#### **HotkeyName**

Name of the hotkey to trigger



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
Send-OBSTriggerHotkeyByName [-HotkeyName] <String> [-PassThru] [<CommonParameters>]
```
---
