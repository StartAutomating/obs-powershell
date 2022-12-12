Set-OBSCurrentSceneTransitionSettings
-------------------------------------
### Synopsis
Set-OBSCurrentSceneTransitionSettings : SetCurrentSceneTransitionSettings

---
### Description

Sets the settings of the current scene transition.


Set-OBSCurrentSceneTransitionSettings calls the OBS WebSocket with a request of type SetCurrentSceneTransitionSettings.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentscenetransitionsettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentscenetransitionsettings)



---
### Parameters
#### **transitionSettings**

Settings object to apply to the transition. Can be `{}`



> **Type**: ```[PSObject]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **overlay**

Whether to overlay over the current settings or replace them



> **Type**: ```[Switch]```

> **Required**: false

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
Set-OBSCurrentSceneTransitionSettings [-transitionSettings] <PSObject> [-overlay] [-PassThru] [<CommonParameters>]
```
---
