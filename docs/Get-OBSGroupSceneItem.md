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
|`[String]`|true    |1       |true (ByPropertyName)|



#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |Aliases                      |
|----------|--------|--------|---------------------|-----------------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|OutputRequest<br/>OutputInput|





---


### Syntax
```PowerShell
Get-OBSGroupSceneItem [-SceneName] <String> [-PassThru] [<CommonParameters>]
```
