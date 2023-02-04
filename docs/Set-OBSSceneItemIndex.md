Set-OBSSceneItemIndex
---------------------
### Synopsis
Set-OBSSceneItemIndex : SetSceneItemIndex

---
### Description

Sets the index position of a scene item in a scene.

Scenes and Groups


Set-OBSSceneItemIndex calls the OBS WebSocket with a request of type SetSceneItemIndex.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsceneitemindex](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsceneitemindex)



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
#### **SceneItemIndex**

New index position of the scene item






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Double]`|true    |3       |true (ByPropertyName)|



---
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
### Syntax
```PowerShell
Set-OBSSceneItemIndex [-SceneName] <String> [-SceneItemId] <Double> [-SceneItemIndex] <Double> [-PassThru] [<CommonParameters>]
```
---
