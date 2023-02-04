Set-OBSProfileParameter
-----------------------
### Synopsis
Set-OBSProfileParameter : SetProfileParameter

---
### Description

Sets the value of a parameter in the current profile's configuration.


Set-OBSProfileParameter calls the OBS WebSocket with a request of type SetProfileParameter.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setprofileparameter](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setprofileparameter)



---
### Parameters
#### **ParameterCategory**

Category of the parameter to set






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|



---
#### **ParameterName**

Name of the parameter to set






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |2       |true (ByPropertyName)|



---
#### **ParameterValue**

Value of the parameter to set. Use `null` to delete






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |3       |true (ByPropertyName)|



---
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
### Syntax
```PowerShell
Set-OBSProfileParameter [-ParameterCategory] <String> [-ParameterName] <String> [-ParameterValue] <String> [-PassThru] [<CommonParameters>]
```
---
