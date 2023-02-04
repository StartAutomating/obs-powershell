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
#### **InputName**

Name of the media input






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|



---
#### **MediaCursorOffset**

Value to offset the current cursor position by






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|true    |2       |true (ByPropertyName)|



---
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
### Syntax
```PowerShell
Send-OBSOffsetMediaInputCursor [-InputName] <String> [-MediaCursorOffset] <Double> [-PassThru] [<CommonParameters>]
```
---
