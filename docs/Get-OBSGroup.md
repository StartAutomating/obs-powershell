Get-OBSGroup
------------

### Synopsis
Get-OBSGroup : GetGroupList

---

### Description

Gets an array of all groups in OBS.

Groups in OBS are actually scenes, but renamed and modified. In obs-websocket, we treat them as scenes where we can.

Get-OBSGroup calls the OBS WebSocket with a request of type GetGroupList.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getgrouplist](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getgrouplist)

---

### Examples
> EXAMPLE 1

```PowerShell
Get-OBSGroup
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
Get-OBSGroup [-PassThru] [-NoResponse] [<CommonParameters>]
```
