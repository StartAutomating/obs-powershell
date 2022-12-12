Send-OBSStreamCaption
---------------------
### Synopsis
Send-OBSStreamCaption : SendStreamCaption

---
### Description

Sends CEA-608 caption text over the stream output.


Send-OBSStreamCaption calls the OBS WebSocket with a request of type SendStreamCaption.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#sendstreamcaption](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#sendstreamcaption)



---
### Parameters
#### **captionText**

Caption text



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

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
Send-OBSStreamCaption [-captionText] <String> [-PassThru] [<CommonParameters>]
```
---
