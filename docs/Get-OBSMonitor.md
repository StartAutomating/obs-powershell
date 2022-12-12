Get-OBSMonitor
--------------
### Synopsis
Get-OBSMonitor : GetMonitorList

---
### Description

Gets a list of connected monitors and information about them.


Get-OBSMonitor calls the OBS WebSocket with a request of type GetMonitorList.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getmonitorlist](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getmonitorlist)



---
### Examples
#### EXAMPLE 1
```PowerShell
Get-OBSMonitor
```

---
### Parameters
#### **PassThru**

> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Get-OBSMonitor [-PassThru] [<CommonParameters>]
```
---
