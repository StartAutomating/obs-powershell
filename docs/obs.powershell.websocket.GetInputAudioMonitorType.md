Get-OBSInputAudioMonitorType
----------------------------




### Synopsis
Get-OBSInputAudioMonitorType : GetInputAudioMonitorType



---


### Description

Gets the audio monitor type of an input.

The available audio monitor types are:

- `OBS_MONITORING_TYPE_NONE`
- `OBS_MONITORING_TYPE_MONITOR_ONLY`
- `OBS_MONITORING_TYPE_MONITOR_AND_OUTPUT`


Get-OBSInputAudioMonitorType calls the OBS WebSocket with a request of type GetInputAudioMonitorType.



---


### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputaudiomonitortype](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputaudiomonitortype)





---


### Parameters
#### **InputName**

Name of the input to get the audio monitor type of






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|



#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |Aliases                      |
|----------|--------|--------|---------------------|-----------------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|OutputRequest<br/>OutputInput|





---


### Syntax
```PowerShell
Get-OBSInputAudioMonitorType [-InputName] <String> [-PassThru] [<CommonParameters>]
```
