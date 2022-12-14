Send-OBSTriggerMediaInputAction
-------------------------------
### Synopsis
Send-OBSTriggerMediaInputAction : TriggerMediaInputAction

---
### Description

Triggers an action on a media input.


Send-OBSTriggerMediaInputAction calls the OBS WebSocket with a request of type TriggerMediaInputAction.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#triggermediainputaction](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#triggermediainputaction)



---
### Parameters
#### **InputName**

Name of the media input



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **MediaAction**

Identifier of the `ObsMediaInputAction` enum



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
Send-OBSTriggerMediaInputAction [-InputName] <String> [-MediaAction] <String> [-PassThru] [<CommonParameters>]
```
---
