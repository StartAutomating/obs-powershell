Get-OBSInputAudioMonitorType
----------------------------

### Synopsis
Get-OBSInputAudioMonitorType : GetInputAudioMonitorType

---

### Description

Gets the audio monitor type of an input.

The available audio monitor types are:

- `OBS_MONITORING_TYPE_NONE`
- `OBS_MONITORING_TYPE_MONITOR_ONLY`
- `OBS_MONITORING_TYPE_MONITOR_AND_OUTPUT`

Get-OBSInputAudioMonitorType calls the OBS WebSocket with a request of type GetInputAudioMonitorType.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputaudiomonitortype](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputaudiomonitortype)

---

### Parameters
#### **InputName**
Name of the input to get the audio monitor type of

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |1       |true (ByPropertyName)|

#### **InputUuid**
UUID of the input to get the audio monitor type of

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
Get-OBSInputAudioMonitorType [[-InputName] <String>] [[-InputUuid] <String>] [-PassThru] [-NoResponse] [<CommonParameters>]
```
