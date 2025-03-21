Set-OBSPersistentData
---------------------

### Synopsis
Set-OBSPersistentData : SetPersistentData

---

### Description

Sets the value of a "slot" from the selected persistent data realm.

Set-OBSPersistentData calls the OBS WebSocket with a request of type SetPersistentData.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setpersistentdata](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setpersistentdata)

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

#### **SlotValue**
The value to apply to the slot

|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[PSObject]`|true    |3       |true (ByPropertyName)|

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
Set-OBSPersistentData [-Realm] <String> [-SlotName] <String> [-SlotValue] <PSObject> [-PassThru] [-NoResponse] [<CommonParameters>]
```
