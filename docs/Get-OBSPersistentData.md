Get-OBSPersistentData
---------------------

### Synopsis
Get-OBSPersistentData : GetPersistentData

---

### Description

Gets the value of a "slot" from the selected persistent data realm.

Get-OBSPersistentData calls the OBS WebSocket with a request of type GetPersistentData.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getpersistentdata](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getpersistentdata)

---

### Parameters
#### **Realm**
The data realm to select. `OBS_WEBSOCKET_DATA_REALM_GLOBAL` or `OBS_WEBSOCKET_DATA_REALM_PROFILE`

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|

#### **SlotName**
The name of the slot to retrieve data from

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |2       |true (ByPropertyName)|

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
Get-OBSPersistentData [-Realm] <String> [-SlotName] <String> [-PassThru] [-NoResponse] [<CommonParameters>]
```
