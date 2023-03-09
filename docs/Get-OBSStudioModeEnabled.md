Get-OBSStudioModeEnabled
------------------------




### Synopsis
Get-OBSStudioModeEnabled : GetStudioModeEnabled



---


### Description

Gets whether studio is enabled.


Get-OBSStudioModeEnabled calls the OBS WebSocket with a request of type GetStudioModeEnabled.



---


### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getstudiomodeenabled](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getstudiomodeenabled)





---


### Examples
#### EXAMPLE 1
```PowerShell
Get-OBSStudioModeEnabled
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
Get-OBSStudioModeEnabled [-PassThru] [<CommonParameters>]
```
