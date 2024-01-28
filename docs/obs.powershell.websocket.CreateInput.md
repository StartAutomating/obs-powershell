Add-OBSInput
------------

### Synopsis
Add-OBSInput : CreateInput

---

### Description

Creates a new input, adding it as a scene item to the specified scene.

Add-OBSInput calls the OBS WebSocket with a request of type CreateInput.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createinput](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createinput)

---

### Parameters
#### **SceneName**
Name of the scene to add the input to as a scene item

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |1       |true (ByPropertyName)|

#### **SceneUuid**
UUID of the scene to add the input to as a scene item

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |2       |true (ByPropertyName)|

#### **InputName**
Name of the new input to created

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |3       |true (ByPropertyName)|

#### **InputKind**
The kind of input to be created

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |4       |true (ByPropertyName)|

#### **InputSettings**
Settings object to initialize the input with

|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[PSObject]`|false   |5       |true (ByPropertyName)|

#### **SceneItemEnabled**
Whether to set the created scene item to enabled or disabled

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
Add-OBSInput [[-SceneName] <String>] [[-SceneUuid] <String>] [-InputName] <String> [-InputKind] <String> [[-InputSettings] <PSObject>] [-SceneItemEnabled] [-PassThru] [-NoResponse] [<CommonParameters>]
```
