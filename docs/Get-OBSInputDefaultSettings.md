Get-OBSInputDefaultSettings
---------------------------

### Synopsis
Get-OBSInputDefaultSettings : GetInputDefaultSettings

---

### Description

Gets the default settings for an input kind.

Get-OBSInputDefaultSettings calls the OBS WebSocket with a request of type GetInputDefaultSettings.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputdefaultsettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputdefaultsettings)

---

### Parameters
#### **InputKind**
Input kind to get the default settings for

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
Get-OBSInputDefaultSettings [-InputKind] <String> [-PassThru] [-NoResponse] [<CommonParameters>]
```
