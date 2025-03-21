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
> EXAMPLE 1

```PowerShell
Watch-OBS -WebSocketToken 12345  # Obviously, replace this with your password.
```
> EXAMPLE 2

```PowerShell
Watch-OBS    # If you turn off authentication on OBS
```

---

### Parameters
#### **WebSocketURI**
The OBS websocket URL.  If not provided, this will default to loopback on port 4455.

|Type   |Required|Position|PipelineInput        |Aliases     |
|-------|--------|--------|---------------------|------------|
|`[Uri]`|false   |1       |true (ByPropertyName)|WebSocketURL|

#### **WebSocketToken**
A randomly generated password used to connect to OBS.
You can see the websocket password in Tools -> obs-websocket settings -> show connect info

|Type      |Required|Position|PipelineInput        |Aliases          |
|----------|--------|--------|---------------------|-----------------|
|`[String]`|false   |2       |true (ByPropertyName)|WebSocketPassword|

#### **BufferSize**
The size of the buffer to use when receiving messages from the websocket.

|Type     |Required|Position|PipelineInput        |
|---------|--------|--------|---------------------|
|`[Int32]`|false   |3       |true (ByPropertyName)|

---

### Syntax
```PowerShell
Watch-OBS [[-WebSocketURI] <Uri>] [[-WebSocketToken] <String>] [[-BufferSize] <Int32>] [<CommonParameters>]
```
