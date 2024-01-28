Get-OBSCurrentSceneTransition
-----------------------------

### Synopsis
Get-OBSCurrentSceneTransition : GetCurrentSceneTransition

---

### Description

Gets information about the current scene transition.

Get-OBSCurrentSceneTransition calls the OBS WebSocket with a request of type GetCurrentSceneTransition.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getcurrentscenetransition](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getcurrentscenetransition)

---

### Examples
> EXAMPLE 1

```PowerShell
Get-OBSCurrentSceneTransition
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
Get-OBSCurrentSceneTransition [-PassThru] [-NoResponse] [<CommonParameters>]
```
