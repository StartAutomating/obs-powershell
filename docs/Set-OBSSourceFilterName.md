Set-OBSSourceFilterName
-----------------------

### Synopsis
Set-OBSSourceFilterName : SetSourceFilterName

---

### Description

Sets the name of a source filter (rename).

Set-OBSSourceFilterName calls the OBS WebSocket with a request of type SetSourceFilterName.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsourcefiltername](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsourcefiltername)

---

### Parameters
#### **SourceName**
Name of the source the filter is on

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |1       |true (ByPropertyName)|

#### **SourceUuid**
UUID of the source the filter is on

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |2       |true (ByPropertyName)|

#### **FilterName**
Current name of the filter

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |3       |true (ByPropertyName)|

#### **NewFilterName**
New name for the filter

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |4       |true (ByPropertyName)|

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
Set-OBSSourceFilterName [[-SourceName] <String>] [[-SourceUuid] <String>] [-FilterName] <String> [-NewFilterName] <String> [-PassThru] [-NoResponse] [<CommonParameters>]
```
