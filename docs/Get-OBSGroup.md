Get-OBSGroup
------------




### Synopsis
Get-OBSGroup : GetGroupList



---


### Description

Gets an array of all groups in OBS.

Groups in OBS are actually scenes, but renamed and modified. In obs-websocket, we treat them as scenes where we can.


Get-OBSGroup calls the OBS WebSocket with a request of type GetGroupList.



---


### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getgrouplist](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getgrouplist)





---


### Examples
#### EXAMPLE 1
```PowerShell
Get-OBSGroup
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
Get-OBSGroup [-PassThru] [<CommonParameters>]
```
