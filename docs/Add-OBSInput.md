Add-OBSInput
------------
### Synopsis
Add-OBSInput : CreateInput

---
### Description

Creates a new input, adding it as a scene item to the specified scene.


Add-OBSInput calls the OBS WebSocket with a request of type CreateInput.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createinput](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createinput)



---
### Parameters
#### **SceneName**

Name of the scene to add the input to as a scene item



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **InputName**

Name of the new input to created



> **Type**: ```[String]```

> **Required**: true

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **InputKind**

The kind of input to be created



> **Type**: ```[String]```

> **Required**: true

> **Position**: 3

> **PipelineInput**:true (ByPropertyName)



---
#### **InputSettings**

Settings object to initialize the input with



> **Type**: ```[PSObject]```

> **Required**: false

> **Position**: 4

> **PipelineInput**:true (ByPropertyName)



---
#### **SceneItemEnabled**

Whether to set the created scene item to enabled or disabled



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

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
Add-OBSInput [-SceneName] <String> [-InputName] <String> [-InputKind] <String> [[-InputSettings] <PSObject>] [-SceneItemEnabled] [-PassThru] [<CommonParameters>]
```
---
