Set-OBSSceneItemBlendMode
-------------------------
### Synopsis
Set-OBSSceneItemBlendMode : SetSceneItemBlendMode

---
### Description

Sets the blend mode of a scene item.

Scenes and Groups


Set-OBSSceneItemBlendMode calls the OBS WebSocket with a request of type SetSceneItemBlendMode.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsceneitemblendmode](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsceneitemblendmode)



---
### Parameters
#### **sceneName**

Name of the scene the item is in



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **sceneItemId**

Numeric ID of the scene item



> **Type**: ```[Double]```

> **Required**: true

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **sceneItemBlendMode**

New blend mode



> **Type**: ```[String]```

> **Required**: true

> **Position**: 3

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Set-OBSSceneItemBlendMode [-sceneName] <String> [-sceneItemId] <Double> [-sceneItemBlendMode] <String> [<CommonParameters>]
```
---
