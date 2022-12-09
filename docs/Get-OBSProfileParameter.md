Get-OBSProfileParameter
-----------------------
### Synopsis
Get-OBSProfileParameter : GetProfileParameter

---
### Description

Gets a parameter from the current profile's configuration.


Get-OBSProfileParameter calls the OBS WebSocket with a request of type GetProfileParameter.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getprofileparameter](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getprofileparameter)



---
### Parameters
#### **parameterCategory**

Category of the parameter to get



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **parameterName**

Name of the parameter to get



> **Type**: ```[String]```

> **Required**: true

> **Position**: 2

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Get-OBSProfileParameter [-parameterCategory] <String> [-parameterName] <String> [<CommonParameters>]
```
---
