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
#### **realm**

The data realm to select. `OBS_WEBSOCKET_DATA_REALM_GLOBAL` or `OBS_WEBSOCKET_DATA_REALM_PROFILE`



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **slotName**

The name of the slot to retrieve data from



> **Type**: ```[String]```

> **Required**: true

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Get-OBSPersistentData [-realm] <String> [-slotName] <String> [<CommonParameters>]
```
---
