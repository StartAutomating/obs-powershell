Send-OBSCallVendorRequest
-------------------------
### Synopsis
Send-OBSCallVendorRequest : CallVendorRequest

---
### Description

Call a request registered to a vendor.

A vendor is a unique name registered by a third-party plugin or script, which allows for custom requests and events to be added to obs-websocket.
If a plugin or script implements vendor requests or events, documentation is expected to be provided with them.


Send-OBSCallVendorRequest calls the OBS WebSocket with a request of type CallVendorRequest.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#callvendorrequest](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#callvendorrequest)



---
### Parameters
#### **vendorName**

Name of the vendor to use



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **requestType**

The request type to call



> **Type**: ```[String]```

> **Required**: true

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
#### **requestData**

Object containing appropriate request data



> **Type**: ```[PSObject]```

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
Send-OBSCallVendorRequest [-vendorName] <String> [-requestType] <String> [[-requestData] <PSObject>] [-PassThru] [<CommonParameters>]
```
---
