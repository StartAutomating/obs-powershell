Set-OBSRecordDirectory
----------------------




### Synopsis
Set-OBSRecordDirectory : SetRecordDirectory



---


### Description

Sets the current directory that the record output writes files to.


Set-OBSRecordDirectory calls the OBS WebSocket with a request of type SetRecordDirectory.



---


### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setrecorddirectory](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setrecorddirectory)





---


### Parameters
#### **RecordDirectory**

Output directory






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
Set-OBSRecordDirectory [-RecordDirectory] <String> [-PassThru] [<CommonParameters>]
```
