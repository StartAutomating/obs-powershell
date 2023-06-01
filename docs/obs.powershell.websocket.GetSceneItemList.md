Get-OBSSceneItem
----------------




### Synopsis
Get-OBSSceneItem : GetSceneItemList



---


### Description

Gets a list of all scene items in a scene.

Scenes only


Get-OBSSceneItem calls the OBS WebSocket with a request of type GetSceneItemList.



---


### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemlist](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemlist)





---


### Parameters
#### **SceneName**

Name of the scene to get the items of






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|



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
Get-OBSSceneItem [-SceneName] <String> [-PassThru] [-NoResponse] [<CommonParameters>]
```
