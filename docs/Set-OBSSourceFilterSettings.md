Set-OBSSourceFilterSettings
---------------------------

### Synopsis
Set-OBSSourceFilterSettings : SetSourceFilterSettings

---

### Description

Sets the settings of a source filter.

Set-OBSSourceFilterSettings calls the OBS WebSocket with a request of type SetSourceFilterSettings.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsourcefiltersettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsourcefiltersettings)

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
Name of the filter to set the settings of

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |3       |true (ByPropertyName)|

#### **FilterSettings**
Object of settings to apply

|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[PSObject]`|true    |4       |true (ByPropertyName)|

#### **Overlay**
True == apply the settings on top of existing ones, False == reset the input to its defaults, then apply settings.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

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
Set-OBSSourceFilterSettings [[-SourceName] <String>] [[-SourceUuid] <String>] [-FilterName] <String> [-FilterSettings] <PSObject> [-Overlay] [-PassThru] [-NoResponse] [<CommonParameters>]
```
