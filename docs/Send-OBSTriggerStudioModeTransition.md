Send-OBSTriggerStudioModeTransition
-----------------------------------

### Synopsis
Send-OBSTriggerStudioModeTransition : TriggerStudioModeTransition

---

### Description

Triggers the current scene transition. Same functionality as the `Transition` button in studio mode.

Send-OBSTriggerStudioModeTransition calls the OBS WebSocket with a request of type TriggerStudioModeTransition.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#triggerstudiomodetransition](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#triggerstudiomodetransition)

---

### Examples
> EXAMPLE 1

```PowerShell
Send-OBSTriggerStudioModeTransition
```

---

### Parameters
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
Send-OBSTriggerStudioModeTransition [-PassThru] [-NoResponse] [<CommonParameters>]
```
