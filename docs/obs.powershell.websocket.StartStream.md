Start-OBSStream
---------------




### Synopsis
Start-OBSStream : StartStream



---


### Description

Starts the stream output.


Start-OBSStream calls the OBS WebSocket with a request of type StartStream.



---


### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#startstream](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#startstream)





---


### Examples
#### EXAMPLE 1
```PowerShell
Start-OBSStream
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
Start-OBSStream [-PassThru] [<CommonParameters>]
```
