Send-OBSOffsetMediaInputCursor
------------------------------
### Synopsis
Send-OBSOffsetMediaInputCursor : OffsetMediaInputCursor

---
### Description

Offsets the current cursor position of a media input by the specified value.

This request does not perform bounds checking of the cursor position.


Send-OBSOffsetMediaInputCursor calls the OBS WebSocket with a request of type OffsetMediaInputCursor.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#offsetmediainputcursor](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#offsetmediainputcursor)



---
### Parameters
#### **inputName**

Name of the media input



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **mediaCursorOffset**

Value to offset the current cursor position by



> **Type**: ```[Double]```

> **Required**: true

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Send-OBSOffsetMediaInputCursor [-inputName] <String> [-mediaCursorOffset] <Double> [<CommonParameters>]
```
---
