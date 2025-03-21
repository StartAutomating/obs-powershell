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
#### **VendorName**
Name of the vendor to use

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|

#### **RequestType**
The request type to call

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |2       |true (ByPropertyName)|

#### **RequestData**
Object containing appropriate request data

|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[PSObject]`|false   |3       |true (ByPropertyName)|

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
Send-OBSCallVendorRequest [-VendorName] <String> [-RequestType] <String> [[-RequestData] <PSObject>] [-PassThru] [-NoResponse] [<CommonParameters>]
```
