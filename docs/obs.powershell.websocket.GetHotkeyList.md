Get-OBSHotkey
-------------

### Synopsis
Get-OBSHotkey : GetHotkeyList

---

### Description

Gets an array of all hotkey names in OBS.

Note: Hotkey functionality in obs-websocket comes as-is, and we do not guarantee support if things are broken. In 9/10 usages of hotkey requests, there exists a better, more reliable method via other requests.

Get-OBSHotkey calls the OBS WebSocket with a request of type GetHotkeyList.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#gethotkeylist](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#gethotkeylist)

---

### Examples
> EXAMPLE 1

```PowerShell
Get-OBSHotkey
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
Get-OBSHotkey [-PassThru] [-NoResponse] [<CommonParameters>]
```
