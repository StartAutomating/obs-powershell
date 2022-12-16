@{
    ModuleVersion     = '0.1.1'
    RootModule        = 'obs-powershell.psm1'
    Description       = 'Script OBS with PowerShell'
    Guid              = '1417123e-a932-439f-9b68-a7313cf1e170'
    Author            = 'James Brundage'
    CompanyName       = 'Start-Automating'
    Copyright         = '2022 Start-Automating'
    FormatsToProcess  = 'obs-powershell.format.ps1xml'
    TypesToProcess    = 'obs-powershell.types.ps1xml'    
    PrivateData = @{
        PSData = @{
            Tags = 'PowerShell', 'OBS'
            ProjectURI = 'https://github.com/StartAutomating/obs-powershell'
            LicenseURI = 'https://github.com/StartAutomating/obs-powershell/blob/main/LICENSE'
            ReleaseNotes = @'
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
'@
        }
    }
    FunctionsToExport = 'Clear-OBSScene',
'Connect-OBS',
'Disconnect-OBS',
'Receive-OBS',
'Send-OBS',
'Watch-OBS',
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
'Add-OBSBrowserSource'
}

