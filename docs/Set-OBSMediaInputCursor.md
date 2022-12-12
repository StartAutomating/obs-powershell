Set-OBSMediaInputCursor
-----------------------
### Synopsis
Set-OBSMediaInputCursor : SetMediaInputCursor

---
### Description

Sets the cursor position of a media input.

This request does not perform bounds checking of the cursor position.


Set-OBSMediaInputCursor calls the OBS WebSocket with a request of type SetMediaInputCursor.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setmediainputcursor](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setmediainputcursor)



---
### Parameters
#### **inputName**

Name of the media input



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **mediaCursor**

New cursor position to set



> **Type**: ```[Double]```

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
Set-OBSMediaInputCursor [-inputName] <String> [-mediaCursor] <Double> [-PassThru] [<CommonParameters>]
```
---
