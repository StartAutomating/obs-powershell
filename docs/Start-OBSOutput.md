Start-OBSOutput
---------------




### Synopsis
Start-OBSOutput : StartOutput



---


### Description

Starts an output.


Start-OBSOutput calls the OBS WebSocket with a request of type StartOutput.



---


### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#startoutput](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#startoutput)





---


### Parameters
#### **OutputName**

Output name






|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|



#### **PassThru**

If set, will return the information that would otherwise be sent to OBS.






|Type      |Required|Position|PipelineInput        |Aliases                      |
|----------|--------|--------|---------------------|-----------------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|OutputRequest<br/>OutputInput|





---


### Syntax
```PowerShell
Start-OBSOutput [-OutputName] <String> [-PassThru] [<CommonParameters>]
```
