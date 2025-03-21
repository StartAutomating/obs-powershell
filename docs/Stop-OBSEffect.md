Stop-OBSEffect
--------------

### Synopsis
Stops obs-powershell effects.

---

### Description

Stops an effect in OBS PowerShell.

A running effect is a series of messages, and the obs-websocket does not let you cancel a message.

However, OBS effects can be bounced or running in a loop.

If these effects are stopped, they will not continue to loop or bounce.

---

### Related Links
* [Get-OBSEffect](Get-OBSEffect.md)

* [Start-OBSEffect](Start-OBSEffect.md)

---

### Parameters
#### **EffectName**
The name of the effect.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|true    |1       |true (ByPropertyName)|

---

### Syntax
```PowerShell
Stop-OBSEffect [-EffectName] <String> [<CommonParameters>]
```
