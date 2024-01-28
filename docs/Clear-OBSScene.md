Clear-OBSScene
--------------

### Synopsis
Clears a Scene in OBS

---

### Description

Clears a Scene in OBS.

All inputs will be removed from the scene.

This cannot be undone, so you will be prompted for confirmation.

---

### Examples
> EXAMPLE 1

```PowerShell
Clear-OBSScene -SceneName Scene
```

---

### Parameters
#### **SceneName**
Name of the scene.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |1       |true (ByPropertyName)|

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
Clear-OBSScene [[-SceneName] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```
