Set-OBSInputAudioTracks
-----------------------
### Synopsis
Set-OBSInputAudioTracks : SetInputAudioTracks

---
### Description

Sets the enable state of audio tracks of an input.


Set-OBSInputAudioTracks calls the OBS WebSocket with a request of type SetInputAudioTracks.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputaudiotracks](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputaudiotracks)



---
### Parameters
#### **InputName**

Name of the input






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|



---
#### **InputAudioTracks**

Track settings to apply






|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[PSObject]`|true    |2       |true (ByPropertyName)|



---
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
### Syntax
```PowerShell
Set-OBSInputAudioTracks [-InputName] <String> [-InputAudioTracks] <PSObject> [-PassThru] [<CommonParameters>]
```
---
