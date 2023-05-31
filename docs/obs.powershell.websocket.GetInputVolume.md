Get-OBSInputVolume
------------------




### Synopsis
Get-OBSInputVolume : GetInputVolume



---


### Description

Gets the current volume setting of an input.


Get-OBSInputVolume calls the OBS WebSocket with a request of type GetInputVolume.



---


### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputvolume](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputvolume)





---


### Parameters
#### **InputName**

Name of the input to get the volume of






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
Get-OBSInputVolume [-InputName] <String> [-PassThru] [<CommonParameters>]
```
