Get-OBSReplayBufferStatus
-------------------------




### Synopsis
Get-OBSReplayBufferStatus : GetReplayBufferStatus



---


### Description

Gets the status of the replay buffer output.


Get-OBSReplayBufferStatus calls the OBS WebSocket with a request of type GetReplayBufferStatus.



---


### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getreplaybufferstatus](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getreplaybufferstatus)





---


### Examples
#### EXAMPLE 1
```PowerShell
Get-OBSReplayBufferStatus
```



---


### Parameters
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |Aliases                      |
|----------|--------|--------|---------------------|-----------------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|OutputRequest<br/>OutputInput|





---


### Syntax
```PowerShell
Get-OBSReplayBufferStatus [-PassThru] [<CommonParameters>]
```
