Switch-OBSOutput
----------------

### Synopsis
Switch-OBSOutput : ToggleOutput

---

### Description

Toggles the status of an output.

Switch-OBSOutput calls the OBS WebSocket with a request of type ToggleOutput.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#toggleoutput](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#toggleoutput)

---

### Parameters
#### **OutputName**
Output name

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|

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
Switch-OBSOutput [-OutputName] <String> [-PassThru] [-NoResponse] [<CommonParameters>]
```
