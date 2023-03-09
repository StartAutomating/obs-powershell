Stop-OBSOutput
--------------




### Synopsis
Stop-OBSOutput : StopOutput



---


### Description

Stops an output.


Stop-OBSOutput calls the OBS WebSocket with a request of type StopOutput.



---


### Related Links
* [https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#stopoutput](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#stopoutput)





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
Stop-OBSOutput [-OutputName] <String> [-PassThru] [<CommonParameters>]
```
