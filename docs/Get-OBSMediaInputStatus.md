Get-OBSMediaInputStatus
-----------------------
### Synopsis
Get-OBSMediaInputStatus : GetMediaInputStatus

---
### Description

Gets the status of a media input.

Media States:

- `OBS_MEDIA_STATE_NONE`
- `OBS_MEDIA_STATE_PLAYING`
- `OBS_MEDIA_STATE_OPENING`
- `OBS_MEDIA_STATE_BUFFERING`
- `OBS_MEDIA_STATE_PAUSED`
- `OBS_MEDIA_STATE_STOPPED`
- `OBS_MEDIA_STATE_ENDED`
- `OBS_MEDIA_STATE_ERROR`


Get-OBSMediaInputStatus calls the OBS WebSocket with a request of type GetMediaInputStatus.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getmediainputstatus](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getmediainputstatus)



---
### Parameters
#### **InputName**

Name of the media input






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|



---
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
### Syntax
```PowerShell
Get-OBSMediaInputStatus [-InputName] <String> [-PassThru] [<CommonParameters>]
```
---
