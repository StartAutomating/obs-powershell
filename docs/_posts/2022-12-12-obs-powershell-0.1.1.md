---

title: obs powershell 0.1.1
sourceURL: https://github.com/StartAutomating/obs-powershell/releases/tag/v0.1.1
tag: release
---
## obs-powershell 0.1.1

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
            
## obs-powershell 0.1

Initial Release of obs-powershell

* Connect-OBS/Disconnect-OBS let you connect and disconnect.
* Commands exist for every request in the websocket.
* OBS Events are broadcast to the the runspace.
