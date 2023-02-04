Get-OBSOutput
-------------
### Synopsis
Get-OBSOutput : GetOutputList

---
### Description

Gets the list of available outputs.


Get-OBSOutput calls the OBS WebSocket with a request of type GetOutputList.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getoutputlist](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getoutputlist)



---
### Examples
#### EXAMPLE 1
```PowerShell
Get-OBSOutput
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
Get-OBSOutput [-PassThru] [<CommonParameters>]
```
---
