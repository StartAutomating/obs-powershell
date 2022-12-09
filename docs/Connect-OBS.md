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
#### **Credential**

A credential describing the connection.
The username should be the IPAddress, and the password should be the obs-websocket password.



> **Type**: ```[PSCredential]```

> **Required**: false

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **WebSocketPassword**

The websocket password.
You can see the websocket password in Tools -> obs-websocket settings -> show connect info



> **Type**: ```[SecureString]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **WebSocketUri**

The websocket URL.  If not provided, this will default to loopback on port 4455.



> **Type**: ```[Uri]```

> **Required**: false

> **Position**: 3

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Connect-OBS [[-Credential] <PSCredential>] [[-WebSocketPassword] <SecureString>] [[-WebSocketUri] <Uri>] [<CommonParameters>]
```
---
