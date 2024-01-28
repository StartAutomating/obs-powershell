Get-OBSCurrentProgramScene
--------------------------

### Synopsis
Get-OBSCurrentProgramScene : GetCurrentProgramScene

---

### Description

Gets the current program scene.

Note: This request is slated to have the `currentProgram`-prefixed fields removed from in an upcoming RPC version.

Get-OBSCurrentProgramScene calls the OBS WebSocket with a request of type GetCurrentProgramScene.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getcurrentprogramscene](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getcurrentprogramscene)

---

### Examples
> EXAMPLE 1

```PowerShell
Get-OBSCurrentProgramScene
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
Get-OBSCurrentProgramScene [-PassThru] [-NoResponse] [<CommonParameters>]
```
