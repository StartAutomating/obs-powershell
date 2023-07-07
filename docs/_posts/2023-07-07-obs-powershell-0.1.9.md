---

title: obs powershell 0.1.9
sourceURL: https://github.com/StartAutomating/obs-powershell/releases/tag/v0.1.9
tag: release
---
## obs-powershell 0.1.9:

* New Filters!
  * @exeldro makes some excellent obs plugins
  * obs-powershell now supports a couple of them:
  * Set-OBS3DFilter ([#137](https://github.com/StartAutomating/obs-powershell/issues/137)) - Transform an object in 3D!
  * Set-OBSShaderFilter ([#134](https://github.com/StartAutomating/obs-powershell/issues/134)) - Apply _any_ PixelShader!
* New Effects!
  * LeftToRight ([#125](https://github.com/StartAutomating/obs-powershell/issues/125)) / RightToLeft ([#126](https://github.com/StartAutomating/obs-powershell/issues/126))
  * TopToBottom ([#127](https://github.com/StartAutomating/obs-powershell/issues/127)) / BottomToTop ([#128](https://github.com/StartAutomating/obs-powershell/issues/128))
  * ZoomIn ([#129](https://github.com/StartAutomating/obs-powershell/issues/129)) / ZoomOut ([#130](https://github.com/StartAutomating/obs-powershell/issues/130))
* Effect Fixes
  * Start-OBSEffect - Adding -LoopCount ([#133](https://github.com/StartAutomating/obs-powershell/issues/133))
  * FadeIn/FadeOut no longer conflict ([#119](https://github.com/StartAutomating/obs-powershell/issues/119)) (thanks @I-Am-Jakoby)!

---

## obs-powershell 0.1.8:

* Added Sponsorship, Please support obs-powershell ([#78](https://github.com/StartAutomating/obs-powershell/issues/78))
* Added OBS-PowerShell Effects ([#109](https://github.com/StartAutomating/obs-powershell/issues/109))
  * Effect Commands
    * Get-OBSEffect
    * Import-OBSEffect
    * Start-OBSEffect
    * Stop-OBSEffect
    * Remove-OBSEffect
  * ColorLoop ([#113](https://github.com/StartAutomating/obs-powershell/issues/113))
  * FadeIn ([#112](https://github.com/StartAutomating/obs-powershell/issues/112))
  * FadeOut ([#114](https://github.com/StartAutomating/obs-powershell/issues/114)) (thanks @I-Am-Jakoby !)  
* Adding Commands for Filtering  
  * Set/Add-OBSGainFilter ([#94](https://github.com/StartAutomating/obs-powershell/issues/94)) 
  * Set/Add-OBSColorFilter ([#92](https://github.com/StartAutomating/obs-powershell/issues/92))
  * Set/Add-OBSScrollFilter ([#93](https://github.com/StartAutomating/obs-powershell/issues/93))
  * Set/Add-OBSSharpnessFilter ([#95](https://github.com/StartAutomating/obs-powershell/issues/95))
  * Set/Add-OBSRenderDelayFilter ([#96](https://github.com/StartAutomating/obs-powershell/issues/96))
  * Set/Add-OBSEqualizerFilter ([#97](https://github.com/StartAutomating/obs-powershell/issues/97))
* New Easy Sources
  * Set/Add-OBSAudioOutputSource ([#110](https://github.com/StartAutomating/obs-powershell/issues/110))
  * Set/Add-OBSWindowSource ([#104](https://github.com/StartAutomating/obs-powershell/issues/104))
  * Set/Add-OBSVLCSource ([#102](https://github.com/StartAutomating/obs-powershell/issues/102))
* Scene Items Can Now Do A Lot More
  * Animate allows for multiple steps and is more careful ([#75](https://github.com/StartAutomating/obs-powershell/issues/75) and [#73](https://github.com/StartAutomating/obs-powershell/issues/73))
  * Move, Scale, Rotate are written using animate ([#80](https://github.com/StartAutomating/obs-powershell/issues/80), [#81](https://github.com/StartAutomating/obs-powershell/issues/81), [#89](https://github.com/StartAutomating/obs-powershell/issues/89))
* Extending Inputs ([#99](https://github.com/StartAutomating/obs-powershell/issues/99))
* Autogenerating help for extended types, thanks to a new version of [HelpOut](https://github.com/StartAutomating/HelpOut)
* Improving Performance and Stability of Send/Receive/Watch-OBS ([#77](https://github.com/StartAutomating/obs-powershell/issues/77), [#90](https://github.com/StartAutomating/obs-powershell/issues/90), [#86](https://github.com/StartAutomating/obs-powershell/issues/86), [#106](https://github.com/StartAutomating/obs-powershell/issues/106), [#107](https://github.com/StartAutomating/obs-powershell/issues/107))


* Also, new logo ([#76](https://github.com/StartAutomating/obs-powershell/issues/76))

---

## obs-powershell 0.1.7:

* New Commands:
  * Show-OBS (Fixes [#66](https://github.com/StartAutomating/obs-powershell/issues/66))
  * Hide-OBS (Fixes [#67](https://github.com/StartAutomating/obs-powershell/issues/67))
  * Remove-OBS (Fixes [#68](https://github.com/StartAutomating/obs-powershell/issues/68))

* Adding -Force to Add-OBS*Source commands (Fixes [#69](https://github.com/StartAutomating/obs-powershell/issues/69))
* Add-OBS*Source Commands:  Supporting -SceneItemEnabled (Fixes [#70](https://github.com/StartAutomating/obs-powershell/issues/70))
* Add-OBSMediaSource, adding -FitToScreen (Fixes [#71](https://github.com/StartAutomating/obs-powershell/issues/71))

---

## obs-powershell 0.1.6:

* Adding OBS.SceneItem .Scale (Fixes [#64](https://github.com/StartAutomating/obs-powershell/issues/64))
* OBS.SceneItem .FitToScreen, adjusting .Scale (Fixes [#63](https://github.com/StartAutomating/obs-powershell/issues/63))
* Add-OBSMediaSource: Fixing -InputSettings / -SceneItemEnabled (Fixes [#62](https://github.com/StartAutomating/obs-powershell/issues/62))

---

## obs-powershell 0.1.5:

* Adding OBS.SceneItem .Animate (Fixes [#59](https://github.com/StartAutomating/obs-powershell/issues/59))


---

## obs-powershell 0.1.4:

* Adding Add-OBSColorSource (Fixes [#51](https://github.com/StartAutomating/obs-powershell/issues/51))  
* Save-OBSSourceScreenShot:
  * Attaching .InputName, .SourceName, .ImageWidth, .ImageHeight to output (Fixes [#50](https://github.com/StartAutomating/obs-powershell/issues/50))
  * Now returns a file (Fixes [#49](https://github.com/StartAutomating/obs-powershell/issues/49))
* -Path parameters now attempt to resolve to an absolute path (Fixes [#48](https://github.com/StartAutomating/obs-powershell/issues/48))
* All scene items can now:
  * Blend() / get .BlendMode (Fixes [#53](https://github.com/StartAutomating/obs-powershell/issues/53))
  * FitToScreen() (Fixes [#46](https://github.com/StartAutomating/obs-powershell/issues/46))
  * Crop() (Fixes [#57](https://github.com/StartAutomating/obs-powershell/issues/57))
  * Rotate() (Fixes [#35](https://github.com/StartAutomating/obs-powershell/issues/35))
* Color Sources can now .SetColor (Fixes [#55](https://github.com/StartAutomating/obs-powershell/issues/55))

---

## obs-powershell 0.1.3:

* Requiring ThreadJob Module (Thanks @nyanhp!) (Fixes [#36](https://github.com/StartAutomating/obs-powershell/issues/36))
* Fixing Add-OBSBrowserSource (Fixes [#34](https://github.com/StartAutomating/obs-powershell/issues/34))
* Improving Batch Processing Capabilities (Fixes [#38](https://github.com/StartAutomating/obs-powershell/issues/38))
* Requiring PowerShell Version 7

---

## obs-powershell 0.1.2:

* New Commands
  * Add-OBSBrowserSource (Fixes [#24](https://github.com/StartAutomating/obs-powershell/issues/24))
  * Add-OBSDisplaySource (Fixes [#25](https://github.com/StartAutomating/obs-powershell/issues/25))
  * Add-OBSMediaSource (Fixes [#28](https://github.com/StartAutomating/obs-powershell/issues/28))
  * Clear-OBSScene (Fixes [#27](https://github.com/StartAutomating/obs-powershell/issues/27))
* New Methods
  * OBS.GetSceneListResponse:
    * .Remove()/.Delete() (Fixes [#26](https://github.com/StartAutomating/obs-powershell/issues/26))
    * .Lock()/.Unlock() (Fixes [#32](https://github.com/StartAutomating/obs-powershell/issues/32))
* General Improvements
  * Standardizing Parameter Naming (Fixes [#30](https://github.com/StartAutomating/obs-powershell/issues/30))  
  * Using GUIDs for RequestIDs (Fixes [#29](https://github.com/StartAutomating/obs-powershell/issues/29))
  * Updated logo (Fixes [#23](https://github.com/StartAutomating/obs-powershell/issues/23))
  
---

## obs-powershell 0.1.1:

* Connect-OBS now caches connections (Fixes [#18](https://github.com/StartAutomating/obs-powershell/issues/18))
* Adding new core commands:
  * Watch-OBS (Fixes [#19](https://github.com/StartAutomating/obs-powershell/issues/19))
  * Receive-OBS (Fixes [#20](https://github.com/StartAutomating/obs-powershell/issues/20))
  * Send-OBS (Fixes [#21](https://github.com/StartAutomating/obs-powershell/issues/21))
* All commands now support -PassThru (Fixes [#16](https://github.com/StartAutomating/obs-powershell/issues/16))
* All commands now increment requests correctly (Fixes [#15](https://github.com/StartAutomating/obs-powershell/issues/15))
* Improved formatting:
  * Get-OBSScene (Fixes [#14](https://github.com/StartAutomating/obs-powershell/issues/14))
  * Get-OBSSceneItem (Fixes [#17](https://github.com/StartAutomating/obs-powershell/issues/17))

---
            
## obs-powershell 0.1:

Initial Release of obs-powershell

* Connect-OBS/Disconnect-OBS let you connect and disconnect.
* Commands exist for every request in the websocket.
* OBS Events are broadcast to the the runspace.
