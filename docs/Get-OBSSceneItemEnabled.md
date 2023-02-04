Get-OBSSceneItemEnabled
-----------------------
### Synopsis
Get-OBSSceneItemEnabled : GetSceneItemEnabled

---
### Description

Gets the enable state of a scene item.

Scenes and Groups


Get-OBSSceneItemEnabled calls the OBS WebSocket with a request of type GetSceneItemEnabled.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemenabled](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemenabled)



---
### Parameters
#### **SceneName**

Name of the scene the item is in






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|



---
#### **SceneItemId**

Numeric ID of the scene item






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|true    |2       |true (ByPropertyName)|



---
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
### Syntax
```PowerShell
Get-OBSSceneItemEnabled [-SceneName] <String> [-SceneItemId] <Double> [-PassThru] [<CommonParameters>]
```
---
