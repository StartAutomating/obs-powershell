Set-OBSOutputSettings
---------------------

### Synopsis
Set-OBSOutputSettings : SetOutputSettings

---

### Description

Sets the settings of an output.

Set-OBSOutputSettings calls the OBS WebSocket with a request of type SetOutputSettings.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setoutputsettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setoutputsettings)

---

### Parameters
#### **OutputName**
Output name

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|

#### **OutputSettings**
Output settings

|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[PSObject]`|true    |2       |true (ByPropertyName)|

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
Set-OBSOutputSettings [-OutputName] <String> [-OutputSettings] <PSObject> [-PassThru] [-NoResponse] [<CommonParameters>]
```
