Remove-OBSEffect
----------------

### Synopsis
Removes OBS Effects

---

### Description

Removes effects currently loaded into OBS-PowerShell.

---

### Related Links
* [Get-OBSEffect](Get-OBSEffect.md)

---

### Parameters
#### **EffectName**
The name of the effect.

|Type      |Required|Position|PipelineInput        |Aliases|
|----------|--------|--------|---------------------|-------|
|`[String]`|true    |1       |true (ByPropertyName)|Name   |

---

### Notes
This removes effects from memory, but will not delete effect commands or remove effect scripts.

---

### Syntax
```PowerShell
Remove-OBSEffect [-EffectName] <String> [<CommonParameters>]
```
