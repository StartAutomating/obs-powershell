Add-OBSSourceFilter
-------------------

### Synopsis
Add-OBSSourceFilter : CreateSourceFilter

---

### Description

Creates a new filter, adding it to the specified source.

Add-OBSSourceFilter calls the OBS WebSocket with a request of type CreateSourceFilter.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createsourcefilter](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createsourcefilter)

---

### Parameters
#### **SourceName**
Name of the source to add the filter to

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |1       |true (ByPropertyName)|

#### **SourceUuid**
UUID of the source to add the filter to

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |2       |true (ByPropertyName)|

#### **FilterName**
Name of the new filter to be created

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |3       |true (ByPropertyName)|

#### **FilterKind**
The kind of filter to be created

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |4       |true (ByPropertyName)|

#### **FilterSettings**
Settings object to initialize the filter with

|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[PSObject]`|false   |5       |true (ByPropertyName)|

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
Add-OBSSourceFilter [[-SourceName] <String>] [[-SourceUuid] <String>] [-FilterName] <String> [-FilterKind] <String> [[-FilterSettings] <PSObject>] [-PassThru] [-NoResponse] [<CommonParameters>]
```
