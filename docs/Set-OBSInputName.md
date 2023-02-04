Set-OBSInputName
----------------
### Synopsis
Set-OBSInputName : SetInputName

---
### Description

Sets the name of an input (rename).


Set-OBSInputName calls the OBS WebSocket with a request of type SetInputName.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputname](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputname)



---
### Parameters
#### **InputName**

Current input name






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|



---
#### **NewInputName**

New name for the input






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
Set-OBSInputName [-InputName] <String> [-NewInputName] <String> [-PassThru] [<CommonParameters>]
```
---
