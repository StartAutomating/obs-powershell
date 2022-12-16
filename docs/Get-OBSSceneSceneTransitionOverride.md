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



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

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
Get-OBSSceneSceneTransitionOverride [-SceneName] <String> [-PassThru] [<CommonParameters>]
```
---
