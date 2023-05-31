Start-OBSRecord
---------------




### Synopsis
Start-OBSRecord : StartRecord



---


### Description

Starts the record output.


Start-OBSRecord calls the OBS WebSocket with a request of type StartRecord.



---


### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#startrecord](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#startrecord)





---


### Examples
#### EXAMPLE 1
```PowerShell
Start-OBSRecord
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
Start-OBSRecord [-PassThru] [<CommonParameters>]
```
