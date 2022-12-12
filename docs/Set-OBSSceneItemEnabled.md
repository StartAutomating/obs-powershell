Set-OBSSceneItemEnabled
-----------------------
### Synopsis
Set-OBSSceneItemEnabled : SetSceneItemEnabled

---
### Description

Sets the enable state of a scene item.

Scenes and Groups


Set-OBSSceneItemEnabled calls the OBS WebSocket with a request of type SetSceneItemEnabled.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsceneitemenabled](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsceneitemenabled)



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
#### **sceneItemEnabled**

New enable state of the scene item



> **Type**: ```[Switch]```

> **Required**: true

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **PassThru**

> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Set-OBSSceneItemEnabled [-sceneName] <String> [-sceneItemId] <Double> -sceneItemEnabled [-PassThru] [<CommonParameters>]
```
---
