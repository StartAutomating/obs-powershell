Set-OBSSceneItemLocked
----------------------




### Synopsis
Set-OBSSceneItemLocked : SetSceneItemLocked



---


### Description

Sets the lock state of a scene item.

Scenes and Group


Set-OBSSceneItemLocked calls the OBS WebSocket with a request of type SetSceneItemLocked.



---


### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsceneitemlocked](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsceneitemlocked)





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



#### **SceneItemLocked**

New lock state of the scene item






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|true    |named   |true (ByPropertyName)|



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
Set-OBSSceneItemLocked [-SceneName] <String> [-SceneItemId] <Double> -SceneItemLocked [-PassThru] [-NoResponse] [<CommonParameters>]
```
