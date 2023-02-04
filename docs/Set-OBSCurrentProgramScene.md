Set-OBSCurrentProgramScene
--------------------------
### Synopsis
Set-OBSCurrentProgramScene : SetCurrentProgramScene

---
### Description

Sets the current program scene.


Set-OBSCurrentProgramScene calls the OBS WebSocket with a request of type SetCurrentProgramScene.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentprogramscene](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentprogramscene)



---
### Parameters
#### **SceneName**

Scene to set as the current program scene






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|



---
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
### Syntax
```PowerShell
Set-OBSCurrentProgramScene [-SceneName] <String> [-PassThru] [<CommonParameters>]
```
---
