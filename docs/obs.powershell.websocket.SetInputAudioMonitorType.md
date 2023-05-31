Set-OBSInputAudioMonitorType
----------------------------




### Synopsis
Set-OBSInputAudioMonitorType : SetInputAudioMonitorType



---


### Description

Sets the audio monitor type of an input.


Set-OBSInputAudioMonitorType calls the OBS WebSocket with a request of type SetInputAudioMonitorType.



---


### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputaudiomonitortype](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputaudiomonitortype)





---


### Parameters
#### **InputName**

Name of the input to set the audio monitor type of






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|



#### **MonitorType**

Audio monitor type






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |2       |true (ByPropertyName)|



#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |Aliases                      |
|----------|--------|--------|---------------------|-----------------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|OutputRequest<br/>OutputInput|





---


### Syntax
```PowerShell
Set-OBSInputAudioMonitorType [-InputName] <String> [-MonitorType] <String> [-PassThru] [<CommonParameters>]
```
