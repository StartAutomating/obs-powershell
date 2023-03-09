Get-OBSSourceFilterDefaultSettings
----------------------------------




### Synopsis
Get-OBSSourceFilterDefaultSettings : GetSourceFilterDefaultSettings



---


### Description

Gets the default settings for a filter kind.


Get-OBSSourceFilterDefaultSettings calls the OBS WebSocket with a request of type GetSourceFilterDefaultSettings.



---


### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsourcefilterdefaultsettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsourcefilterdefaultsettings)





---


### Parameters
#### **FilterKind**

Filter kind to get the default settings for






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|



#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |Aliases                      |
|----------|--------|--------|---------------------|-----------------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|OutputRequest<br/>OutputInput|





---


### Syntax
```PowerShell
Get-OBSSourceFilterDefaultSettings [-FilterKind] <String> [-PassThru] [<CommonParameters>]
```
