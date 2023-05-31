@{
    ModuleVersion     = '0.1.7'
    RootModule        = 'obs-powershell.psm1'
    Description       = 'Script OBS with PowerShell'
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
    FunctionsToExport = 'Clear-OBSScene',
'Connect-OBS',
'Disconnect-OBS',
'Get-OBS',
'Hide-OBS',
'Receive-OBS',
'Remove-OBS',
'Send-OBS',
'Show-OBS',
'Watch-OBS',
'Set-OBSAudioOutputSource',
'Set-OBSBrowserSource',
'Set-OBSColorSource',
'Set-OBSDisplaySource',
'Set-OBSMediaSource',
'Set-OBSVLCSource',
'Set-OBSWindowSource',
'Get-OBSEffect',
'Import-OBSEffect',
'Remove-OBSEffect',
'Add-OBSInput',
'Add-OBSProfile',
'Add-OBSScene',
'Add-OBSSceneCollection',
'Add-OBSSceneItem',
'Add-OBSSourceFilter',
'Copy-OBSSceneItem',
'Get-OBSCurrentPreviewScene',
'Get-OBSCurrentProgramScene',
'Get-OBSCurrentSceneTransition',
'Get-OBSCurrentSceneTransitionCursor',
'Get-OBSGroup',
'Get-OBSGroupSceneItem',
'Get-OBSHotkey',
'Get-OBSInput',
'Get-OBSInputAudioBalance',
'Get-OBSInputAudioMonitorType',
'Get-OBSInputAudioSyncOffset',
'Get-OBSInputAudioTracks',
'Get-OBSInputDefaultSettings',
'Get-OBSInputKind',
'Get-OBSInputMute',
'Get-OBSInputPropertiesListPropertyItems',
'Get-OBSInputSettings',
'Get-OBSInputVolume',
'Get-OBSLastReplayBufferReplay',
'Get-OBSMediaInputStatus',
'Get-OBSMonitor',
'Get-OBSOutput',
'Get-OBSOutputSettings',
'Get-OBSOutputStatus',
'Get-OBSPersistentData',
'Get-OBSProfile',
'Get-OBSProfileParameter',
'Get-OBSRecordDirectory',
'Get-OBSRecordStatus',
'Get-OBSReplayBufferStatus',
'Get-OBSScene',
'Get-OBSSceneCollection',
'Get-OBSSceneItem',
'Get-OBSSceneItemBlendMode',
'Get-OBSSceneItemEnabled',
'Get-OBSSceneItemId',
'Get-OBSSceneItemIndex',
'Get-OBSSceneItemLocked',
'Get-OBSSceneItemTransform',
'Get-OBSSceneSceneTransitionOverride',
'Get-OBSSceneTransition',
'Get-OBSSourceActive',
'Get-OBSSourceFilter',
'Get-OBSSourceFilterDefaultSettings',
'Get-OBSSourceFilterList',
'Get-OBSSourceScreenshot',
'Get-OBSSpecialInputs',
'Get-OBSStats',
'Get-OBSStreamServiceSettings',
'Get-OBSStreamStatus',
'Get-OBSStudioModeEnabled',
'Get-OBSTransitionKind',
'Get-OBSVersion',
'Get-OBSVideoSettings',
'Get-OBSVirtualCamStatus',
'Open-OBSInputFiltersDialog',
'Open-OBSInputInteractDialog',
'Open-OBSInputPropertiesDialog',
'Open-OBSSourceProjector',
'Open-OBSVideoMixProjector',
'Remove-OBSInput',
'Remove-OBSProfile',
'Remove-OBSScene',
'Remove-OBSSceneItem',
'Remove-OBSSourceFilter',
'Resume-OBSRecord',
'Save-OBSReplayBuffer',
'Save-OBSSourceScreenshot',
'Send-OBSCallVendorRequest',
'Send-OBSCustomEvent',
'Send-OBSOffsetMediaInputCursor',
'Send-OBSPauseRecord',
'Send-OBSPressInputPropertiesButton',
'Send-OBSSleep',
'Send-OBSStreamCaption',
'Send-OBSTriggerHotkeyByKeySequence',
'Send-OBSTriggerHotkeyByName',
'Send-OBSTriggerMediaInputAction',
'Send-OBSTriggerStudioModeTransition',
'Set-OBSCurrentPreviewScene',
'Set-OBSCurrentProfile',
'Set-OBSCurrentProgramScene',
'Set-OBSCurrentSceneCollection',
'Set-OBSCurrentSceneTransition',
'Set-OBSCurrentSceneTransitionDuration',
'Set-OBSCurrentSceneTransitionSettings',
'Set-OBSInputAudioBalance',
'Set-OBSInputAudioMonitorType',
'Set-OBSInputAudioSyncOffset',
'Set-OBSInputAudioTracks',
'Set-OBSInputMute',
'Set-OBSInputName',
'Set-OBSInputSettings',
'Set-OBSInputVolume',
'Set-OBSMediaInputCursor',
'Set-OBSOutputSettings',
'Set-OBSPersistentData',
'Set-OBSProfileParameter',
'Set-OBSRecordDirectory',
'Set-OBSSceneItemBlendMode',
'Set-OBSSceneItemEnabled',
'Set-OBSSceneItemIndex',
'Set-OBSSceneItemLocked',
'Set-OBSSceneItemTransform',
'Set-OBSSceneName',
'Set-OBSSceneSceneTransitionOverride',
'Set-OBSSourceFilterEnabled',
'Set-OBSSourceFilterIndex',
'Set-OBSSourceFilterName',
'Set-OBSSourceFilterSettings',
'Set-OBSStreamServiceSettings',
'Set-OBSStudioModeEnabled',
'Set-OBSTBarPosition',
'Set-OBSVideoSettings',
'Start-OBSOutput',
'Start-OBSRecord',
'Start-OBSReplayBuffer',
'Start-OBSStream',
'Start-OBSVirtualCam',
'Stop-OBSOutput',
'Stop-OBSRecord',
'Stop-OBSReplayBuffer',
'Stop-OBSStream',
'Stop-OBSVirtualCam',
'Switch-OBSInputMute',
'Switch-OBSOutput',
'Switch-OBSRecord',
'Switch-OBSRecordPause',
'Switch-OBSReplayBuffer',
'Switch-OBSStream',
'Switch-OBSVirtualCam',
'Set-OBSColorFilter',
'Set-OBSEqualizerFilter',
'Set-OBSGainFilter',
'Set-OBSRenderDelayFilter',
'Set-OBSScaleFilter',
'Set-OBSScrollFilter',
'Set-OBSSharpnessFilter'
}

