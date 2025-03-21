OBS.GetSceneItemId.Response.Move()
----------------------------------

### Synopsis
Moves a scene item

---

### Description

Moves a scene item throughout the screen.

This converts it's arguments to .Animate arguments.  Any single values will be assumed to be positionX/positionY

---

### Related Links
* OBS.GetSceneItemList.Response.Animate

---

### Examples
Load a source

```PowerShell
$stars = Add-OBSBrowserSource -URI https://pssvg.start-automating.com/Examples/Stars.svg
# fit it to the screen
$stars.FitToScreen()
# Move it diagonally across the screen
$stars.Move("-50%","150%", "00:00:05")
```

---
