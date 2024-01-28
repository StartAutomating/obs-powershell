Remove-OBS
----------

### Synopsis
Remove OBS

---

### Description

Removes items from OBS

---

### Related Links
* [Remove-OBSInput](Remove-OBSInput.md)

* [Remove-OBSScene](Remove-OBSScene.md)

---

### Examples
> EXAMPLE 1

```PowerShell
Remove-OBS -SourceName "foo"
```
> EXAMPLE 2

```PowerShell
Remove-OBS -SceneName "bar"
```

---

### Parameters
#### **ItemName**
The name of the item we want to remove

|Type      |Required|Position|PipelineInput        |Aliases                               |
|----------|--------|--------|---------------------|--------------------------------------|
|`[Object]`|true    |1       |true (ByPropertyName)|SourceName<br/>InputName<br/>SceneName|

#### **WhatIf**
-WhatIf is an automatic variable that is created when a command has ```[CmdletBinding(SupportsShouldProcess)]```.
-WhatIf is used to see what would happen, or return operations without executing them
#### **Confirm**
-Confirm is an automatic variable that is created when a command has ```[CmdletBinding(SupportsShouldProcess)]```.
-Confirm is used to -Confirm each operation.

If you pass ```-Confirm:$false``` you will not be prompted.

If the command sets a ```[ConfirmImpact("Medium")]``` which is lower than ```$confirmImpactPreference```, you will not be prompted unless -Confirm is passed.

---

### Syntax
```PowerShell
Remove-OBS [-ItemName] <Object> [-WhatIf] [-Confirm] [<CommonParameters>]
```
