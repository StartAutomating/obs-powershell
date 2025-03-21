Import-OBSEffect
----------------

### Synopsis
Imports Effects

---

### Description

Imports obs-powershell effects

---

### Related Links
* [Get-OBSEffect](Get-OBSEffect.md)

---

### Examples
> EXAMPLE 1

```PowerShell
Import-OBSEffect -Path (Get-Module obs-powershell)
```

---

### Parameters
#### **From**
The source location of the effect.
This can be a string, file, directory, command, or module.

|Type      |Required|Position|PipelineInput                 |Aliases                                                                                 |
|----------|--------|--------|------------------------------|----------------------------------------------------------------------------------------|
|`[Object]`|true    |1       |true (ByValue, ByPropertyName)|FromPath<br/>FromModule<br/>FromScript<br/>FromFunction<br/>FullName<br/>Path<br/>Source|

---

### Syntax
```PowerShell
Import-OBSEffect [-From] <Object> [<CommonParameters>]
```
