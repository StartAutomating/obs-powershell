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
#### **InputName**

Name of the media input






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|



---
#### **MediaCursor**

New cursor position to set






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
Set-OBSMediaInputCursor [-InputName] <String> [-MediaCursor] <Double> [-PassThru] [<CommonParameters>]
```
---
