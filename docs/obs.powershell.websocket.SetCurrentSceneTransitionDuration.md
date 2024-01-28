Set-OBSCurrentSceneTransitionDuration
-------------------------------------

### Synopsis
Set-OBSCurrentSceneTransitionDuration : SetCurrentSceneTransitionDuration

---

### Description

Sets the duration of the current scene transition, if it is not fixed.

Set-OBSCurrentSceneTransitionDuration calls the OBS WebSocket with a request of type SetCurrentSceneTransitionDuration.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentscenetransitionduration](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentscenetransitionduration)

---

### Parameters
#### **TransitionDuration**
Duration in milliseconds

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|true    |1       |true (ByPropertyName)|

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
Set-OBSCurrentSceneTransitionDuration [-TransitionDuration] <Double> [-PassThru] [-NoResponse] [<CommonParameters>]
```
