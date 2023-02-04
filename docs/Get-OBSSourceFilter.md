Get-OBSSourceFilter
-------------------
### Synopsis
Get-OBSSourceFilter : GetSourceFilter

---
### Description

Gets the info for a specific source filter.


Get-OBSSourceFilter calls the OBS WebSocket with a request of type GetSourceFilter.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsourcefilter](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsourcefilter)



---
### Parameters
#### **SourceName**

Name of the source






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|



---
#### **FilterName**

Name of the filter






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |2       |true (ByPropertyName)|



---
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
### Syntax
```PowerShell
Get-OBSSourceFilter [-SourceName] <String> [-FilterName] <String> [-PassThru] [<CommonParameters>]
```
---
