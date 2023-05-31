Get-OBSSceneSceneTransitionOverride
-----------------------------------




### Synopsis
Get-OBSSceneSceneTransitionOverride : GetSceneSceneTransitionOverride



---


### Description

Gets the scene transition overridden for a scene.


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
|`[String]`|true    |1       |true (ByPropertyName)|



#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |Aliases                      |
|----------|--------|--------|---------------------|-----------------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|OutputRequest<br/>OutputInput|





---


### Syntax
```PowerShell
Get-OBSSceneSceneTransitionOverride [-SceneName] <String> [-PassThru] [<CommonParameters>]
```
