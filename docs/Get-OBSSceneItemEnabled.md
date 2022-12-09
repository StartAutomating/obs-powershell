Get-OBSSceneItemEnabled
-----------------------
### Synopsis
Get-OBSSceneItemEnabled : GetSceneItemEnabled

---
### Description

Gets the enable state of a scene item.

Scenes and Groups


Get-OBSSceneItemEnabled calls the OBS WebSocket with a request of type GetSceneItemEnabled.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemenabled](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemenabled)



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
### Syntax
```PowerShell
Get-OBSSceneItemEnabled [-sceneName] <String> [-sceneItemId] <Double> [<CommonParameters>]
```
---
