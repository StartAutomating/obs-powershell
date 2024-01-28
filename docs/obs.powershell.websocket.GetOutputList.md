Get-OBSOutput
-------------

### Synopsis
Get-OBSOutput : GetOutputList

---

### Description

Gets the list of available outputs.

Get-OBSOutput calls the OBS WebSocket with a request of type GetOutputList.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getoutputlist](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getoutputlist)

---

### Examples
> EXAMPLE 1

```PowerShell
Get-OBSOutput
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
Get-OBSOutput [-PassThru] [-NoResponse] [<CommonParameters>]
```
