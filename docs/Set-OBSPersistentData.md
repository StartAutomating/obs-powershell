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
#### **slotValue**

The value to apply to the slot



> **Type**: ```[PSObject]```

> **Required**: true

> **Position**: 3

> **PipelineInput**:true (ByPropertyName)



---
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Set-OBSPersistentData [-realm] <String> [-slotName] <String> [-slotValue] <PSObject> [-PassThru] [<CommonParameters>]
```
---
