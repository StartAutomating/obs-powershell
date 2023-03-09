Get-OBSSpecialInputs
--------------------




### Synopsis
Get-OBSSpecialInputs : GetSpecialInputs



---


### Description

Gets the names of all special inputs.


Get-OBSSpecialInputs calls the OBS WebSocket with a request of type GetSpecialInputs.



---


### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getspecialinputs](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getspecialinputs)





---


### Examples
#### EXAMPLE 1
```PowerShell
Get-OBSSpecialInputs
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
Get-OBSSpecialInputs [-PassThru] [<CommonParameters>]
```
