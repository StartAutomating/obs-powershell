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
#### **SleepMillis**

Number of milliseconds to sleep for (if `SERIAL_REALTIME` mode)



> **Type**: ```[Double]```

> **Required**: false

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **SleepFrames**

Number of frames to sleep for (if `SERIAL_FRAME` mode)



> **Type**: ```[Double]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Send-OBSSleep [[-SleepMillis] <Double>] [[-SleepFrames] <Double>] [-PassThru] [<CommonParameters>]
```
---
