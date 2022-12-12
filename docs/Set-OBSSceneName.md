Set-OBSSceneName
----------------
### Synopsis
Set-OBSSceneName : SetSceneName

---
### Description

Sets the name of a scene (rename).


Set-OBSSceneName calls the OBS WebSocket with a request of type SetSceneName.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setscenename](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setscenename)



---
### Parameters
#### **sceneName**

Name of the scene to be renamed



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **newSceneName**

New name for the scene



> **Type**: ```[String]```

> **Required**: true

> **Position**: 2

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
Set-OBSSceneName [-sceneName] <String> [-newSceneName] <String> [-PassThru] [<CommonParameters>]
```
---
