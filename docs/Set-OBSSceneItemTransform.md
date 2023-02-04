Set-OBSSceneItemTransform
-------------------------
### Synopsis
Set-OBSSceneItemTransform : SetSceneItemTransform

---
### Description

Sets the transform and crop info of a scene item.


Set-OBSSceneItemTransform calls the OBS WebSocket with a request of type SetSceneItemTransform.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsceneitemtransform](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsceneitemtransform)



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
#### **SceneItemTransform**

Object containing scene item transform info to update






|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[PSObject]`|true    |3       |true (ByPropertyName)|



---
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
### Syntax
```PowerShell
Set-OBSSceneItemTransform [-SceneName] <String> [-SceneItemId] <Double> [-SceneItemTransform] <PSObject> [-PassThru] [<CommonParameters>]
```
---
