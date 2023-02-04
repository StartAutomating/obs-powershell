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



---
#### **SlotName**

The name of the slot to retrieve data from






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |2       |true (ByPropertyName)|



---
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
### Syntax
```PowerShell
Get-OBSPersistentData [-Realm] <String> [-SlotName] <String> [-PassThru] [<CommonParameters>]
```
---
