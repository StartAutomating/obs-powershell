Stop-OBSVirtualCam
------------------




### Synopsis
Stop-OBSVirtualCam : StopVirtualCam



---


### Description

Stops the virtualcam output.


Stop-OBSVirtualCam calls the OBS WebSocket with a request of type StopVirtualCam.



---


### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#stopvirtualcam](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#stopvirtualcam)





---


### Examples
#### EXAMPLE 1
```PowerShell
Stop-OBSVirtualCam
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
Stop-OBSVirtualCam [-PassThru] [<CommonParameters>]
```
