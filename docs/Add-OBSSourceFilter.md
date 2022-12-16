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
#### **SourceName**

Name of the source to add the filter to



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **FilterName**

Name of the new filter to be created



> **Type**: ```[String]```

> **Required**: true

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **FilterKind**

The kind of filter to be created



> **Type**: ```[String]```

> **Required**: true

> **Position**: 3

> **PipelineInput**:true (ByPropertyName)



---
#### **FilterSettings**

Settings object to initialize the filter with



> **Type**: ```[PSObject]```

> **Required**: false

> **Position**: 4

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
Add-OBSSourceFilter [-SourceName] <String> [-FilterName] <String> [-FilterKind] <String> [[-FilterSettings] <PSObject>] [-PassThru] [<CommonParameters>]
```
---
