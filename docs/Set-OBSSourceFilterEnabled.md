Set-OBSSourceFilterEnabled
--------------------------




### Synopsis
Set-OBSSourceFilterEnabled : SetSourceFilterEnabled



---


### Description

Sets the enable state of a source filter.


Set-OBSSourceFilterEnabled calls the OBS WebSocket with a request of type SetSourceFilterEnabled.



---


### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsourcefilterenabled](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsourcefilterenabled)





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



#### **FilterEnabled**

New enable state of the filter






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|true    |named   |true (ByPropertyName)|



#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |Aliases                      |
|----------|--------|--------|---------------------|-----------------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|OutputRequest<br/>OutputInput|





---


### Syntax
```PowerShell
Set-OBSSourceFilterEnabled [-SourceName] <String> [-FilterName] <String> -FilterEnabled [-PassThru] [<CommonParameters>]
```
