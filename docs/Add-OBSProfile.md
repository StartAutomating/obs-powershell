Add-OBSProfile
--------------

### Synopsis
Add-OBSProfile : CreateProfile

---

### Description

Creates a new profile, switching to it in the process

Add-OBSProfile calls the OBS WebSocket with a request of type CreateProfile.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createprofile](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createprofile)

---

### Parameters
#### **ProfileName**
Name for the new profile

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|

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
Add-OBSProfile [-ProfileName] <String> [-PassThru] [-NoResponse] [<CommonParameters>]
```
