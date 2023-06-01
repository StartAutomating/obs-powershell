@{
    ModuleVersion     = '0.1.8'
    RootModule        = 'obs-powershell.psm1'
    Description       = 'Script your streams'
    Guid              = '1417123e-a932-439f-9b68-a7313cf1e170'
    Author            = 'James Brundage'
    CompanyName       = 'Start-Automating'
    Copyright         = '2022-2023 Start-Automating'
    FormatsToProcess  = 'obs-powershell.format.ps1xml'
    TypesToProcess    = 'obs-powershell.types.ps1xml'    
    RequiredModules   = 'ThreadJob'
    PowerShellVersion = '7.0'
    PrivateData = @{
        PSData = @{
            Tags = 'PowerShell', 'OBS'
            ProjectURI = 'https://github.com/StartAutomating/obs-powershell'
            LicenseURI = 'https://github.com/StartAutomating/obs-powershell/blob/main/LICENSE'
            ReleaseNotes = @'
## obs-powershell 0.1.8:

* Added Sponsorship, Please support obs-powershell (#78)
* Added OBS-PowerShell Effects (#109)
  * Effect Commands
    * Get-OBSEffect
    * Import-OBSEffect
    * Start-OBSEffect
    * Stop-OBSEffect
    * Remove-OBSEffect
  * ColorLoop (#113)
  * FadeIn (#112)
  * FadeOut (#114) (thanks @I-Am-Jakoby !)  
* Adding Commands for Filtering  
  * Set/Add-OBSGainFilter (#94) 
  * Set/Add-OBSColorFilter (#92)
  * Set/Add-OBSScrollFilter (#93)
  * Set/Add-OBSSharpnessFilter (#95)
  * Set/Add-OBSRenderDelayFilter (#96)
  * Set/Add-OBSEqualizerFilter (#97)
* New Easy Sources
  * Set/Add-OBSAudioOutputSource (#110)
  * Set/Add-OBSWindowSource (#104)
  * Set/Add-OBSVLCSource (#102)
* Scene Items Can Now Do A Lot More
  * Animate allows for multiple steps and is more careful (#75 and #73)
  * Move, Scale, Rotate are written using animate (#80, #81, #89)
* Extending Inputs (#99)
* Autogenerating help for extended types, thanks to a new version of [HelpOut](https://github.com/StartAutomating/HelpOut)
* Improving Performance and Stability of Send/Receive/Watch-OBS (#77, #90, #86, #106, #107)


* Also, new logo (#76)

---

## obs-powershell 0.1.7:

* New Commands:
  * Show-OBS (Fixes #66)
  * Hide-OBS (Fixes #67)
  * Remove-OBS (Fixes #68)

* Adding -Force to Add-OBS*Source commands (Fixes #69)
* Add-OBS*Source Commands:  Supporting -SceneItemEnabled (Fixes #70)
* Add-OBSMediaSource, adding -FitToScreen (Fixes #71)

---

## obs-powershell 0.1.6:

* Adding OBS.SceneItem .Scale (Fixes #64)
* OBS.SceneItem .FitToScreen, adjusting .Scale (Fixes #63)
* Add-OBSMediaSource: Fixing -InputSettings / -SceneItemEnabled (Fixes #62)

---

## obs-powershell 0.1.5:

* Adding OBS.SceneItem .Animate (Fixes #59)


---

## obs-powershell 0.1.4:

* Adding Add-OBSColorSource (Fixes #51)  
* Save-OBSSourceScreenShot:
  * Attaching .InputName, .SourceName, .ImageWidth, .ImageHeight to output (Fixes #50)
  * Now returns a file (Fixes #49)
* -Path parameters now attempt to resolve to an absolute path (Fixes #48)
* All scene items can now:
  * Blend() / get .BlendMode (Fixes #53)
  * FitToScreen() (Fixes #46)
  * Crop() (Fixes #57)
  * Rotate() (Fixes #35)
* Color Sources can now .SetColor (Fixes #55)

---

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

## obs-powershell 0.1.1:

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
            
## obs-powershell 0.1:

Initial Release of obs-powershell

* Connect-OBS/Disconnect-OBS let you connect and disconnect.
* Commands exist for every request in the websocket.
* OBS Events are broadcast to the the runspace.
'@
        }
    }
    FunctionsToExport = '' <#{
        $exportNames = Get-ChildItem -Recurse -Filter '*-*.ps1' |
            Where-Object Name -notmatch '\.[^\.]+\.ps1' |
            Foreach-Object { $_.Name.Substring(0, $_.Name.Length - $_.Extension.Length) }
        "'$($exportNames -join "',$([Environment]::Newline)'")'"
    }#>
}
