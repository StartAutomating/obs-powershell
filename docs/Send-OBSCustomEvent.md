Send-OBSCustomEvent
-------------------




### Synopsis
Send-OBSCustomEvent : BroadcastCustomEvent



---


### Description

Broadcasts a `CustomEvent` to all WebSocket clients. Receivers are clients which are identified and subscribed.


Send-OBSCustomEvent calls the OBS WebSocket with a request of type BroadcastCustomEvent.



---


### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#broadcastcustomevent](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#broadcastcustomevent)





---


### Parameters
#### **EventData**

Data payload to emit to all receivers






|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[PSObject]`|true    |1       |true (ByPropertyName)|



#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |Aliases                      |
|----------|--------|--------|---------------------|-----------------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|OutputRequest<br/>OutputInput|





---


### Syntax
```PowerShell
Send-OBSCustomEvent [-EventData] <PSObject> [-PassThru] [<CommonParameters>]
```
