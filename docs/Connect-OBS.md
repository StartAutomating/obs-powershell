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
> EXAMPLE 1

```PowerShell
Connect-OBS
```

---

### Parameters
#### **WebSocketUri**
The OBS websocket URL.  If not provided, this will default to loopback on port 4455.

|Type   |Required|Position|PipelineInput        |
|-------|--------|--------|---------------------|
|`[Uri]`|false   |named   |true (ByPropertyName)|

#### **WebSocketToken**
A randomly generated password used to connect to OBS.
You can see the websocket password in Tools -> obs-websocket settings -> show connect info

|Type      |Required|Position|PipelineInput        |Aliases          |
|----------|--------|--------|---------------------|-----------------|
|`[String]`|false   |named   |true (ByPropertyName)|WebSocketPassword|

---

### Syntax
```PowerShell
Connect-OBS [<CommonParameters>]
```
```PowerShell
Connect-OBS [-WebSocketUri <Uri>] [-WebSocketToken <String>] [<CommonParameters>]
```
