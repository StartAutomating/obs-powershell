Get-OBSProfile
--------------
### Synopsis
Get-OBSProfile : GetProfileList

---
### Description

Gets an array of all profiles


Get-OBSProfile calls the OBS WebSocket with a request of type GetProfileList.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getprofilelist](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getprofilelist)



---
### Examples
#### EXAMPLE 1
```PowerShell
Get-OBSProfile
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
Get-OBSProfile [-PassThru] [<CommonParameters>]
```
---
