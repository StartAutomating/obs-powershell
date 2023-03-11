Save-OBSReplayBuffer
--------------------




### Synopsis
Save-OBSReplayBuffer : SaveReplayBuffer



---


### Description

Saves the contents of the replay buffer output.


Save-OBSReplayBuffer calls the OBS WebSocket with a request of type SaveReplayBuffer.



---


### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#savereplaybuffer](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#savereplaybuffer)





---


### Examples
#### EXAMPLE 1
```PowerShell
Save-OBSReplayBuffer
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
Save-OBSReplayBuffer [-PassThru] [<CommonParameters>]
```
