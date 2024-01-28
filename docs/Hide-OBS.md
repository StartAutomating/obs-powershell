Hide-OBS
--------

### Synopsis
Hide OBS

---

### Description

Hides items in OBS

---

### Related Links
* [Set-OBSSceneItemEnabled](Set-OBSSceneItemEnabled.md)

---

### Examples
> EXAMPLE 1

```PowerShell
Hide-OBS -SourceName "foo"
```

---

### Parameters
#### **ItemName**
The name of the item we want to Hide

|Type      |Required|Position|PipelineInput        |Aliases                 |
|----------|--------|--------|---------------------|------------------------|
|`[Object]`|true    |1       |true (ByPropertyName)|SourceName<br/>InputName|

#### **SceneName**
The name of the scene.  If not provided, the current program scene will be used.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |2       |true (ByPropertyName)|

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
Hide-OBS [-ItemName] <Object> [[-SceneName] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```
