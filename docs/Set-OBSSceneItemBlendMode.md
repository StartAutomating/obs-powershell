Set-OBSSceneItemBlendMode
-------------------------
### Synopsis
Set-OBSSceneItemBlendMode : SetSceneItemBlendMode

---
### Description

Sets the blend mode of a scene item.

Scenes and Groups


Set-OBSSceneItemBlendMode calls the OBS WebSocket with a request of type SetSceneItemBlendMode.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsceneitemblendmode](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsceneitemblendmode)



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
#### **SceneItemBlendMode**

New blend mode






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |3       |true (ByPropertyName)|



---
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
### Syntax
```PowerShell
Set-OBSSceneItemBlendMode [-SceneName] <String> [-SceneItemId] <Double> [-SceneItemBlendMode] <String> [-PassThru] [<CommonParameters>]
```
---
