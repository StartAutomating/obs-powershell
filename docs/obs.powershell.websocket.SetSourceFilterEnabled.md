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
|`[String]`|false   |1       |true (ByPropertyName)|

#### **SourceUuid**
UUID of the source the filter is on

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |2       |true (ByPropertyName)|

#### **FilterName**
Name of the filter

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |3       |true (ByPropertyName)|

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

#### **NoResponse**
If set, will not attempt to receive a response from OBS.
This can increase performance, and also silently ignore critical errors

|Type      |Required|Position|PipelineInput        |Aliases                                                                |
|----------|--------|--------|---------------------|-----------------------------------------------------------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|NoReceive<br/>IgnoreResponse<br/>IgnoreReceive<br/>DoNotReceiveResponse|

---

### Syntax
```PowerShell
Set-OBSSourceFilterEnabled [[-SourceName] <String>] [[-SourceUuid] <String>] [-FilterName] <String> -FilterEnabled [-PassThru] [-NoResponse] [<CommonParameters>]
```
