Set-OBSSceneSceneTransitionOverride
-----------------------------------
### Synopsis
Set-OBSSceneSceneTransitionOverride : SetSceneSceneTransitionOverride

---
### Description

Gets the scene transition overridden for a scene.


Set-OBSSceneSceneTransitionOverride calls the OBS WebSocket with a request of type SetSceneSceneTransitionOverride.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setscenescenetransitionoverride](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setscenescenetransitionoverride)



---
### Parameters
#### **SceneName**

Name of the scene






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|



---
#### **TransitionName**

Name of the scene transition to use as override. Specify `null` to remove






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |2       |true (ByPropertyName)|



---
#### **TransitionDuration**

Duration to use for any overridden transition. Specify `null` to remove






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |3       |true (ByPropertyName)|



---
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
### Syntax
```PowerShell
Set-OBSSceneSceneTransitionOverride [-SceneName] <String> [[-TransitionName] <String>] [[-TransitionDuration] <Double>] [-PassThru] [<CommonParameters>]
```
---
