get_Input
---------

### Synopsis
Gets a Scene Item's Input

---

### Description

Gets the OBS Input related to the current scene item.

This value is cached upon first request, as it will never change as long as the source item exists.

---

### Examples
> EXAMPLE 1

```PowerShell
$stars = Show-OBS -Uri https://pssvg.start-automating.com/Examples/Stars.svg
$stars.Input
```

---
