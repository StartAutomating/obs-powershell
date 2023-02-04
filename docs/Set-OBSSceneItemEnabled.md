Set-OBSSceneItemEnabled
-----------------------
### Synopsis
Set-OBSSceneItemEnabled : SetSceneItemEnabled

---
### Description

Sets the enable state of a scene item.

Scenes and Groups


Set-OBSSceneItemEnabled calls the OBS WebSocket with a request of type SetSceneItemEnabled.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsceneitemenabled](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsceneitemenabled)



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
#### **SceneItemEnabled**

New enable state of the scene item






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|true    |named   |true (ByPropertyName)|



---
#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|



---
### Syntax
```PowerShell
Set-OBSSceneItemEnabled [-SceneName] <String> [-SceneItemId] <Double> -SceneItemEnabled [-PassThru] [<CommonParameters>]
```
---
