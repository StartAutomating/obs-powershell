Get-OBSTransitionKind
---------------------

### Synopsis
Get-OBSTransitionKind : GetTransitionKindList

---

### Description

Gets an array of all available transition kinds.

Similar to `GetInputKindList`

Get-OBSTransitionKind calls the OBS WebSocket with a request of type GetTransitionKindList.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#gettransitionkindlist](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#gettransitionkindlist)

---

### Examples
> EXAMPLE 1

```PowerShell
Get-OBSTransitionKind
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
Get-OBSTransitionKind [-PassThru] [-NoResponse] [<CommonParameters>]
```
