Get-OBSEffect
-------------




### Synopsis
Gets OBS Effects



---


### Description

Gets effects currently loaded into OBS-PowerShell.

An effect can be thought of as a name with a series of messages to OBS.

Those messages can be defined in a .json file or a script, in any module that tags OBS.

They can also be defined in a function named like:

* `OBS.Effect.*`
* `OBS.FX.*`
* `OBS.PowerShell.Effect*`
* `OBS.PowerShell.FX*`



---


### Related Links
* [Add-OBSEffect](Add-OBSEffect.md)





---


### Parameters
#### **Name**

The name of the effect.






|Type      |Required|Position|PipelineInput        |Aliases   |
|----------|--------|--------|---------------------|----------|
|`[String]`|false   |1       |true (ByPropertyName)|EffectName|





---


### Syntax
```PowerShell
Get-OBSEffect [[-Name] <String>] [<CommonParameters>]
```
