Get-OBSCurrentPreviewScene
--------------------------

### Synopsis
Get-OBSCurrentPreviewScene : GetCurrentPreviewScene

---

### Description

Gets the current preview scene.

Only available when studio mode is enabled.

Note: This request is slated to have the `currentPreview`-prefixed fields removed from in an upcoming RPC version.

Get-OBSCurrentPreviewScene calls the OBS WebSocket with a request of type GetCurrentPreviewScene.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getcurrentpreviewscene](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getcurrentpreviewscene)

---

### Examples
> EXAMPLE 1

```PowerShell
Get-OBSCurrentPreviewScene
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
Get-OBSCurrentPreviewScene [-PassThru] [-NoResponse] [<CommonParameters>]
```
