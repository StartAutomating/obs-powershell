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
#### **sceneName**

Name of the scene



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **transitionName**

Name of the scene transition to use as override. Specify `null` to remove



> **Type**: ```[String]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **transitionDuration**

Duration to use for any overridden transition. Specify `null` to remove



> **Type**: ```[Double]```

> **Required**: false

> **Position**: 3

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Set-OBSSceneSceneTransitionOverride [-sceneName] <String> [[-transitionName] <String>] [[-transitionDuration] <Double>] [<CommonParameters>]
```
---
