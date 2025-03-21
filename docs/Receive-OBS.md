Receive-OBS
-----------

### Synopsis
Receives data from OBS

---

### Description

Receives responses from the OBS WebSocket

---

### Parameters
#### **MessageData**
The message data that has been received

|Type      |Required|Position|PipelineInput |
|----------|--------|--------|--------------|
|`[Object]`|false   |named   |true (ByValue)|

#### **WaitForReponse**
If set will wait for a response from the message and expand the results.

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |

#### **SendEvent**
If set, will responsd to known events, like 'hello', and resend other events as PowerShell events

|Type      |Required|Position|PipelineInput|Aliases|
|----------|--------|--------|-------------|-------|
|`[Switch]`|false   |named   |false        |Resend |

#### **WebSocketURI**
The OBS websocket URL.  If not provided, this will default to loopback on port 4455.

|Type   |Required|Position|PipelineInput|Aliases     |
|-------|--------|--------|-------------|------------|
|`[Uri]`|true    |named   |false        |WebSocketURL|

#### **WebSocketToken**
A randomly generated password used to connect to OBS.
You can see the websocket password in Tools -> obs-websocket settings -> show connect info

|Type      |Required|Position|PipelineInput|Aliases          |
|----------|--------|--------|-------------|-----------------|
|`[String]`|true    |named   |false        |WebSocketPassword|

---

### Syntax
```PowerShell
Receive-OBS [-MessageData <Object>] [-WaitForReponse] [<CommonParameters>]
```
```PowerShell
Receive-OBS [-MessageData <Object>] [-SendEvent] -WebSocketURI <Uri> -WebSocketToken <String> [<CommonParameters>]
```
