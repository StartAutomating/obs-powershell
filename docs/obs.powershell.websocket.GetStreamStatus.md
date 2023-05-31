Get-OBSStreamStatus
-------------------




### Synopsis
Get-OBSStreamStatus : GetStreamStatus



---


### Description

Gets the status of the stream output.


Get-OBSStreamStatus calls the OBS WebSocket with a request of type GetStreamStatus.



---


### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getstreamstatus](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getstreamstatus)





---


### Examples
#### EXAMPLE 1
```PowerShell
Get-OBSStreamStatus
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
Get-OBSStreamStatus [-PassThru] [<CommonParameters>]
```
