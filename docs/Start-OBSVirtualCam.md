Start-OBSVirtualCam
-------------------
### Synopsis
Start-OBSVirtualCam : StartVirtualCam

---
### Description

Starts the virtualcam output.


Start-OBSVirtualCam calls the OBS WebSocket with a request of type StartVirtualCam.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#startvirtualcam](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#startvirtualcam)



---
### Examples
#### EXAMPLE 1
```PowerShell
Start-OBSVirtualCam
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
Start-OBSVirtualCam [-PassThru] [<CommonParameters>]
```
---
