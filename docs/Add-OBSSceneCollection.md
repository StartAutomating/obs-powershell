Add-OBSSceneCollection
----------------------
### Synopsis
Add-OBSSceneCollection : CreateSceneCollection

---
### Description

Creates a new scene collection, switching to it in the process.

Note: This will block until the collection has finished changing.


Add-OBSSceneCollection calls the OBS WebSocket with a request of type CreateSceneCollection.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createscenecollection](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createscenecollection)



---
### Parameters
#### **SceneCollectionName**

Name for the new scene collection






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
Add-OBSSceneCollection [-SceneCollectionName] <String> [-PassThru] [<CommonParameters>]
```
---
