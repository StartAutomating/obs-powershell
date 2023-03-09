Get-OBSOutputSettings
---------------------




### Synopsis
Get-OBSOutputSettings : GetOutputSettings



---


### Description

Gets the settings of an output.


Get-OBSOutputSettings calls the OBS WebSocket with a request of type GetOutputSettings.



---


### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getoutputsettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getoutputsettings)





---


### Parameters
#### **OutputName**

Output name






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
Get-OBSOutputSettings [-OutputName] <String> [-PassThru] [<CommonParameters>]
```
