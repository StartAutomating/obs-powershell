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
#### **SourceName**

Name of the source to open a projector for






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|



---
#### **MonitorIndex**

Monitor index, use `GetMonitorList` to obtain index






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|false   |2       |true (ByPropertyName)|



---
#### **ProjectorGeometry**

Size/Position data for a windowed projector, in Qt Base64 encoded format. Mutually exclusive with `monitorIndex`






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |3       |true (ByPropertyName)|



---
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
### Syntax
```PowerShell
Open-OBSSourceProjector [-SourceName] <String> [[-MonitorIndex] <Double>] [[-ProjectorGeometry] <String>] [-PassThru] [<CommonParameters>]
```
---
