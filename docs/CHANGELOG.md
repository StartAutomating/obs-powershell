## obs-powershell 0.1.3:

* Requiring ThreadJob Module (Thanks @nyanhp!) (Fixes #36)
* Fixing Add-OBSBrowserSource (Fixes #34)
* Improving Batch Processing Capabilities (Fixes #38)
* Requiring PowerShell Version 7

---


## obs-powershell 0.1.2:

* New Commands
  * Add-OBSBrowserSource (Fixes #24)
  * Add-OBSDisplaySource (Fixes #25)
  * Add-OBSMediaSource (Fixes #28)
  * Clear-OBSScene (Fixes #27)
* New Methods
  * OBS.GetSceneListResponse:
    * .Remove()/.Delete() (Fixes #26)
    * .Lock()/.Unlock() (Fixes #32)
* General Improvements
  * Standardizing Parameter Naming (Fixes #30)  
  * Using GUIDs for RequestIDs (Fixes #29)
  * Updated logo (Fixes #23)
  
---

## obs-powershell 0.1.1

* Connect-OBS now caches connections (Fixes #18)
* Adding new core commands:
  * Watch-OBS (Fixes #19)
  * Receive-OBS (Fixes #20)
  * Send-OBS (Fixes #21)
* All commands now support -PassThru (Fixes #16)
* All commands now increment requests correctly (Fixes #15)
* Improved formatting:
  * Get-OBSScene (Fixes #14)
  * Get-OBSSceneItem (Fixes #17)

---

## obs-powershell 0.1

Initial Release of obs-powershell

* Connect-OBS/Disconnect-OBS let you connect and disconnect.
* Commands exist for every request in the websocket.
* OBS Events are broadcast to the the runspace.

