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
#### **SceneName**

Name of the scene the item is in



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **SceneItemId**

Numeric ID of the scene item



> **Type**: ```[Double]```

> **Required**: true

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **SceneItemBlendMode**

New blend mode



> **Type**: ```[String]```

> **Required**: true

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
Set-OBSSceneItemBlendMode [-SceneName] <String> [-SceneItemId] <Double> [-SceneItemBlendMode] <String> [-PassThru] [<CommonParameters>]
```
---
