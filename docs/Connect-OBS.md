Connect-OBS
-----------
### Synopsis
Connects to Open Broadcast Studio

---
### Description

Connects to the obs-websocket.

This must occur at least once to use obs-powershell.

---
### Related Links
* [Disconnect-OBS](Disconnect-OBS.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
Connect-OBS
```

---
### Parameters
#### **WebSocketToken**

A randomly generated password used to connect to obs.
You can see the websocket password in Tools -> obs-websocket settings -> show connect info



> **Type**: ```[String]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
#### **WebSocketUri**

The websocket URL.  If not provided, this will default to loopback on port 4455.



> **Type**: ```[Uri]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Connect-OBS [<CommonParameters>]
```
```PowerShell
Connect-OBS [-WebSocketToken <String>] [-WebSocketUri <Uri>] [<CommonParameters>]
```
---
