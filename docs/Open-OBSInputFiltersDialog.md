Open-OBSInputFiltersDialog
--------------------------

### Synopsis
Open-OBSInputFiltersDialog : OpenInputFiltersDialog

---

### Description

Opens the filters dialog of an input.

Open-OBSInputFiltersDialog calls the OBS WebSocket with a request of type OpenInputFiltersDialog.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#openinputfiltersdialog](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#openinputfiltersdialog)

---

### Parameters
#### **InputName**
Name of the input to open the dialog of

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |1       |true (ByPropertyName)|

#### **InputUuid**
UUID of the input to open the dialog of

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
Open-OBSInputFiltersDialog [[-InputName] <String>] [[-InputUuid] <String>] [-PassThru] [-NoResponse] [<CommonParameters>]
```
