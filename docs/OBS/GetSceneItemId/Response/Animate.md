OBS.GetSceneItemId.Response.Animate()
-------------------------------------

### Synopsis
Animates scene items

---

### Description

Animates the motion of scene items within a frame.

---

### Examples
> EXAMPLE 1

```PowerShell
$stars = Add-OBSBrowserSource -URI https://pssvg.start-automating.com/Examples/Stars.svg
$stars.FitToScreen()
$stars.Animate(@{
    scale = 0.1        
},"00:00:01")
```

---
