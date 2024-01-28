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

|Type      |Required|Position|PipelineInput                 |Aliases|
|----------|--------|--------|------------------------------|-------|
|`[Object]`|false   |1       |true (ByValue, ByPropertyName)|Payload|

#### **StepTime**
If provided, will sleep after each step.
If -StepTime is less than 10000 ticks, it will be treated as frames per second.
If -SerialFrame was provied, -StepTime will be the number of frames to wait.

|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[TimeSpan]`|false   |2       |true (ByPropertyName)|

#### **Parallel**
If set, will process a batch of requests in parallel.

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |

#### **SerialFrame**
If set, will process a batch of requests in parallel.

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |

#### **ReceiveBatch**
If set, will receive responses from batches of requests.

|Type      |Required|Position|PipelineInput|Aliases       |
|----------|--------|--------|-------------|--------------|
|`[Switch]`|false   |named   |false        |ReceiveBatches|

#### **NoResponse**
If set, will never attempt to receive a response.

|Type      |Required|Position|PipelineInput|Aliases                                                                |
|----------|--------|--------|-------------|-----------------------------------------------------------------------|
|`[Switch]`|false   |named   |false        |NoReceive<br/>IgnoreResponse<br/>IgnoreReceive<br/>DoNotReceiveResponse|

---

### Syntax
```PowerShell
Send-OBS [[-MessageData] <Object>] [[-StepTime] <TimeSpan>] [-Parallel] [-SerialFrame] [-ReceiveBatch] [-NoResponse] [<CommonParameters>]
```
