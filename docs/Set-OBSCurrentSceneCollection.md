Set-OBSCurrentSceneCollection
-----------------------------
### Synopsis
Set-OBSCurrentSceneCollection : SetCurrentSceneCollection

---
### Description

Switches to a scene collection.

Note: This will block until the collection has finished changing.


Set-OBSCurrentSceneCollection calls the OBS WebSocket with a request of type SetCurrentSceneCollection.

---
### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentscenecollection](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentscenecollection)



---
### Parameters
#### **sceneCollectionName**

Name of the scene collection to switch to



> **Type**: ```[String]```

> **Required**: true

> **Position**: 1

> **PipelineInput**:true (ByPropertyName)



---
#### **PassThru**

> **Type**: ```[Switch]```

> **Required**: false

> **Position**: named

> **PipelineInput**:true (ByPropertyName)



---
### Syntax
```PowerShell
Set-OBSCurrentSceneCollection [-sceneCollectionName] <String> [-PassThru] [<CommonParameters>]
```
---
