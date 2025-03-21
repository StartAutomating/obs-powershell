Get-OBSSceneSceneTransitionOverride
-----------------------------------

### Synopsis
Get-OBSSceneSceneTransitionOverride : GetSceneSceneTransitionOverride

---

### Description

Gets the scene transition overridden for a scene.

Note: A transition UUID response field is not currently able to be implemented as of 2024-1-18.

Get-OBSSceneSceneTransitionOverride calls the OBS WebSocket with a request of type GetSceneSceneTransitionOverride.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getscenescenetransitionoverride](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getscenescenetransitionoverride)

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
Get-OBSSceneSceneTransitionOverride [[-SceneName] <String>] [[-SceneUuid] <String>] [-PassThru] [-NoResponse] [<CommonParameters>]
```
