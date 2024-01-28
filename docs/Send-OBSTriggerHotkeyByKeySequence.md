Send-OBSTriggerHotkeyByKeySequence
----------------------------------

### Synopsis
Send-OBSTriggerHotkeyByKeySequence : TriggerHotkeyByKeySequence

---

### Description

Triggers a hotkey using a sequence of keys.

Note: Hotkey functionality in obs-websocket comes as-is, and we do not guarantee support if things are broken. In 9/10 usages of hotkey requests, there exists a better, more reliable method via other requests.

Send-OBSTriggerHotkeyByKeySequence calls the OBS WebSocket with a request of type TriggerHotkeyByKeySequence.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#triggerhotkeybykeysequence](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#triggerhotkeybykeysequence)

---

### Parameters
#### **KeyId**
The OBS key ID to use. See https://github.com/obsproject/obs-studio/blob/master/libobs/obs-hotkeys.h

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |1       |true (ByPropertyName)|

#### **KeyModifiers**
Object containing key modifiers to apply

|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[PSObject]`|false   |2       |true (ByPropertyName)|

#### **KeyModifiersshift**
Press Shift

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **KeyModifierscontrol**
Press CTRL

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **KeyModifiersalt**
Press ALT

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **KeyModifierscommand**
Press CMD (Mac)

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **PassThru**
If set, will return the information that would otherwise be sent to OBS.

|Type      |Required|Position|PipelineInput        |Aliases                      |
|----------|--------|--------|---------------------|-----------------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|OutputRequest<br/>OutputInput|

#### **NoResponse**
If set, will not attempt to receive a response from OBS.
This can increase performance, and also silently ignore critical errors

|Type      |Required|Position|PipelineInput        |Aliases                                                                |
|----------|--------|--------|---------------------|-----------------------------------------------------------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|NoReceive<br/>IgnoreResponse<br/>IgnoreReceive<br/>DoNotReceiveResponse|

---

### Syntax
```PowerShell
Send-OBSTriggerHotkeyByKeySequence [[-KeyId] <String>] [[-KeyModifiers] <PSObject>] [-KeyModifiersshift] [-KeyModifierscontrol] [-KeyModifiersalt] [-KeyModifierscommand] [-PassThru] [-NoResponse] [<CommonParameters>]
```
