Send-OBS
--------
### Synopsis
Sends messages to the OBS websocket.

---
### Description

Sends one or more messages to the OBS websocket.

---
### Related Links
* [Receive-OBS](Receive-OBS.md)



* [Watch-OBS](Watch-OBS.md)



---
### Parameters
#### **MessageData**

The data to send to the obs websocket.



> **Type**: ```[Object]```

> **Required**: false

> **Position**: 1

> **PipelineInput**:true (ByValue, ByPropertyName)



---
#### **StepTime**

If provided, will sleep after each step.
If -StepTime is less than 10000 ticks, it will be treated as frames per second.
If -SerialFrame was provied, -StepTime will be the number of frames to wait.



> **Type**: ```[TimeSpan]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **Parallel**

If set, will process a batch of requests in parallel.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
#### **SerialFrame**

If set, will process a batch of requests in parallel.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:false



---
### Syntax
```PowerShell
Send-OBS [[-MessageData] <Object>] [[-StepTime] <TimeSpan>] [-Parallel] [-SerialFrame] [<CommonParameters>]
```
---
