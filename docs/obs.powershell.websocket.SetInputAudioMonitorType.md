Set-OBSInputAudioMonitorType
----------------------------

### Synopsis
Set-OBSInputAudioMonitorType : SetInputAudioMonitorType

---

### Description

Sets the audio monitor type of an input.

Set-OBSInputAudioMonitorType calls the OBS WebSocket with a request of type SetInputAudioMonitorType.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputaudiomonitortype](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputaudiomonitortype)

---

### Parameters
#### **InputName**
Name of the input to set the audio monitor type of

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |1       |true (ByPropertyName)|

#### **InputUuid**
UUID of the input to set the audio monitor type of

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |2       |true (ByPropertyName)|

#### **MonitorType**
Audio monitor type

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |3       |true (ByPropertyName)|

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
Set-OBSInputAudioMonitorType [[-InputName] <String>] [[-InputUuid] <String>] [-MonitorType] <String> [-PassThru] [-NoResponse] [<CommonParameters>]
```
