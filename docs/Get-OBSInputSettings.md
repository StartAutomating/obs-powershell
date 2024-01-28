Get-OBSInputSettings
--------------------

### Synopsis
Get-OBSInputSettings : GetInputSettings

---

### Description

Gets the settings of an input.

Note: Does not include defaults. To create the entire settings object, overlay `inputSettings` over the `defaultInputSettings` provided by `GetInputDefaultSettings`.

Get-OBSInputSettings calls the OBS WebSocket with a request of type GetInputSettings.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputsettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputsettings)

---

### Parameters
#### **InputName**
Name of the input to get the settings of

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |1       |true (ByPropertyName)|

#### **InputUuid**
UUID of the input to get the settings of

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
Get-OBSInputSettings [[-InputName] <String>] [[-InputUuid] <String>] [-PassThru] [-NoResponse] [<CommonParameters>]
```
