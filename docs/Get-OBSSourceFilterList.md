Get-OBSSourceFilterList
-----------------------

### Synopsis
Get-OBSSourceFilterList : GetSourceFilterList

---

### Description

Gets an array of all of a source's filters.

Get-OBSSourceFilterList calls the OBS WebSocket with a request of type GetSourceFilterList.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsourcefilterlist](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsourcefilterlist)

---

### Parameters
#### **SourceName**
Name of the source

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |1       |true (ByPropertyName)|

#### **SourceUuid**
UUID of the source

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |2       |true (ByPropertyName)|

#### **PassThru**
If set, will return the information that would otherwise be sent to OBS.

|Type      |Required|Position|PipelineInput        |Aliases                      |
|----------|--------|--------|---------------------|-----------------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|OutputRequest<br/>OutputInput|

#### **NoResponse**
If set, will not attempt to receive a response from OBS.
This can increase performance, and also silently ignore critical errors

|Type      |Required|Position|PipelineInput        |Aliases                                                                |
|----------|--------|--------|---------------------|-----------------------------------------------------------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|NoReceive<br/>IgnoreResponse<br/>IgnoreReceive<br/>DoNotReceiveResponse|

---

### Syntax
```PowerShell
Get-OBSSourceFilterList [[-SourceName] <String>] [[-SourceUuid] <String>] [-PassThru] [-NoResponse] [<CommonParameters>]
```
