Set-OBSSourceFilterIndex
------------------------




### Synopsis
Set-OBSSourceFilterIndex : SetSourceFilterIndex



---


### Description

Sets the index position of a filter on a source.


Set-OBSSourceFilterIndex calls the OBS WebSocket with a request of type SetSourceFilterIndex.



---


### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsourcefilterindex](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsourcefilterindex)





---


### Parameters
#### **SourceName**

Name of the source the filter is on






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|



#### **FilterName**

Name of the filter






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |2       |true (ByPropertyName)|



#### **FilterIndex**

New index position of the filter






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|true    |3       |true (ByPropertyName)|



#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |Aliases                      |
|----------|--------|--------|---------------------|-----------------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|OutputRequest<br/>OutputInput|





---


### Syntax
```PowerShell
Set-OBSSourceFilterIndex [-SourceName] <String> [-FilterName] <String> [-FilterIndex] <Double> [-PassThru] [<CommonParameters>]
```
