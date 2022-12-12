Set-OBSTBarPosition
-------------------
### Synopsis
Set-OBSTBarPosition : SetTBarPosition

---
### Description

Sets the position of the TBar.

**Very important note**: This will be deprecated and replaced in a future version of obs-websocket.


Set-OBSTBarPosition calls the OBS WebSocket with a request of type SetTBarPosition.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#settbarposition](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#settbarposition)



---
### Parameters
#### **position**

New position



> **Type**: ```[Double]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **release**

Whether to release the TBar. Only set `false` if you know that you will be sending another position update



> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

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
Set-OBSTBarPosition [-position] <Double> [-release] [-PassThru] [<CommonParameters>]
```
---
