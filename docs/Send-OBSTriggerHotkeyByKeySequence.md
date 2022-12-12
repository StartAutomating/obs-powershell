Send-OBSTriggerHotkeyByKeySequence
----------------------------------
### Synopsis
Send-OBSTriggerHotkeyByKeySequence : TriggerHotkeyByKeySequence

---
### Description

Triggers a hotkey using a sequence of keys.


Send-OBSTriggerHotkeyByKeySequence calls the OBS WebSocket with a request of type TriggerHotkeyByKeySequence.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#triggerhotkeybykeysequence](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#triggerhotkeybykeysequence)



---
### Parameters
#### **keyId**

The OBS key ID to use. See https://github.com/obsproject/obs-studio/blob/master/libobs/obs-hotkeys.h



> **Type**: ```[String]```

> **Required**: false

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **keyModifiers**

Object containing key modifiers to apply



> **Type**: ```[PSObject]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **keyModifiersshift**

Press Shift



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **keyModifierscontrol**

Press CTRL



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **keyModifiersalt**

Press ALT



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **keyModifierscommand**

Press CMD (Mac)



> **Type**: ```[Switch]```

> **Required**: false

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
Send-OBSTriggerHotkeyByKeySequence [[-keyId] <String>] [[-keyModifiers] <PSObject>] [-keyModifiersshift] [-keyModifierscontrol] [-keyModifiersalt] [-keyModifierscommand] [-PassThru] [<CommonParameters>]
```
---
