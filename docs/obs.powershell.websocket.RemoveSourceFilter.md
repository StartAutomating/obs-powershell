Remove-OBSSourceFilter
----------------------




### Synopsis
Remove-OBSSourceFilter : RemoveSourceFilter



---


### Description

Removes a filter from a source.


Remove-OBSSourceFilter calls the OBS WebSocket with a request of type RemoveSourceFilter.



---


### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#removesourcefilter](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#removesourcefilter)





---


### Parameters
#### **SourceName**

Name of the source the filter is on






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|



#### **FilterName**

Name of the filter to remove






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |2       |true (ByPropertyName)|



#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |Aliases                      |
|----------|--------|--------|---------------------|-----------------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|OutputRequest<br/>OutputInput|





---


### Syntax
```PowerShell
Remove-OBSSourceFilter [-SourceName] <String> [-FilterName] <String> [-PassThru] [<CommonParameters>]
```
