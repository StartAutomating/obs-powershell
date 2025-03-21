Open-OBSVideoMixProjector
-------------------------

### Synopsis
Open-OBSVideoMixProjector : OpenVideoMixProjector

---

### Description

Opens a projector for a specific output video mix.

Mix types:

- `OBS_WEBSOCKET_VIDEO_MIX_TYPE_PREVIEW`
- `OBS_WEBSOCKET_VIDEO_MIX_TYPE_PROGRAM`
- `OBS_WEBSOCKET_VIDEO_MIX_TYPE_MULTIVIEW`

Note: This request serves to provide feature parity with 4.x. It is very likely to be changed/deprecated in a future release.

Open-OBSVideoMixProjector calls the OBS WebSocket with a request of type OpenVideoMixProjector.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#openvideomixprojector](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#openvideomixprojector)

---

### Parameters
#### **VideoMixType**
Type of mix to open

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|

#### **MonitorIndex**
Monitor index, use `GetMonitorList` to obtain index

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |2       |true (ByPropertyName)|

#### **ProjectorGeometry**
Size/Position data for a windowed projector, in Qt Base64 encoded format. Mutually exclusive with `monitorIndex`

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |3       |true (ByPropertyName)|

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
Open-OBSVideoMixProjector [-VideoMixType] <String> [[-MonitorIndex] <Double>] [[-ProjectorGeometry] <String>] [-PassThru] [-NoResponse] [<CommonParameters>]
```
