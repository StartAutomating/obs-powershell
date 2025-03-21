Remove-OBSProfile
-----------------

### Synopsis
Remove-OBSProfile : RemoveProfile

---

### Description

Removes a profile. If the current profile is chosen, it will change to a different profile first.

Remove-OBSProfile calls the OBS WebSocket with a request of type RemoveProfile.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#removeprofile](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#removeprofile)

---

### Parameters
#### **ProfileName**
Name of the profile to remove

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
Remove-OBSProfile [-ProfileName] <String> [-PassThru] [-NoResponse] [<CommonParameters>]
```
