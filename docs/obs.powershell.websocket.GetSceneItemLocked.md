Get-OBSSceneItemLocked
----------------------




### Synopsis
Get-OBSSceneItemLocked : GetSceneItemLocked



---


### Description

Gets the lock state of a scene item.

Scenes and Groups


Get-OBSSceneItemLocked calls the OBS WebSocket with a request of type GetSceneItemLocked.



---


### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemlocked](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemlocked)





---


### Parameters
#### **SceneName**

Name of the scene the item is in






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|



#### **SceneItemId**

Numeric ID of the scene item






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|true    |2       |true (ByPropertyName)|



#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |Aliases                      |
|----------|--------|--------|---------------------|-----------------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|OutputRequest<br/>OutputInput|





---


### Syntax
```PowerShell
Get-OBSSceneItemLocked [-SceneName] <String> [-SceneItemId] <Double> [-PassThru] [<CommonParameters>]
```
