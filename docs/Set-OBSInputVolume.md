Set-OBSInputVolume
------------------

### Synopsis
Set-OBSInputVolume : SetInputVolume

---

### Description

Sets the volume setting of an input.

Set-OBSInputVolume calls the OBS WebSocket with a request of type SetInputVolume.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputvolume](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputvolume)

---

### Parameters
#### **InputName**
Name of the input to set the volume of

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |1       |true (ByPropertyName)|

#### **InputUuid**
UUID of the input to set the volume of

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |2       |true (ByPropertyName)|

#### **InputVolumeMul**
Volume setting in mul

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |3       |true (ByPropertyName)|

#### **InputVolumeDb**
Volume setting in dB

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |4       |true (ByPropertyName)|

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
Set-OBSInputVolume [[-InputName] <String>] [[-InputUuid] <String>] [[-InputVolumeMul] <Double>] [[-InputVolumeDb] <Double>] [-PassThru] [-NoResponse] [<CommonParameters>]
```
