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



> **Type**: ```[Object]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByValue)



---
#### **WaitForReponse**

If set will wait for a response from the message and expand the results.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **SendEvent**

If set, will responsd to known events, like 'hello', and resend other events as PowerShell events



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **WebSocketURI**

The OBS websocket URL.  If not provided, this will default to loopback on port 4455.



> **Type**: ```[Uri]```

> **Required**: true

> **Position**: named

> **PipelineInput**:false



---
#### **WebSocketToken**

A randomly generated password used to connect to OBS.
You can see the websocket password in Tools -> obs-websocket settings -> show connect info



> **Type**: ```[String]```

> **Required**: true

> **Position**: named

> **PipelineInput**:false



---
### Syntax
```PowerShell
Receive-OBS [-MessageData <Object>] [-WaitForReponse] [<CommonParameters>]
```
```PowerShell
Receive-OBS [-MessageData <Object>] [-SendEvent] -WebSocketURI <Uri> -WebSocketToken <String> [<CommonParameters>]
```
---
