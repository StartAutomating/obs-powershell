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
#### EXAMPLE 1
```PowerShell
Get-OBSStreamServiceSettings
```

---
### Parameters
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
### Syntax
```PowerShell
Get-OBSStreamServiceSettings [-PassThru] [<CommonParameters>]
```
---
