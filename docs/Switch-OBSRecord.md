Switch-OBSRecord
----------------
### Synopsis
Switch-OBSRecord : ToggleRecord

---
### Description

Toggles the status of the record output.


Switch-OBSRecord calls the OBS WebSocket with a request of type ToggleRecord.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#togglerecord](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#togglerecord)



---
### Examples
#### EXAMPLE 1
```PowerShell
Switch-OBSRecord
```

---
### Parameters
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
### Syntax
```PowerShell
Switch-OBSRecord [-PassThru] [<CommonParameters>]
```
---
