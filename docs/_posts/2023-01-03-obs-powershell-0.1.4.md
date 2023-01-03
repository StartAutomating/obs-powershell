---

title: obs powershell 0.1.4
sourceURL: https://github.com/StartAutomating/obs-powershell/releases/tag/v0.1.4
tag: release
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
