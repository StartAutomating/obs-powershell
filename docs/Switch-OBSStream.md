Switch-OBSStream
----------------
### Synopsis
Switch-OBSStream : ToggleStream

---
### Description

Toggles the status of the stream output.


Switch-OBSStream calls the OBS WebSocket with a request of type ToggleStream.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#togglestream](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#togglestream)



---
### Examples
#### EXAMPLE 1
```PowerShell
Switch-OBSStream
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
Switch-OBSStream [-PassThru] [<CommonParameters>]
```
---
