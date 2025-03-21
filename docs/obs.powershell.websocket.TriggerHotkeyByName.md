Send-OBSTriggerHotkeyByName
---------------------------

### Synopsis
Send-OBSTriggerHotkeyByName : TriggerHotkeyByName

---

### Description

Triggers a hotkey using its name. See `GetHotkeyList`.

Note: Hotkey functionality in obs-websocket comes as-is, and we do not guarantee support if things are broken. In 9/10 usages of hotkey requests, there exists a better, more reliable method via other requests.

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

#### **ContextName**
Name of context of the hotkey to trigger

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |2       |true (ByPropertyName)|

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
Send-OBSTriggerHotkeyByName [-HotkeyName] <String> [[-ContextName] <String>] [-PassThru] [-NoResponse] [<CommonParameters>]
```
