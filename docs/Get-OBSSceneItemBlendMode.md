Get-OBSSceneItemBlendMode
-------------------------
### Synopsis
Get-OBSSceneItemBlendMode : GetSceneItemBlendMode

---
### Description

Gets the blend mode of a scene item.

Blend modes:

- `OBS_BLEND_NORMAL`
- `OBS_BLEND_ADDITIVE`
- `OBS_BLEND_SUBTRACT`
- `OBS_BLEND_SCREEN`
- `OBS_BLEND_MULTIPLY`
- `OBS_BLEND_LIGHTEN`
- `OBS_BLEND_DARKEN`

Scenes and Groups


Get-OBSSceneItemBlendMode calls the OBS WebSocket with a request of type GetSceneItemBlendMode.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemblendmode](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemblendmode)



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
Get-OBSSceneItemBlendMode [-SceneName] <String> [-SceneItemId] <Double> [-PassThru] [<CommonParameters>]
```
---
