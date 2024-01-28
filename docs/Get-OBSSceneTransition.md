Get-OBSSceneTransition
----------------------

### Synopsis
Get-OBSSceneTransition : GetSceneTransitionList

---

### Description

Gets an array of all scene transitions in OBS.

Get-OBSSceneTransition calls the OBS WebSocket with a request of type GetSceneTransitionList.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getscenetransitionlist](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getscenetransitionlist)

---

### Examples
> EXAMPLE 1

```PowerShell
Get-OBSSceneTransition
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
Get-OBSSceneTransition [-PassThru] [-NoResponse] [<CommonParameters>]
```
