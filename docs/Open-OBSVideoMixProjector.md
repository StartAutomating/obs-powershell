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
#### **videoMixType**

Type of mix to open



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **monitorIndex**

Monitor index, use `GetMonitorList` to obtain index



> **Type**: ```[Double]```

> **Required**: false

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **projectorGeometry**

Size/Position data for a windowed projector, in Qt Base64 encoded format. Mutually exclusive with `monitorIndex`



> **Type**: ```[String]```

> **Required**: false

> **Position**: 3

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
Open-OBSVideoMixProjector [-videoMixType] <String> [[-monitorIndex] <Double>] [[-projectorGeometry] <String>] [-PassThru] [<CommonParameters>]
```
---
