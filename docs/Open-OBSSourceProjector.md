Open-OBSSourceProjector
-----------------------
### Synopsis
Open-OBSSourceProjector : OpenSourceProjector

---
### Description

Opens a projector for a source.

Note: This request serves to provide feature parity with 4.x. It is very likely to be changed/deprecated in a future release.


Open-OBSSourceProjector calls the OBS WebSocket with a request of type OpenSourceProjector.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#opensourceprojector](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#opensourceprojector)



---
### Parameters
#### **sourceName**

Name of the source to open a projector for



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

> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Open-OBSSourceProjector [-sourceName] <String> [[-monitorIndex] <Double>] [[-projectorGeometry] <String>] [-PassThru] [<CommonParameters>]
```
---
