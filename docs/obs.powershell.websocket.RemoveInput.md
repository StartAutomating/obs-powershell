Remove-OBSInput
---------------

### Synopsis
Remove-OBSInput : RemoveInput

---

### Description

Removes an existing input.

Note: Will immediately remove all associated scene items.

Remove-OBSInput calls the OBS WebSocket with a request of type RemoveInput.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#removeinput](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#removeinput)

---

### Parameters
#### **InputName**
Name of the input to remove

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |1       |true (ByPropertyName)|

#### **InputUuid**
UUID of the input to remove

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |2       |true (ByPropertyName)|

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
Remove-OBSInput [[-InputName] <String>] [[-InputUuid] <String>] [-PassThru] [-NoResponse] [<CommonParameters>]
```
