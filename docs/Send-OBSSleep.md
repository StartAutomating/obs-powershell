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

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |1       |true (ByPropertyName)|

#### **SleepFrames**
Number of frames to sleep for (if `SERIAL_FRAME` mode)

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |2       |true (ByPropertyName)|

#### **PassThru**
If set, will return the information that would otherwise be sent to OBS.

|Type      |Required|Position|PipelineInput        |Aliases                      |
|----------|--------|--------|---------------------|-----------------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|OutputRequest<br/>OutputInput|

#### **NoResponse**
If set, will not attempt to receive a response from OBS.
This can increase performance, and also silently ignore critical errors

|Type      |Required|Position|PipelineInput        |Aliases                                                                |
|----------|--------|--------|---------------------|-----------------------------------------------------------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|NoReceive<br/>IgnoreResponse<br/>IgnoreReceive<br/>DoNotReceiveResponse|

---

### Syntax
```PowerShell
Send-OBSSleep [[-SleepMillis] <Double>] [[-SleepFrames] <Double>] [-PassThru] [-NoResponse] [<CommonParameters>]
```
