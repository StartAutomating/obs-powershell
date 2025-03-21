Get-OBSRecordDirectory
----------------------

### Synopsis
Get-OBSRecordDirectory : GetRecordDirectory

---

### Description

Gets the current directory that the record output is set to.

Get-OBSRecordDirectory calls the OBS WebSocket with a request of type GetRecordDirectory.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getrecorddirectory](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getrecorddirectory)

---

### Examples
> EXAMPLE 1

```PowerShell
Get-OBSRecordDirectory
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
Get-OBSRecordDirectory [-PassThru] [-NoResponse] [<CommonParameters>]
```
