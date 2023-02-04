Get-OBSInputAudioTracks
-----------------------
### Synopsis
Get-OBSInputAudioTracks : GetInputAudioTracks

---
### Description

Gets the enable state of all audio tracks of an input.


Get-OBSInputAudioTracks calls the OBS WebSocket with a request of type GetInputAudioTracks.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputaudiotracks](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputaudiotracks)



---
### Parameters
#### **InputName**

Name of the input






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
Get-OBSInputAudioTracks [-InputName] <String> [-PassThru] [<CommonParameters>]
```
---
