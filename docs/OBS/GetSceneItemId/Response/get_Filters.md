get_Filters
-----------

### Synopsis
Gets a Scene Item's filters

---

### Description

Gets the filters related to an OBS input.

---

### Related Links
* Get-OBSSourceFilterList

---

### Examples
> EXAMPLE 1

```PowerShell
$obsPowerShellIcon = Show-OBS -Uri https://obs-powershell.start-automating.com/Assets/obs-powershell-animated-icon.svg
$obsPowerShellIcon | Set-OBSColorFilter -Opacity .5
$obsPowerShellIcon.Filters
```

---
