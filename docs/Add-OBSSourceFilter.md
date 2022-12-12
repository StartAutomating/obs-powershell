Add-OBSSourceFilter
-------------------
### Synopsis
Add-OBSSourceFilter : CreateSourceFilter

---
### Description

Creates a new filter, adding it to the specified source.


Add-OBSSourceFilter calls the OBS WebSocket with a request of type CreateSourceFilter.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createsourcefilter](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createsourcefilter)



---
### Parameters
#### **sourceName**

Name of the source to add the filter to



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **filterName**

Name of the new filter to be created



> **Type**: ```[String]```

> **Required**: true

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **filterKind**

The kind of filter to be created



> **Type**: ```[String]```

> **Required**: true

> **Position**: 3

> **PipelineInput**:true (ByPropertyName)



---
#### **filterSettings**

Settings object to initialize the filter with



> **Type**: ```[PSObject]```

> **Required**: false

> **Position**: 4

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
Add-OBSSourceFilter [-sourceName] <String> [-filterName] <String> [-filterKind] <String> [[-filterSettings] <PSObject>] [-PassThru] [<CommonParameters>]
```
---
