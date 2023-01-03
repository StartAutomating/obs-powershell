---

title: Rasterizing SVGs with obs powershell
author: StartAutomating
sourceURL: https://github.com/StartAutomating/obs-powershell/issues/42
---
SVG is an amazing graphics format and a great web standard.

Unfortunately, it's also a standard that's not fully implemented by many imaging tools.

If, for instance, you want to rasterize an SVG with ImageMagik, go ahead and kiss your symbols goodbye and forget even using CSS classes.  Many imaging apps can't handle large chunks of the SVG standard, which leads to omitted text and elements.

And don't even get me started on _animated_ SVGs.

Luckily, OBS has a browser source, and lets us easily capture an SVG as an image or a video _exactly as it would render in Chrome_.

Let's cover images first.

Because SVGs are scalable, and raster images are not, step one is to get our dimensions right.

SVGs have a Viewbox, which contains the width and height they'll want to render at.

Create a browser source of that width / height, then pipe it to Save-OBSScreen.

~~~PowerShell
Add-OBSBrowserSource -Uri https://4bitcss.com/Batman.svg -Width 640 -Height 240 |
    Save-OBSSourceScreenshot -ImageFormat png -ImageFilePath (Join-Path $pwd "Batman.png")
~~~

![Because I'm Batman](https://4bitcss.com/Batman.png)

Because of the Object Pipeline in PowerShell, we don't even need to pass along the -ImageHeight and -ImageWidth to Save-OBSSourceScreenshot (the browser source has an .ImageHeight and .ImageWidth property).

It gets even better.

The file that Save-OBSSourceScreenshot returns packs a little bit of extra info:

* What source generated it
* What scene it was in

Which means we can actually just take a snapshot and remove it:

~~~PowerShell
Add-OBSBrowserSource -Uri https://4bitcss.com/Batman.svg -Width 640 -Height 240 |
    Save-OBSSourceScreenshot -ImageFormat png -ImageFilePath (Join-Path $pwd "Batman.png") |
    Remove-OBSSceneItem
~~~

Hope this Helps!
