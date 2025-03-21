Set-OBSSceneName
----------------

### Synopsis
Set-OBSSceneName : SetSceneName

---

### Description

Sets the name of a scene (rename).

Set-OBSSceneName calls the OBS WebSocket with a request of type SetSceneName.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setscenename](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setscenename)

---

### Parameters
#### **SceneName**
Name of the scene to be renamed

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |1       |true (ByPropertyName)|

#### **SceneUuid**
UUID of the scene to be renamed

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |2       |true (ByPropertyName)|

#### **NewSceneName**
New name for the scene

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
Set-OBSSceneName [[-SceneName] <String>] [[-SceneUuid] <String>] [-NewSceneName] <String> [-PassThru] [-NoResponse] [<CommonParameters>]
```
