Set-OBSInputAudioBalance
------------------------

### Synopsis
Set-OBSInputAudioBalance : SetInputAudioBalance

---

### Description

Sets the audio balance of an input.

Set-OBSInputAudioBalance calls the OBS WebSocket with a request of type SetInputAudioBalance.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputaudiobalance](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputaudiobalance)

---

### Parameters
#### **InputName**
Name of the input to set the audio balance of

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |1       |true (ByPropertyName)|

#### **InputUuid**
UUID of the input to set the audio balance of

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |2       |true (ByPropertyName)|

#### **InputAudioBalance**
New audio balance value

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|true    |3       |true (ByPropertyName)|

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
Set-OBSInputAudioBalance [[-InputName] <String>] [[-InputUuid] <String>] [-InputAudioBalance] <Double> [-PassThru] [-NoResponse] [<CommonParameters>]
```
