Get-OBSCurrentSceneTransitionCursor
-----------------------------------

### Synopsis
Get-OBSCurrentSceneTransitionCursor : GetCurrentSceneTransitionCursor

---

### Description

Gets the cursor position of the current scene transition.

Note: `transitionCursor` will return 1.0 when the transition is inactive.

Get-OBSCurrentSceneTransitionCursor calls the OBS WebSocket with a request of type GetCurrentSceneTransitionCursor.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getcurrentscenetransitioncursor](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getcurrentscenetransitioncursor)

---

### Examples
> EXAMPLE 1

```PowerShell
Get-OBSCurrentSceneTransitionCursor
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
Get-OBSCurrentSceneTransitionCursor [-PassThru] [-NoResponse] [<CommonParameters>]
```
