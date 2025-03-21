Set-OBSStudioModeEnabled
------------------------

### Synopsis
Set-OBSStudioModeEnabled : SetStudioModeEnabled

---

### Description

Enables or disables studio mode

Set-OBSStudioModeEnabled calls the OBS WebSocket with a request of type SetStudioModeEnabled.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setstudiomodeenabled](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setstudiomodeenabled)

---

### Parameters
#### **StudioModeEnabled**
True == Enabled, False == Disabled

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|true    |named   |true (ByPropertyName)|

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
Set-OBSStudioModeEnabled -StudioModeEnabled [-PassThru] [-NoResponse] [<CommonParameters>]
```
