Add-OBSScene
------------




### Synopsis
Add-OBSScene : CreateScene



---


### Description

Creates a new scene in OBS.


Add-OBSScene calls the OBS WebSocket with a request of type CreateScene.



---


### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createscene](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createscene)





---


### Parameters
#### **SceneName**

Name for the new scene






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
Add-OBSScene [-SceneName] <String> [-PassThru] [<CommonParameters>]
```
