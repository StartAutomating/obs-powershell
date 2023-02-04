Get-OBSVirtualCamStatus
-----------------------
### Synopsis
Get-OBSVirtualCamStatus : GetVirtualCamStatus

---
### Description

Gets the status of the virtualcam output.


Get-OBSVirtualCamStatus calls the OBS WebSocket with a request of type GetVirtualCamStatus.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getvirtualcamstatus](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getvirtualcamstatus)



---
### Examples
#### EXAMPLE 1
```PowerShell
Get-OBSVirtualCamStatus
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
Get-OBSVirtualCamStatus [-PassThru] [<CommonParameters>]
```
---
