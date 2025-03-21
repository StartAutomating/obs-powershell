Get-OBSStreamServiceSettings
----------------------------

### Synopsis
Get-OBSStreamServiceSettings : GetStreamServiceSettings

---

### Description

Gets the current stream service settings (stream destination).

Get-OBSStreamServiceSettings calls the OBS WebSocket with a request of type GetStreamServiceSettings.

---

### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getstreamservicesettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getstreamservicesettings)

---

### Examples
> EXAMPLE 1

```PowerShell
Get-OBSStreamServiceSettings
```

---

### Parameters
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
Get-OBSStreamServiceSettings [-PassThru] [-NoResponse] [<CommonParameters>]
```
