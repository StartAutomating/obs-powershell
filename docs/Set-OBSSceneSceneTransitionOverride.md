Set-OBSSceneSceneTransitionOverride
-----------------------------------

### Synopsis
Set-OBSSceneSceneTransitionOverride : SetSceneSceneTransitionOverride

---

### Description

Sets the scene transition overridden for a scene.

Set-OBSSceneSceneTransitionOverride calls the OBS WebSocket with a request of type SetSceneSceneTransitionOverride.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setscenescenetransitionoverride](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setscenescenetransitionoverride)

---

### Parameters
#### **SceneName**
Name of the scene

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |1       |true (ByPropertyName)|

#### **SceneUuid**
UUID of the scene

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |2       |true (ByPropertyName)|

#### **TransitionName**
Name of the scene transition to use as override. Specify `null` to remove

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |3       |true (ByPropertyName)|

#### **TransitionDuration**
Duration to use for any overridden transition. Specify `null` to remove

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
Set-OBSSceneSceneTransitionOverride [[-SceneName] <String>] [[-SceneUuid] <String>] [[-TransitionName] <String>] [[-TransitionDuration] <Double>] [-PassThru] [-NoResponse] [<CommonParameters>]
```
