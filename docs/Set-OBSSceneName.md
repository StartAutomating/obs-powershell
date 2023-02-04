Set-OBSSceneName
----------------
### Synopsis
Set-OBSSceneName : SetSceneName

---
### Description

Sets the name of a scene (rename).


Set-OBSSceneName calls the OBS WebSocket with a request of type SetSceneName.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setscenename](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setscenename)



---
### Parameters
#### **SceneName**

Name of the scene to be renamed






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|



---
#### **NewSceneName**

New name for the scene






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |2       |true (ByPropertyName)|



---
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
### Syntax
```PowerShell
Set-OBSSceneName [-SceneName] <String> [-NewSceneName] <String> [-PassThru] [<CommonParameters>]
```
---
