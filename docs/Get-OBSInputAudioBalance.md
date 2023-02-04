Get-OBSInputAudioBalance
------------------------
### Synopsis
Get-OBSInputAudioBalance : GetInputAudioBalance

---
### Description

Gets the audio balance of an input.


Get-OBSInputAudioBalance calls the OBS WebSocket with a request of type GetInputAudioBalance.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputaudiobalance](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputaudiobalance)



---
### Parameters
#### **InputName**

Name of the input to get the audio balance of






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
Get-OBSInputAudioBalance [-InputName] <String> [-PassThru] [<CommonParameters>]
```
---
