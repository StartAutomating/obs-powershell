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



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **TransitionName**

Name of the scene transition to use as override. Specify `null` to remove



> **Type**: ```[String]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **TransitionDuration**

Duration to use for any overridden transition. Specify `null` to remove



> **Type**: ```[Double]```

> **Required**: false

> **Position**: 3

> **PipelineInput**:true (ByPropertyName)



---
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Set-OBSSceneSceneTransitionOverride [-SceneName] <String> [[-TransitionName] <String>] [[-TransitionDuration] <Double>] [-PassThru] [<CommonParameters>]
```
---
