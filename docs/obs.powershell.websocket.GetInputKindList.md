Get-OBSInputKind
----------------

### Synopsis
Get-OBSInputKind : GetInputKindList

---

### Description

Gets an array of all available input kinds in OBS.

Get-OBSInputKind calls the OBS WebSocket with a request of type GetInputKindList.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputkindlist](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputkindlist)

---

### Parameters
#### **Unversioned**
True == Return all kinds as unversioned, False == Return with version suffixes (if available)

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

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
Get-OBSInputKind [-Unversioned] [-PassThru] [-NoResponse] [<CommonParameters>]
```
