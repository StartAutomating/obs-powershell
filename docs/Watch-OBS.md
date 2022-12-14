Watch-OBS
---------
### Synopsis
Watches OBS

---
### Description

Watches the OBS websocket for events.

---
### Related Links
* [Connect-OBS](Connect-OBS.md)



* [Receive-OBS](Receive-OBS.md)



---
### Examples
#### EXAMPLE 1
```PowerShell
Watch-OBS -WebSocketToken 12345  # Obviously, replace this with your password.
```

#### EXAMPLE 2
```PowerShell
Watch-OBS    # If you turn off authentication on OBS
```

---
### Parameters
#### **WebSocketURI**

The OBS websocket URL.  If not provided, this will default to loopback on port 4455.



> **Type**: ```[Uri]```

> **Required**: false

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **WebSocketToken**

A randomly generated password used to connect to OBS.
You can see the websocket password in Tools -> obs-websocket settings -> show connect info



> **Type**: ```[String]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Watch-OBS [[-WebSocketURI] <Uri>] [[-WebSocketToken] <String>] [<CommonParameters>]
```
---
