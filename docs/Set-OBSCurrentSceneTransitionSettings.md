Set-OBSCurrentSceneTransitionSettings
-------------------------------------

### Synopsis
Set-OBSCurrentSceneTransitionSettings : SetCurrentSceneTransitionSettings

---

### Description

Sets the settings of the current scene transition.

Set-OBSCurrentSceneTransitionSettings calls the OBS WebSocket with a request of type SetCurrentSceneTransitionSettings.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentscenetransitionsettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentscenetransitionsettings)

---

### Parameters
#### **TransitionSettings**
Settings object to apply to the transition. Can be `{}`

|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[PSObject]`|true    |1       |true (ByPropertyName)|

#### **Overlay**
Whether to overlay over the current settings or replace them

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

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
Set-OBSCurrentSceneTransitionSettings [-TransitionSettings] <PSObject> [-Overlay] [-PassThru] [-NoResponse] [<CommonParameters>]
```
