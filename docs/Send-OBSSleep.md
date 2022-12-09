Send-OBSSleep
-------------
### Synopsis
Send-OBSSleep : Sleep

---
### Description

Sleeps for a time duration or number of frames. Only available in request batches with types `SERIAL_REALTIME` or `SERIAL_FRAME`.


Send-OBSSleep calls the OBS WebSocket with a request of type Sleep.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#sleep](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#sleep)



---
### Parameters
#### **sleepMillis**

Number of milliseconds to sleep for (if `SERIAL_REALTIME` mode)



> **Type**: ```[Double]```

> **Required**: false

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **sleepFrames**

Number of frames to sleep for (if `SERIAL_FRAME` mode)



> **Type**: ```[Double]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Send-OBSSleep [[-sleepMillis] <Double>] [[-sleepFrames] <Double>] [<CommonParameters>]
```
---
