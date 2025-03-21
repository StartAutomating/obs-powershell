Set-OBSTBarPosition
-------------------

### Synopsis
Set-OBSTBarPosition : SetTBarPosition

---

### Description

Sets the position of the TBar.

**Very important note**: This will be deprecated and replaced in a future version of obs-websocket.

Set-OBSTBarPosition calls the OBS WebSocket with a request of type SetTBarPosition.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#settbarposition](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#settbarposition)

---

### Parameters
#### **Position**
New position

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|true    |1       |true (ByPropertyName)|

#### **Release**
Whether to release the TBar. Only set `false` if you know that you will be sending another position update

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
Set-OBSTBarPosition [-Position] <Double> [-Release] [-PassThru] [-NoResponse] [<CommonParameters>]
```
