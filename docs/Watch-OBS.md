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

> **Type**: ```[Uri]```

> **Required**: false

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **WebSocketToken**

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
