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






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|



---
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
### Syntax
```PowerShell
Send-OBSTriggerHotkeyByName [-HotkeyName] <String> [-PassThru] [<CommonParameters>]
```
---
