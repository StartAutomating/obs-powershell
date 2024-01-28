Get-OBSGroupSceneItem
---------------------

### Synopsis
Get-OBSGroupSceneItem : GetGroupSceneItemList

---

### Description

Basically GetSceneItemList, but for groups.

Using groups at all in OBS is discouraged, as they are very broken under the hood. Please use nested scenes instead.

Groups only

Get-OBSGroupSceneItem calls the OBS WebSocket with a request of type GetGroupSceneItemList.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getgroupsceneitemlist](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getgroupsceneitemlist)

---

### Parameters
#### **SceneName**
Name of the group to get the items of

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |1       |true (ByPropertyName)|

#### **SceneUuid**
UUID of the group to get the items of

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
Get-OBSGroupSceneItem [[-SceneName] <String>] [[-SceneUuid] <String>] [-PassThru] [-NoResponse] [<CommonParameters>]
```
