Remove-OBSInput
---------------
### Synopsis
Remove-OBSInput : RemoveInput

---
### Description

Removes an existing input.

Note: Will immediately remove all associated scene items.


Remove-OBSInput calls the OBS WebSocket with a request of type RemoveInput.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#removeinput](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#removeinput)



---
### Parameters
#### **InputName**

Name of the input to remove






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|



---
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
### Syntax
```PowerShell
Remove-OBSInput [-InputName] <String> [-PassThru] [<CommonParameters>]
```
---
