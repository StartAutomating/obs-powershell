obs-powershell-commands
-----------------------

obs-powershell exports 354 commands
(171 functions and 183 aliases)

A good number of these commands directly correspond to an obs-websocket message.
For a complete list, see [obs-powershell-websocket-commands](obs-powershell-websocket-commands.md).


Functions
=========


|Name                                                                                      |Synopsis                                                                     |
|------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------|
|[Add-OBSInput](Add-OBSInput.md)                                                      |Add-OBSInput : CreateInput                                                   |
|[Add-OBSProfile](Add-OBSProfile.md)                                                  |Add-OBSProfile : CreateProfile                                               |
|[Add-OBSScene](Add-OBSScene.md)                                                      |Add-OBSScene : CreateScene                                                   |
|[Add-OBSSceneCollection](Add-OBSSceneCollection.md)                                  |Add-OBSSceneCollection : CreateSceneCollection                               |
|[Add-OBSSceneItem](Add-OBSSceneItem.md)                                              |Add-OBSSceneItem : CreateSceneItem                                           |
|[Add-OBSSourceFilter](Add-OBSSourceFilter.md)                                        |Add-OBSSourceFilter : CreateSourceFilter                                     |
|[Clear-OBSScene](Clear-OBSScene.md)                                                  |Clears a Scene in OBS                                                        |
|[Connect-OBS](Connect-OBS.md)                                                        |Connects to Open Broadcast Studio                                            |
|[Copy-OBSSceneItem](Copy-OBSSceneItem.md)                                            |Copy-OBSSceneItem : DuplicateSceneItem                                       |
|[Disconnect-OBS](Disconnect-OBS.md)                                                  |Disconnects OBS                                                              |
|[Get-OBS](Get-OBS.md)                                                                |Gets OBS                                                                     |
|[Get-OBSCurrentPreviewScene](Get-OBSCurrentPreviewScene.md)                          |Get-OBSCurrentPreviewScene : GetCurrentPreviewScene                          |
|[Get-OBSCurrentProgramScene](Get-OBSCurrentProgramScene.md)                          |Get-OBSCurrentProgramScene : GetCurrentProgramScene                          |
|[Get-OBSCurrentSceneTransition](Get-OBSCurrentSceneTransition.md)                    |Get-OBSCurrentSceneTransition : GetCurrentSceneTransition                    |
|[Get-OBSCurrentSceneTransitionCursor](Get-OBSCurrentSceneTransitionCursor.md)        |Get-OBSCurrentSceneTransitionCursor : GetCurrentSceneTransitionCursor        |
|[Get-OBSEffect](Get-OBSEffect.md)                                                    |Gets OBS Effects                                                             |
|[Get-OBSGroup](Get-OBSGroup.md)                                                      |Get-OBSGroup : GetGroupList                                                  |
|[Get-OBSGroupSceneItem](Get-OBSGroupSceneItem.md)                                    |Get-OBSGroupSceneItem : GetGroupSceneItemList                                |
|[Get-OBSHotkey](Get-OBSHotkey.md)                                                    |Get-OBSHotkey : GetHotkeyList                                                |
|[Get-OBSInput](Get-OBSInput.md)                                                      |Get-OBSInput : GetInputList                                                  |
|[Get-OBSInputAudioBalance](Get-OBSInputAudioBalance.md)                              |Get-OBSInputAudioBalance : GetInputAudioBalance                              |
|[Get-OBSInputAudioMonitorType](Get-OBSInputAudioMonitorType.md)                      |Get-OBSInputAudioMonitorType : GetInputAudioMonitorType                      |
|[Get-OBSInputAudioSyncOffset](Get-OBSInputAudioSyncOffset.md)                        |Get-OBSInputAudioSyncOffset : GetInputAudioSyncOffset                        |
|[Get-OBSInputAudioTracks](Get-OBSInputAudioTracks.md)                                |Get-OBSInputAudioTracks : GetInputAudioTracks                                |
|[Get-OBSInputDefaultSettings](Get-OBSInputDefaultSettings.md)                        |Get-OBSInputDefaultSettings : GetInputDefaultSettings                        |
|[Get-OBSInputKind](Get-OBSInputKind.md)                                              |Get-OBSInputKind : GetInputKindList                                          |
|[Get-OBSInputMute](Get-OBSInputMute.md)                                              |Get-OBSInputMute : GetInputMute                                              |
|[Get-OBSInputPropertiesListPropertyItems](Get-OBSInputPropertiesListPropertyItems.md)|Get-OBSInputPropertiesListPropertyItems : GetInputPropertiesListPropertyItems|
|[Get-OBSInputSettings](Get-OBSInputSettings.md)                                      |Get-OBSInputSettings : GetInputSettings                                      |
|[Get-OBSInputVolume](Get-OBSInputVolume.md)                                          |Get-OBSInputVolume : GetInputVolume                                          |
|[Get-OBSLastReplayBufferReplay](Get-OBSLastReplayBufferReplay.md)                    |Get-OBSLastReplayBufferReplay : GetLastReplayBufferReplay                    |
|[Get-OBSMediaInputStatus](Get-OBSMediaInputStatus.md)                                |Get-OBSMediaInputStatus : GetMediaInputStatus                                |
|[Get-OBSMonitor](Get-OBSMonitor.md)                                                  |Get-OBSMonitor : GetMonitorList                                              |
|[Get-OBSOutput](Get-OBSOutput.md)                                                    |Get-OBSOutput : GetOutputList                                                |
|[Get-OBSOutputSettings](Get-OBSOutputSettings.md)                                    |Get-OBSOutputSettings : GetOutputSettings                                    |
|[Get-OBSOutputStatus](Get-OBSOutputStatus.md)                                        |Get-OBSOutputStatus : GetOutputStatus                                        |
|[Get-OBSPersistentData](Get-OBSPersistentData.md)                                    |Get-OBSPersistentData : GetPersistentData                                    |
|[Get-OBSProfile](Get-OBSProfile.md)                                                  |Get-OBSProfile : GetProfileList                                              |
|[Get-OBSProfileParameter](Get-OBSProfileParameter.md)                                |Get-OBSProfileParameter : GetProfileParameter                                |
|[Get-OBSRecordDirectory](Get-OBSRecordDirectory.md)                                  |Get-OBSRecordDirectory : GetRecordDirectory                                  |
|[Get-OBSRecordStatus](Get-OBSRecordStatus.md)                                        |Get-OBSRecordStatus : GetRecordStatus                                        |
|[Get-OBSReplayBufferStatus](Get-OBSReplayBufferStatus.md)                            |Get-OBSReplayBufferStatus : GetReplayBufferStatus                            |
|[Get-OBSScene](Get-OBSScene.md)                                                      |Get-OBSScene : GetSceneList                                                  |
|[Get-OBSSceneCollection](Get-OBSSceneCollection.md)                                  |Get-OBSSceneCollection : GetSceneCollectionList                              |
|[Get-OBSSceneItem](Get-OBSSceneItem.md)                                              |Get-OBSSceneItem : GetSceneItemList                                          |
|[Get-OBSSceneItemBlendMode](Get-OBSSceneItemBlendMode.md)                            |Get-OBSSceneItemBlendMode : GetSceneItemBlendMode                            |
|[Get-OBSSceneItemEnabled](Get-OBSSceneItemEnabled.md)                                |Get-OBSSceneItemEnabled : GetSceneItemEnabled                                |
|[Get-OBSSceneItemId](Get-OBSSceneItemId.md)                                          |Get-OBSSceneItemId : GetSceneItemId                                          |
|[Get-OBSSceneItemIndex](Get-OBSSceneItemIndex.md)                                    |Get-OBSSceneItemIndex : GetSceneItemIndex                                    |
|[Get-OBSSceneItemLocked](Get-OBSSceneItemLocked.md)                                  |Get-OBSSceneItemLocked : GetSceneItemLocked                                  |
|[Get-OBSSceneItemTransform](Get-OBSSceneItemTransform.md)                            |Get-OBSSceneItemTransform : GetSceneItemTransform                            |
|[Get-OBSSceneSceneTransitionOverride](Get-OBSSceneSceneTransitionOverride.md)        |Get-OBSSceneSceneTransitionOverride : GetSceneSceneTransitionOverride        |
|[Get-OBSSceneTransition](Get-OBSSceneTransition.md)                                  |Get-OBSSceneTransition : GetSceneTransitionList                              |
|[Get-OBSSourceActive](Get-OBSSourceActive.md)                                        |Get-OBSSourceActive : GetSourceActive                                        |
|[Get-OBSSourceFilter](Get-OBSSourceFilter.md)                                        |Get-OBSSourceFilter : GetSourceFilter                                        |
|[Get-OBSSourceFilterDefaultSettings](Get-OBSSourceFilterDefaultSettings.md)          |Get-OBSSourceFilterDefaultSettings : GetSourceFilterDefaultSettings          |
|[Get-OBSSourceFilterList](Get-OBSSourceFilterList.md)                                |Get-OBSSourceFilterList : GetSourceFilterList                                |
|[Get-OBSSourceScreenshot](Get-OBSSourceScreenshot.md)                                |Get-OBSSourceScreenshot : GetSourceScreenshot                                |
|[Get-OBSSpecialInputs](Get-OBSSpecialInputs.md)                                      |Get-OBSSpecialInputs : GetSpecialInputs                                      |
|[Get-OBSStats](Get-OBSStats.md)                                                      |Get-OBSStats : GetStats                                                      |
|[Get-OBSStreamServiceSettings](Get-OBSStreamServiceSettings.md)                      |Get-OBSStreamServiceSettings : GetStreamServiceSettings                      |
|[Get-OBSStreamStatus](Get-OBSStreamStatus.md)                                        |Get-OBSStreamStatus : GetStreamStatus                                        |
|[Get-OBSStudioModeEnabled](Get-OBSStudioModeEnabled.md)                              |Get-OBSStudioModeEnabled : GetStudioModeEnabled                              |
|[Get-OBSTransitionKind](Get-OBSTransitionKind.md)                                    |Get-OBSTransitionKind : GetTransitionKindList                                |
|[Get-OBSVersion](Get-OBSVersion.md)                                                  |Get-OBSVersion : GetVersion                                                  |
|[Get-OBSVideoSettings](Get-OBSVideoSettings.md)                                      |Get-OBSVideoSettings : GetVideoSettings                                      |
|[Get-OBSVirtualCamStatus](Get-OBSVirtualCamStatus.md)                                |Get-OBSVirtualCamStatus : GetVirtualCamStatus                                |
|[Hide-OBS](Hide-OBS.md)                                                              |Hide OBS                                                                     |
|[Import-OBSEffect](Import-OBSEffect.md)                                              |Imports Effects                                                              |
|[Open-OBSInputFiltersDialog](Open-OBSInputFiltersDialog.md)                          |Open-OBSInputFiltersDialog : OpenInputFiltersDialog                          |
|[Open-OBSInputInteractDialog](Open-OBSInputInteractDialog.md)                        |Open-OBSInputInteractDialog : OpenInputInteractDialog                        |
|[Open-OBSInputPropertiesDialog](Open-OBSInputPropertiesDialog.md)                    |Open-OBSInputPropertiesDialog : OpenInputPropertiesDialog                    |
|[Open-OBSSourceProjector](Open-OBSSourceProjector.md)                                |Open-OBSSourceProjector : OpenSourceProjector                                |
|[Open-OBSVideoMixProjector](Open-OBSVideoMixProjector.md)                            |Open-OBSVideoMixProjector : OpenVideoMixProjector                            |
|[Receive-OBS](Receive-OBS.md)                                                        |Receives data from OBS                                                       |
|[Remove-OBS](Remove-OBS.md)                                                          |Remove OBS                                                                   |
|[Remove-OBSEffect](Remove-OBSEffect.md)                                              |Removes OBS Effects                                                          |
|[Remove-OBSInput](Remove-OBSInput.md)                                                |Remove-OBSInput : RemoveInput                                                |
|[Remove-OBSProfile](Remove-OBSProfile.md)                                            |Remove-OBSProfile : RemoveProfile                                            |
|[Remove-OBSScene](Remove-OBSScene.md)                                                |Remove-OBSScene : RemoveScene                                                |
|[Remove-OBSSceneItem](Remove-OBSSceneItem.md)                                        |Remove-OBSSceneItem : RemoveSceneItem                                        |
|[Remove-OBSSourceFilter](Remove-OBSSourceFilter.md)                                  |Remove-OBSSourceFilter : RemoveSourceFilter                                  |
|[Resume-OBSRecord](Resume-OBSRecord.md)                                              |Resume-OBSRecord : ResumeRecord                                              |
|[Save-OBSReplayBuffer](Save-OBSReplayBuffer.md)                                      |Save-OBSReplayBuffer : SaveReplayBuffer                                      |
|[Save-OBSSourceScreenshot](Save-OBSSourceScreenshot.md)                              |Save-OBSSourceScreenshot : SaveSourceScreenshot                              |
|[Send-OBS](Send-OBS.md)                                                              |Sends messages to the OBS websocket.                                         |
|[Send-OBSCallVendorRequest](Send-OBSCallVendorRequest.md)                            |Send-OBSCallVendorRequest : CallVendorRequest                                |
|[Send-OBSCustomEvent](Send-OBSCustomEvent.md)                                        |Send-OBSCustomEvent : BroadcastCustomEvent                                   |
|[Send-OBSOffsetMediaInputCursor](Send-OBSOffsetMediaInputCursor.md)                  |Send-OBSOffsetMediaInputCursor : OffsetMediaInputCursor                      |
|[Send-OBSPauseRecord](Send-OBSPauseRecord.md)                                        |Send-OBSPauseRecord : PauseRecord                                            |
|[Send-OBSPressInputPropertiesButton](Send-OBSPressInputPropertiesButton.md)          |Send-OBSPressInputPropertiesButton : PressInputPropertiesButton              |
|[Send-OBSSleep](Send-OBSSleep.md)                                                    |Send-OBSSleep : Sleep                                                        |
|[Send-OBSStreamCaption](Send-OBSStreamCaption.md)                                    |Send-OBSStreamCaption : SendStreamCaption                                    |
|[Send-OBSTriggerHotkeyByKeySequence](Send-OBSTriggerHotkeyByKeySequence.md)          |Send-OBSTriggerHotkeyByKeySequence : TriggerHotkeyByKeySequence              |
|[Send-OBSTriggerHotkeyByName](Send-OBSTriggerHotkeyByName.md)                        |Send-OBSTriggerHotkeyByName : TriggerHotkeyByName                            |
|[Send-OBSTriggerMediaInputAction](Send-OBSTriggerMediaInputAction.md)                |Send-OBSTriggerMediaInputAction : TriggerMediaInputAction                    |
|[Send-OBSTriggerStudioModeTransition](Send-OBSTriggerStudioModeTransition.md)        |Send-OBSTriggerStudioModeTransition : TriggerStudioModeTransition            |
|[Set-OBS3DFilter](Set-OBS3DFilter.md)                                                |Sets an OBS 3D Filter.                                                       |
|[Set-OBSAudioOutputSource](Set-OBSAudioOutputSource.md)                              |Adds or sets an audio output source                                          |
|[Set-OBSBrowserSource](Set-OBSBrowserSource.md)                                      |Sets a browser source                                                        |
|[Set-OBSColorFilter](Set-OBSColorFilter.md)                                          |Sets a color filter                                                          |
|[Set-OBSColorSource](Set-OBSColorSource.md)                                          |Adds a color source                                                          |
|[Set-OBSCurrentPreviewScene](Set-OBSCurrentPreviewScene.md)                          |Set-OBSCurrentPreviewScene : SetCurrentPreviewScene                          |
|[Set-OBSCurrentProfile](Set-OBSCurrentProfile.md)                                    |Set-OBSCurrentProfile : SetCurrentProfile                                    |
|[Set-OBSCurrentProgramScene](Set-OBSCurrentProgramScene.md)                          |Set-OBSCurrentProgramScene : SetCurrentProgramScene                          |
|[Set-OBSCurrentSceneCollection](Set-OBSCurrentSceneCollection.md)                    |Set-OBSCurrentSceneCollection : SetCurrentSceneCollection                    |
|[Set-OBSCurrentSceneTransition](Set-OBSCurrentSceneTransition.md)                    |Set-OBSCurrentSceneTransition : SetCurrentSceneTransition                    |
|[Set-OBSCurrentSceneTransitionDuration](Set-OBSCurrentSceneTransitionDuration.md)    |Set-OBSCurrentSceneTransitionDuration : SetCurrentSceneTransitionDuration    |
|[Set-OBSCurrentSceneTransitionSettings](Set-OBSCurrentSceneTransitionSettings.md)    |Set-OBSCurrentSceneTransitionSettings : SetCurrentSceneTransitionSettings    |
|[Set-OBSDisplaySource](Set-OBSDisplaySource.md)                                      |Adds a display source                                                        |
|[Set-OBSEqualizerFilter](Set-OBSEqualizerFilter.md)                                  |Sets a Equalizer filter.                                                     |
|[Set-OBSGainFilter](Set-OBSGainFilter.md)                                            |Sets a Gain filter.                                                          |
|[Set-OBSInputAudioBalance](Set-OBSInputAudioBalance.md)                              |Set-OBSInputAudioBalance : SetInputAudioBalance                              |
|[Set-OBSInputAudioMonitorType](Set-OBSInputAudioMonitorType.md)                      |Set-OBSInputAudioMonitorType : SetInputAudioMonitorType                      |
|[Set-OBSInputAudioSyncOffset](Set-OBSInputAudioSyncOffset.md)                        |Set-OBSInputAudioSyncOffset : SetInputAudioSyncOffset                        |
|[Set-OBSInputAudioTracks](Set-OBSInputAudioTracks.md)                                |Set-OBSInputAudioTracks : SetInputAudioTracks                                |
|[Set-OBSInputMute](Set-OBSInputMute.md)                                              |Set-OBSInputMute : SetInputMute                                              |
|[Set-OBSInputName](Set-OBSInputName.md)                                              |Set-OBSInputName : SetInputName                                              |
|[Set-OBSInputSettings](Set-OBSInputSettings.md)                                      |Set-OBSInputSettings : SetInputSettings                                      |
|[Set-OBSInputVolume](Set-OBSInputVolume.md)                                          |Set-OBSInputVolume : SetInputVolume                                          |
|[Set-OBSMarkdownSource](Set-OBSMarkdownSource.md)                                    |Sets a markdown source                                                       |
|[Set-OBSMediaInputCursor](Set-OBSMediaInputCursor.md)                                |Set-OBSMediaInputCursor : SetMediaInputCursor                                |
|[Set-OBSMediaSource](Set-OBSMediaSource.md)                                          |Adds a media source                                                          |
|[Set-OBSOutputSettings](Set-OBSOutputSettings.md)                                    |Set-OBSOutputSettings : SetOutputSettings                                    |
|[Set-OBSPersistentData](Set-OBSPersistentData.md)                                    |Set-OBSPersistentData : SetPersistentData                                    |
|[Set-OBSProfileParameter](Set-OBSProfileParameter.md)                                |Set-OBSProfileParameter : SetProfileParameter                                |
|[Set-OBSRecordDirectory](Set-OBSRecordDirectory.md)                                  |Set-OBSRecordDirectory : SetRecordDirectory                                  |
|[Set-OBSRenderDelayFilter](Set-OBSRenderDelayFilter.md)                              |Sets a RenderDelay filter.                                                   |
|[Set-OBSScaleFilter](Set-OBSScaleFilter.md)                                          |Sets a Scale filter.                                                         |
|[Set-OBSSceneItemBlendMode](Set-OBSSceneItemBlendMode.md)                            |Set-OBSSceneItemBlendMode : SetSceneItemBlendMode                            |
|[Set-OBSSceneItemEnabled](Set-OBSSceneItemEnabled.md)                                |Set-OBSSceneItemEnabled : SetSceneItemEnabled                                |
|[Set-OBSSceneItemIndex](Set-OBSSceneItemIndex.md)                                    |Set-OBSSceneItemIndex : SetSceneItemIndex                                    |
|[Set-OBSSceneItemLocked](Set-OBSSceneItemLocked.md)                                  |Set-OBSSceneItemLocked : SetSceneItemLocked                                  |
|[Set-OBSSceneItemTransform](Set-OBSSceneItemTransform.md)                            |Set-OBSSceneItemTransform : SetSceneItemTransform                            |
|[Set-OBSSceneName](Set-OBSSceneName.md)                                              |Set-OBSSceneName : SetSceneName                                              |
|[Set-OBSSceneSceneTransitionOverride](Set-OBSSceneSceneTransitionOverride.md)        |Set-OBSSceneSceneTransitionOverride : SetSceneSceneTransitionOverride        |
|[Set-OBSScrollFilter](Set-OBSScrollFilter.md)                                        |Sets a scroll filter.                                                        |
|[Set-OBSShaderFilter](Set-OBSShaderFilter.md)                                        |Sets a Shader filter.                                                        |
|[Set-OBSSharpnessFilter](Set-OBSSharpnessFilter.md)                                  |Sets a Sharpness filter.                                                     |
|[Set-OBSSourceFilterEnabled](Set-OBSSourceFilterEnabled.md)                          |Set-OBSSourceFilterEnabled : SetSourceFilterEnabled                          |
|[Set-OBSSourceFilterIndex](Set-OBSSourceFilterIndex.md)                              |Set-OBSSourceFilterIndex : SetSourceFilterIndex                              |
|[Set-OBSSourceFilterName](Set-OBSSourceFilterName.md)                                |Set-OBSSourceFilterName : SetSourceFilterName                                |
|[Set-OBSSourceFilterSettings](Set-OBSSourceFilterSettings.md)                        |Set-OBSSourceFilterSettings : SetSourceFilterSettings                        |
|[Set-OBSStreamServiceSettings](Set-OBSStreamServiceSettings.md)                      |Set-OBSStreamServiceSettings : SetStreamServiceSettings                      |
|[Set-OBSStudioModeEnabled](Set-OBSStudioModeEnabled.md)                              |Set-OBSStudioModeEnabled : SetStudioModeEnabled                              |
|[Set-OBSTBarPosition](Set-OBSTBarPosition.md)                                        |Set-OBSTBarPosition : SetTBarPosition                                        |
|[Set-OBSVideoSettings](Set-OBSVideoSettings.md)                                      |Set-OBSVideoSettings : SetVideoSettings                                      |
|[Set-OBSVLCSource](Set-OBSVLCSource.md)                                              |Adds a VLC playlist source                                                   |
|[Set-OBSWaveformSource](Set-OBSWaveformSource.md)                                    |OBS Waveform Source                                                          |
|[Set-OBSWindowSource](Set-OBSWindowSource.md)                                        |Adds or sets a window capture source                                         |
|[Show-OBS](Show-OBS.md)                                                              |Shows content in OBS                                                         |
|[Start-OBSEffect](Start-OBSEffect.md)                                                |Starts obs-powershell effects.                                               |
|[Start-OBSOutput](Start-OBSOutput.md)                                                |Start-OBSOutput : StartOutput                                                |
|[Start-OBSRecord](Start-OBSRecord.md)                                                |Start-OBSRecord : StartRecord                                                |
|[Start-OBSReplayBuffer](Start-OBSReplayBuffer.md)                                    |Start-OBSReplayBuffer : StartReplayBuffer                                    |
|[Start-OBSStream](Start-OBSStream.md)                                                |Start-OBSStream : StartStream                                                |
|[Start-OBSVirtualCam](Start-OBSVirtualCam.md)                                        |Start-OBSVirtualCam : StartVirtualCam                                        |
|[Stop-OBSEffect](Stop-OBSEffect.md)                                                  |Stops obs-powershell effects.                                                |
|[Stop-OBSOutput](Stop-OBSOutput.md)                                                  |Stop-OBSOutput : StopOutput                                                  |
|[Stop-OBSRecord](Stop-OBSRecord.md)                                                  |Stop-OBSRecord : StopRecord                                                  |
|[Stop-OBSReplayBuffer](Stop-OBSReplayBuffer.md)                                      |Stop-OBSReplayBuffer : StopReplayBuffer                                      |
|[Stop-OBSStream](Stop-OBSStream.md)                                                  |Stop-OBSStream : StopStream                                                  |
|[Stop-OBSVirtualCam](Stop-OBSVirtualCam.md)                                          |Stop-OBSVirtualCam : StopVirtualCam                                          |
|[Switch-OBSInputMute](Switch-OBSInputMute.md)                                        |Switch-OBSInputMute : ToggleInputMute                                        |
|[Switch-OBSOutput](Switch-OBSOutput.md)                                              |Switch-OBSOutput : ToggleOutput                                              |
|[Switch-OBSRecord](Switch-OBSRecord.md)                                              |Switch-OBSRecord : ToggleRecord                                              |
|[Switch-OBSRecordPause](Switch-OBSRecordPause.md)                                    |Switch-OBSRecordPause : ToggleRecordPause                                    |
|[Switch-OBSReplayBuffer](Switch-OBSReplayBuffer.md)                                  |Switch-OBSReplayBuffer : ToggleReplayBuffer                                  |
|[Switch-OBSStream](Switch-OBSStream.md)                                              |Switch-OBSStream : ToggleStream                                              |
|[Switch-OBSVirtualCam](Switch-OBSVirtualCam.md)                                      |Switch-OBSVirtualCam : ToggleVirtualCam                                      |
|[Watch-OBS](Watch-OBS.md)                                                            |Watches OBS                                                                  |




Aliases
=======

|Name                                                                                      |ResolvedCommand|
|------------------------------------------------------------------------------------------|---------------|
|[Add-OBSInput](Add-OBSInput.md)                                                      |
|[Add-OBSProfile](Add-OBSProfile.md)                                                  |
|[Add-OBSScene](Add-OBSScene.md)                                                      |
|[Add-OBSSceneCollection](Add-OBSSceneCollection.md)                                  |
|[Add-OBSSceneItem](Add-OBSSceneItem.md)                                              |
|[Add-OBSSourceFilter](Add-OBSSourceFilter.md)                                        |
|[Clear-OBSScene](Clear-OBSScene.md)                                                  |
|[Connect-OBS](Connect-OBS.md)                                                        |
|[Copy-OBSSceneItem](Copy-OBSSceneItem.md)                                            |
|[Disconnect-OBS](Disconnect-OBS.md)                                                  |
|[Get-OBS](Get-OBS.md)                                                                |
|[Get-OBSCurrentPreviewScene](Get-OBSCurrentPreviewScene.md)                          |
|[Get-OBSCurrentProgramScene](Get-OBSCurrentProgramScene.md)                          |
|[Get-OBSCurrentSceneTransition](Get-OBSCurrentSceneTransition.md)                    |
|[Get-OBSCurrentSceneTransitionCursor](Get-OBSCurrentSceneTransitionCursor.md)        |
|[Get-OBSEffect](Get-OBSEffect.md)                                                    |
|[Get-OBSGroup](Get-OBSGroup.md)                                                      |
|[Get-OBSGroupSceneItem](Get-OBSGroupSceneItem.md)                                    |
|[Get-OBSHotkey](Get-OBSHotkey.md)                                                    |
|[Get-OBSInput](Get-OBSInput.md)                                                      |
|[Get-OBSInputAudioBalance](Get-OBSInputAudioBalance.md)                              |
|[Get-OBSInputAudioMonitorType](Get-OBSInputAudioMonitorType.md)                      |
|[Get-OBSInputAudioSyncOffset](Get-OBSInputAudioSyncOffset.md)                        |
|[Get-OBSInputAudioTracks](Get-OBSInputAudioTracks.md)                                |
|[Get-OBSInputDefaultSettings](Get-OBSInputDefaultSettings.md)                        |
|[Get-OBSInputKind](Get-OBSInputKind.md)                                              |
|[Get-OBSInputMute](Get-OBSInputMute.md)                                              |
|[Get-OBSInputPropertiesListPropertyItems](Get-OBSInputPropertiesListPropertyItems.md)|
|[Get-OBSInputSettings](Get-OBSInputSettings.md)                                      |
|[Get-OBSInputVolume](Get-OBSInputVolume.md)                                          |
|[Get-OBSLastReplayBufferReplay](Get-OBSLastReplayBufferReplay.md)                    |
|[Get-OBSMediaInputStatus](Get-OBSMediaInputStatus.md)                                |
|[Get-OBSMonitor](Get-OBSMonitor.md)                                                  |
|[Get-OBSOutput](Get-OBSOutput.md)                                                    |
|[Get-OBSOutputSettings](Get-OBSOutputSettings.md)                                    |
|[Get-OBSOutputStatus](Get-OBSOutputStatus.md)                                        |
|[Get-OBSPersistentData](Get-OBSPersistentData.md)                                    |
|[Get-OBSProfile](Get-OBSProfile.md)                                                  |
|[Get-OBSProfileParameter](Get-OBSProfileParameter.md)                                |
|[Get-OBSRecordDirectory](Get-OBSRecordDirectory.md)                                  |
|[Get-OBSRecordStatus](Get-OBSRecordStatus.md)                                        |
|[Get-OBSReplayBufferStatus](Get-OBSReplayBufferStatus.md)                            |
|[Get-OBSScene](Get-OBSScene.md)                                                      |
|[Get-OBSSceneCollection](Get-OBSSceneCollection.md)                                  |
|[Get-OBSSceneItem](Get-OBSSceneItem.md)                                              |
|[Get-OBSSceneItemBlendMode](Get-OBSSceneItemBlendMode.md)                            |
|[Get-OBSSceneItemEnabled](Get-OBSSceneItemEnabled.md)                                |
|[Get-OBSSceneItemId](Get-OBSSceneItemId.md)                                          |
|[Get-OBSSceneItemIndex](Get-OBSSceneItemIndex.md)                                    |
|[Get-OBSSceneItemLocked](Get-OBSSceneItemLocked.md)                                  |
|[Get-OBSSceneItemTransform](Get-OBSSceneItemTransform.md)                            |
|[Get-OBSSceneSceneTransitionOverride](Get-OBSSceneSceneTransitionOverride.md)        |
|[Get-OBSSceneTransition](Get-OBSSceneTransition.md)                                  |
|[Get-OBSSourceActive](Get-OBSSourceActive.md)                                        |
|[Get-OBSSourceFilter](Get-OBSSourceFilter.md)                                        |
|[Get-OBSSourceFilterDefaultSettings](Get-OBSSourceFilterDefaultSettings.md)          |
|[Get-OBSSourceFilterList](Get-OBSSourceFilterList.md)                                |
|[Get-OBSSourceScreenshot](Get-OBSSourceScreenshot.md)                                |
|[Get-OBSSpecialInputs](Get-OBSSpecialInputs.md)                                      |
|[Get-OBSStats](Get-OBSStats.md)                                                      |
|[Get-OBSStreamServiceSettings](Get-OBSStreamServiceSettings.md)                      |
|[Get-OBSStreamStatus](Get-OBSStreamStatus.md)                                        |
|[Get-OBSStudioModeEnabled](Get-OBSStudioModeEnabled.md)                              |
|[Get-OBSTransitionKind](Get-OBSTransitionKind.md)                                    |
|[Get-OBSVersion](Get-OBSVersion.md)                                                  |
|[Get-OBSVideoSettings](Get-OBSVideoSettings.md)                                      |
|[Get-OBSVirtualCamStatus](Get-OBSVirtualCamStatus.md)                                |
|[Hide-OBS](Hide-OBS.md)                                                              |
|[Import-OBSEffect](Import-OBSEffect.md)                                              |
|[Open-OBSInputFiltersDialog](Open-OBSInputFiltersDialog.md)                          |
|[Open-OBSInputInteractDialog](Open-OBSInputInteractDialog.md)                        |
|[Open-OBSInputPropertiesDialog](Open-OBSInputPropertiesDialog.md)                    |
|[Open-OBSSourceProjector](Open-OBSSourceProjector.md)                                |
|[Open-OBSVideoMixProjector](Open-OBSVideoMixProjector.md)                            |
|[Receive-OBS](Receive-OBS.md)                                                        |
|[Remove-OBS](Remove-OBS.md)                                                          |
|[Remove-OBSEffect](Remove-OBSEffect.md)                                              |
|[Remove-OBSInput](Remove-OBSInput.md)                                                |
|[Remove-OBSProfile](Remove-OBSProfile.md)                                            |
|[Remove-OBSScene](Remove-OBSScene.md)                                                |
|[Remove-OBSSceneItem](Remove-OBSSceneItem.md)                                        |
|[Remove-OBSSourceFilter](Remove-OBSSourceFilter.md)                                  |
|[Resume-OBSRecord](Resume-OBSRecord.md)                                              |
|[Save-OBSReplayBuffer](Save-OBSReplayBuffer.md)                                      |
|[Save-OBSSourceScreenshot](Save-OBSSourceScreenshot.md)                              |
|[Send-OBS](Send-OBS.md)                                                              |
|[Send-OBSCallVendorRequest](Send-OBSCallVendorRequest.md)                            |
|[Send-OBSCustomEvent](Send-OBSCustomEvent.md)                                        |
|[Send-OBSOffsetMediaInputCursor](Send-OBSOffsetMediaInputCursor.md)                  |
|[Send-OBSPauseRecord](Send-OBSPauseRecord.md)                                        |
|[Send-OBSPressInputPropertiesButton](Send-OBSPressInputPropertiesButton.md)          |
|[Send-OBSSleep](Send-OBSSleep.md)                                                    |
|[Send-OBSStreamCaption](Send-OBSStreamCaption.md)                                    |
|[Send-OBSTriggerHotkeyByKeySequence](Send-OBSTriggerHotkeyByKeySequence.md)          |
|[Send-OBSTriggerHotkeyByName](Send-OBSTriggerHotkeyByName.md)                        |
|[Send-OBSTriggerMediaInputAction](Send-OBSTriggerMediaInputAction.md)                |
|[Send-OBSTriggerStudioModeTransition](Send-OBSTriggerStudioModeTransition.md)        |
|[Set-OBS3DFilter](Set-OBS3DFilter.md)                                                |
|[Set-OBSAudioOutputSource](Set-OBSAudioOutputSource.md)                              |
|[Set-OBSBrowserSource](Set-OBSBrowserSource.md)                                      |
|[Set-OBSColorFilter](Set-OBSColorFilter.md)                                          |
|[Set-OBSColorSource](Set-OBSColorSource.md)                                          |
|[Set-OBSCurrentPreviewScene](Set-OBSCurrentPreviewScene.md)                          |
|[Set-OBSCurrentProfile](Set-OBSCurrentProfile.md)                                    |
|[Set-OBSCurrentProgramScene](Set-OBSCurrentProgramScene.md)                          |
|[Set-OBSCurrentSceneCollection](Set-OBSCurrentSceneCollection.md)                    |
|[Set-OBSCurrentSceneTransition](Set-OBSCurrentSceneTransition.md)                    |
|[Set-OBSCurrentSceneTransitionDuration](Set-OBSCurrentSceneTransitionDuration.md)    |
|[Set-OBSCurrentSceneTransitionSettings](Set-OBSCurrentSceneTransitionSettings.md)    |
|[Set-OBSDisplaySource](Set-OBSDisplaySource.md)                                      |
|[Set-OBSEqualizerFilter](Set-OBSEqualizerFilter.md)                                  |
|[Set-OBSGainFilter](Set-OBSGainFilter.md)                                            |
|[Set-OBSInputAudioBalance](Set-OBSInputAudioBalance.md)                              |
|[Set-OBSInputAudioMonitorType](Set-OBSInputAudioMonitorType.md)                      |
|[Set-OBSInputAudioSyncOffset](Set-OBSInputAudioSyncOffset.md)                        |
|[Set-OBSInputAudioTracks](Set-OBSInputAudioTracks.md)                                |
|[Set-OBSInputMute](Set-OBSInputMute.md)                                              |
|[Set-OBSInputName](Set-OBSInputName.md)                                              |
|[Set-OBSInputSettings](Set-OBSInputSettings.md)                                      |
|[Set-OBSInputVolume](Set-OBSInputVolume.md)                                          |
|[Set-OBSMarkdownSource](Set-OBSMarkdownSource.md)                                    |
|[Set-OBSMediaInputCursor](Set-OBSMediaInputCursor.md)                                |
|[Set-OBSMediaSource](Set-OBSMediaSource.md)                                          |
|[Set-OBSOutputSettings](Set-OBSOutputSettings.md)                                    |
|[Set-OBSPersistentData](Set-OBSPersistentData.md)                                    |
|[Set-OBSProfileParameter](Set-OBSProfileParameter.md)                                |
|[Set-OBSRecordDirectory](Set-OBSRecordDirectory.md)                                  |
|[Set-OBSRenderDelayFilter](Set-OBSRenderDelayFilter.md)                              |
|[Set-OBSScaleFilter](Set-OBSScaleFilter.md)                                          |
|[Set-OBSSceneItemBlendMode](Set-OBSSceneItemBlendMode.md)                            |
|[Set-OBSSceneItemEnabled](Set-OBSSceneItemEnabled.md)                                |
|[Set-OBSSceneItemIndex](Set-OBSSceneItemIndex.md)                                    |
|[Set-OBSSceneItemLocked](Set-OBSSceneItemLocked.md)                                  |
|[Set-OBSSceneItemTransform](Set-OBSSceneItemTransform.md)                            |
|[Set-OBSSceneName](Set-OBSSceneName.md)                                              |
|[Set-OBSSceneSceneTransitionOverride](Set-OBSSceneSceneTransitionOverride.md)        |
|[Set-OBSScrollFilter](Set-OBSScrollFilter.md)                                        |
|[Set-OBSShaderFilter](Set-OBSShaderFilter.md)                                        |
|[Set-OBSSharpnessFilter](Set-OBSSharpnessFilter.md)                                  |
|[Set-OBSSourceFilterEnabled](Set-OBSSourceFilterEnabled.md)                          |
|[Set-OBSSourceFilterIndex](Set-OBSSourceFilterIndex.md)                              |
|[Set-OBSSourceFilterName](Set-OBSSourceFilterName.md)                                |
|[Set-OBSSourceFilterSettings](Set-OBSSourceFilterSettings.md)                        |
|[Set-OBSStreamServiceSettings](Set-OBSStreamServiceSettings.md)                      |
|[Set-OBSStudioModeEnabled](Set-OBSStudioModeEnabled.md)                              |
|[Set-OBSTBarPosition](Set-OBSTBarPosition.md)                                        |
|[Set-OBSVideoSettings](Set-OBSVideoSettings.md)                                      |
|[Set-OBSVLCSource](Set-OBSVLCSource.md)                                              |
|[Set-OBSWaveformSource](Set-OBSWaveformSource.md)                                    |
|[Set-OBSWindowSource](Set-OBSWindowSource.md)                                        |
|[Show-OBS](Show-OBS.md)                                                              |
|[Start-OBSEffect](Start-OBSEffect.md)                                                |
|[Start-OBSOutput](Start-OBSOutput.md)                                                |
|[Start-OBSRecord](Start-OBSRecord.md)                                                |
|[Start-OBSReplayBuffer](Start-OBSReplayBuffer.md)                                    |
|[Start-OBSStream](Start-OBSStream.md)                                                |
|[Start-OBSVirtualCam](Start-OBSVirtualCam.md)                                        |
|[Stop-OBSEffect](Stop-OBSEffect.md)                                                  |
|[Stop-OBSOutput](Stop-OBSOutput.md)                                                  |
|[Stop-OBSRecord](Stop-OBSRecord.md)                                                  |
|[Stop-OBSReplayBuffer](Stop-OBSReplayBuffer.md)                                      |
|[Stop-OBSStream](Stop-OBSStream.md)                                                  |
|[Stop-OBSVirtualCam](Stop-OBSVirtualCam.md)                                          |
|[Switch-OBSInputMute](Switch-OBSInputMute.md)                                        |
|[Switch-OBSOutput](Switch-OBSOutput.md)                                              |
|[Switch-OBSRecord](Switch-OBSRecord.md)                                              |
|[Switch-OBSRecordPause](Switch-OBSRecordPause.md)                                    |
|[Switch-OBSReplayBuffer](Switch-OBSReplayBuffer.md)                                  |
|[Switch-OBSStream](Switch-OBSStream.md)                                              |
|[Switch-OBSVirtualCam](Switch-OBSVirtualCam.md)                                      |
|[Watch-OBS](Watch-OBS.md)                                                            |
