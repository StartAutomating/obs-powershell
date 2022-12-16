<div style='text-align:center'>
<img src='Assets/obs-powershell.svg' />
<h1>
obs-powershell
</h1>
</div>

obs-powershell is a PowerShell module that lets you script Open Broadcast Studio.

## Getting Started

### Installing and importing

obs-powershell is available on the PowerShell gallery, so you can use these two simple lines to install / import

~~~PowerShell
Install-Module obs-powershell -Scope CurrentUser -Force
Import-Module obs-powershell -PassThru -Force
~~~

## Examples

### Getting all monitors

~~~PowerShell
Get-OBSMonitor
~~~

### Getting all kinds of available inputs
~~~PowerShell
Get-OBSInputKind
~~~

### Getting OBS Starts
~~~PowerShell
Get-OBSStats
~~~

### Getting Recording Status
~~~PowerShell
Get-OBSRecordStatus
~~~

### Starting Recording
~~~PowerShell
Start-OBSRecord
~~~

### Stopping Recording
~~~PowerShell
Stop-OBSRecord
~~~

### Start Recording, Wait 5 seconds, Stop Recording, and Play the Recording.
~~~PowerShell
Start-OBSRecord

Start-Sleep -Seconds 5

Stop-OBSRecord |
    Invoke-Item
~~~

### Listing scenes

~~~Powershell
Get-OBSScene
~~~

### Enabling all sources in all scenes
~~~PowerShell
Get-OBSScene |
    Select-Object -ExpandProperty Scene
    Get-OBSSceneItem |
    Set-OBSSceneItemEnabled -sceneItemEnabled
~~~

### Disabling all sources in all scenes
~~~PowerShell
Get-OBSScene |
    Select-Object -ExpandProperty Scene
    Get-OBSSceneItem |
    Set-OBSSceneItemEnabled -sceneItemEnabled:$false
~~~

### Adding a Browser Input to all scenes
~~~PowerShell
Get-OBSScene | 
    Add-OBSInput -inputName "Browser Input 2" -inputKind browser_source -inputSettings @{
        width=1920
        height=1080
        url='https://pssvg.start-automating.com/Examples/SpinningSpiral901.svg'
    }
~~~



## How it Works

obs-powershell communicates with OBS with the obs websocket.

obs-powershell has a command for every websocket request.

Because the obs-websocket cleanly documents it's protocol, most commands in obs-powershell are automatically generated with [PipeScript](https://github.com/StartAutomating/PipeScript).

### obs-powershell websocket commands


|Name                                                                                      |RequestType                                                                                                                                                  |
|------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
|[Add-OBSBrowserSource](Add-OBSBrowserSource.md)                                      |
|[Add-OBSInput](Add-OBSInput.md)                                                      |[CreateInput](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createinput)                                                |
|[Add-OBSProfile](Add-OBSProfile.md)                                                  |[CreateProfile](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createprofile)                                            |
|[Add-OBSScene](Add-OBSScene.md)                                                      |[CreateScene](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createscene)                                                |
|[Add-OBSSceneCollection](Add-OBSSceneCollection.md)                                  |[CreateSceneCollection](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createscenecollection)                            |
|[Add-OBSSceneItem](Add-OBSSceneItem.md)                                              |[CreateSceneItem](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createsceneitem)                                        |
|[Add-OBSSourceFilter](Add-OBSSourceFilter.md)                                        |[CreateSourceFilter](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createsourcefilter)                                  |
|[Clear-OBSScene](Clear-OBSScene.md)                                                  |
|[Copy-OBSSceneItem](Copy-OBSSceneItem.md)                                            |[DuplicateSceneItem](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#duplicatesceneitem)                                  |
|[Get-OBSCurrentPreviewScene](Get-OBSCurrentPreviewScene.md)                          |[GetCurrentPreviewScene](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getcurrentpreviewscene)                          |
|[Get-OBSCurrentProgramScene](Get-OBSCurrentProgramScene.md)                          |[GetCurrentProgramScene](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getcurrentprogramscene)                          |
|[Get-OBSCurrentSceneTransition](Get-OBSCurrentSceneTransition.md)                    |[GetCurrentSceneTransition](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getcurrentscenetransition)                    |
|[Get-OBSCurrentSceneTransitionCursor](Get-OBSCurrentSceneTransitionCursor.md)        |[GetCurrentSceneTransitionCursor](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getcurrentscenetransitioncursor)        |
|[Get-OBSGroup](Get-OBSGroup.md)                                                      |[GetGroupList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getgrouplist)                                              |
|[Get-OBSGroupSceneItem](Get-OBSGroupSceneItem.md)                                    |[GetGroupSceneItemList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getgroupsceneitemlist)                            |
|[Get-OBSHotkey](Get-OBSHotkey.md)                                                    |[GetHotkeyList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#gethotkeylist)                                            |
|[Get-OBSInput](Get-OBSInput.md)                                                      |[GetInputList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputlist)                                              |
|[Get-OBSInputAudioBalance](Get-OBSInputAudioBalance.md)                              |[GetInputAudioBalance](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputaudiobalance)                              |
|[Get-OBSInputAudioMonitorType](Get-OBSInputAudioMonitorType.md)                      |[GetInputAudioMonitorType](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputaudiomonitortype)                      |
|[Get-OBSInputAudioSyncOffset](Get-OBSInputAudioSyncOffset.md)                        |[GetInputAudioSyncOffset](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputaudiosyncoffset)                        |
|[Get-OBSInputAudioTracks](Get-OBSInputAudioTracks.md)                                |[GetInputAudioTracks](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputaudiotracks)                                |
|[Get-OBSInputDefaultSettings](Get-OBSInputDefaultSettings.md)                        |[GetInputDefaultSettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputdefaultsettings)                        |
|[Get-OBSInputKind](Get-OBSInputKind.md)                                              |[GetInputKindList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputkindlist)                                      |
|[Get-OBSInputMute](Get-OBSInputMute.md)                                              |[GetInputMute](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputmute)                                              |
|[Get-OBSInputPropertiesListPropertyItems](Get-OBSInputPropertiesListPropertyItems.md)|[GetInputPropertiesListPropertyItems](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputpropertieslistpropertyitems)|
|[Get-OBSInputSettings](Get-OBSInputSettings.md)                                      |[GetInputSettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputsettings)                                      |
|[Get-OBSInputVolume](Get-OBSInputVolume.md)                                          |[GetInputVolume](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputvolume)                                          |
|[Get-OBSLastReplayBufferReplay](Get-OBSLastReplayBufferReplay.md)                    |[GetLastReplayBufferReplay](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getlastreplaybufferreplay)                    |
|[Get-OBSMediaInputStatus](Get-OBSMediaInputStatus.md)                                |[GetMediaInputStatus](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getmediainputstatus)                                |
|[Get-OBSMonitor](Get-OBSMonitor.md)                                                  |[GetMonitorList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getmonitorlist)                                          |
|[Get-OBSOutput](Get-OBSOutput.md)                                                    |[GetOutputList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getoutputlist)                                            |
|[Get-OBSOutputSettings](Get-OBSOutputSettings.md)                                    |[GetOutputSettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getoutputsettings)                                    |
|[Get-OBSOutputStatus](Get-OBSOutputStatus.md)                                        |[GetOutputStatus](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getoutputstatus)                                        |
|[Get-OBSPersistentData](Get-OBSPersistentData.md)                                    |[GetPersistentData](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getpersistentdata)                                    |
|[Get-OBSProfile](Get-OBSProfile.md)                                                  |[GetProfileList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getprofilelist)                                          |
|[Get-OBSProfileParameter](Get-OBSProfileParameter.md)                                |[GetProfileParameter](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getprofileparameter)                                |
|[Get-OBSRecordDirectory](Get-OBSRecordDirectory.md)                                  |[GetRecordDirectory](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getrecorddirectory)                                  |
|[Get-OBSRecordStatus](Get-OBSRecordStatus.md)                                        |[GetRecordStatus](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getrecordstatus)                                        |
|[Get-OBSReplayBufferStatus](Get-OBSReplayBufferStatus.md)                            |[GetReplayBufferStatus](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getreplaybufferstatus)                            |
|[Get-OBSScene](Get-OBSScene.md)                                                      |[GetSceneList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getscenelist)                                              |
|[Get-OBSSceneCollection](Get-OBSSceneCollection.md)                                  |[GetSceneCollectionList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getscenecollectionlist)                          |
|[Get-OBSSceneItem](Get-OBSSceneItem.md)                                              |[GetSceneItemList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemlist)                                      |
|[Get-OBSSceneItemBlendMode](Get-OBSSceneItemBlendMode.md)                            |[GetSceneItemBlendMode](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemblendmode)                            |
|[Get-OBSSceneItemEnabled](Get-OBSSceneItemEnabled.md)                                |[GetSceneItemEnabled](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemenabled)                                |
|[Get-OBSSceneItemId](Get-OBSSceneItemId.md)                                          |[GetSceneItemId](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemid)                                          |
|[Get-OBSSceneItemIndex](Get-OBSSceneItemIndex.md)                                    |[GetSceneItemIndex](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemindex)                                    |
|[Get-OBSSceneItemLocked](Get-OBSSceneItemLocked.md)                                  |[GetSceneItemLocked](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemlocked)                                  |
|[Get-OBSSceneItemTransform](Get-OBSSceneItemTransform.md)                            |[GetSceneItemTransform](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemtransform)                            |
|[Get-OBSSceneSceneTransitionOverride](Get-OBSSceneSceneTransitionOverride.md)        |[GetSceneSceneTransitionOverride](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getscenescenetransitionoverride)        |
|[Get-OBSSceneTransition](Get-OBSSceneTransition.md)                                  |[GetSceneTransitionList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getscenetransitionlist)                          |
|[Get-OBSSourceActive](Get-OBSSourceActive.md)                                        |[GetSourceActive](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsourceactive)                                        |
|[Get-OBSSourceFilter](Get-OBSSourceFilter.md)                                        |[GetSourceFilter](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsourcefilter)                                        |
|[Get-OBSSourceFilterDefaultSettings](Get-OBSSourceFilterDefaultSettings.md)          |[GetSourceFilterDefaultSettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsourcefilterdefaultsettings)          |
|[Get-OBSSourceFilterList](Get-OBSSourceFilterList.md)                                |[GetSourceFilterList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsourcefilterlist)                                |
|[Get-OBSSourceScreenshot](Get-OBSSourceScreenshot.md)                                |[GetSourceScreenshot](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsourcescreenshot)                                |
|[Get-OBSSpecialInputs](Get-OBSSpecialInputs.md)                                      |[GetSpecialInputs](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getspecialinputs)                                      |
|[Get-OBSStats](Get-OBSStats.md)                                                      |[GetStats](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getstats)                                                      |
|[Get-OBSStreamServiceSettings](Get-OBSStreamServiceSettings.md)                      |[GetStreamServiceSettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getstreamservicesettings)                      |
|[Get-OBSStreamStatus](Get-OBSStreamStatus.md)                                        |[GetStreamStatus](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getstreamstatus)                                        |
|[Get-OBSStudioModeEnabled](Get-OBSStudioModeEnabled.md)                              |[GetStudioModeEnabled](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getstudiomodeenabled)                              |
|[Get-OBSTransitionKind](Get-OBSTransitionKind.md)                                    |[GetTransitionKindList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#gettransitionkindlist)                            |
|[Get-OBSVersion](Get-OBSVersion.md)                                                  |[GetVersion](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getversion)                                                  |
|[Get-OBSVideoSettings](Get-OBSVideoSettings.md)                                      |[GetVideoSettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getvideosettings)                                      |
|[Get-OBSVirtualCamStatus](Get-OBSVirtualCamStatus.md)                                |[GetVirtualCamStatus](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getvirtualcamstatus)                                |
|[Open-OBSInputFiltersDialog](Open-OBSInputFiltersDialog.md)                          |[OpenInputFiltersDialog](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#openinputfiltersdialog)                          |
|[Open-OBSInputInteractDialog](Open-OBSInputInteractDialog.md)                        |[OpenInputInteractDialog](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#openinputinteractdialog)                        |
|[Open-OBSInputPropertiesDialog](Open-OBSInputPropertiesDialog.md)                    |[OpenInputPropertiesDialog](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#openinputpropertiesdialog)                    |
|[Open-OBSSourceProjector](Open-OBSSourceProjector.md)                                |[OpenSourceProjector](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#opensourceprojector)                                |
|[Open-OBSVideoMixProjector](Open-OBSVideoMixProjector.md)                            |[OpenVideoMixProjector](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#openvideomixprojector)                            |
|[Receive-OBS](Receive-OBS.md)                                                        |
|[Remove-OBSInput](Remove-OBSInput.md)                                                |[RemoveInput](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#removeinput)                                                |
|[Remove-OBSProfile](Remove-OBSProfile.md)                                            |[RemoveProfile](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#removeprofile)                                            |
|[Remove-OBSScene](Remove-OBSScene.md)                                                |[RemoveScene](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#removescene)                                                |
|[Remove-OBSSceneItem](Remove-OBSSceneItem.md)                                        |[RemoveSceneItem](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#removesceneitem)                                        |
|[Remove-OBSSourceFilter](Remove-OBSSourceFilter.md)                                  |[RemoveSourceFilter](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#removesourcefilter)                                  |
|[Resume-OBSRecord](Resume-OBSRecord.md)                                              |[ResumeRecord](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#resumerecord)                                              |
|[Save-OBSReplayBuffer](Save-OBSReplayBuffer.md)                                      |[SaveReplayBuffer](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#savereplaybuffer)                                      |
|[Save-OBSSourceScreenshot](Save-OBSSourceScreenshot.md)                              |[SaveSourceScreenshot](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#savesourcescreenshot)                              |
|[Send-OBS](Send-OBS.md)                                                              |
|[Send-OBSCallVendorRequest](Send-OBSCallVendorRequest.md)                            |[CallVendorRequest](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#callvendorrequest)                                    |
|[Send-OBSCustomEvent](Send-OBSCustomEvent.md)                                        |[BroadcastCustomEvent](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#broadcastcustomevent)                              |
|[Send-OBSOffsetMediaInputCursor](Send-OBSOffsetMediaInputCursor.md)                  |[OffsetMediaInputCursor](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#offsetmediainputcursor)                          |
|[Send-OBSPauseRecord](Send-OBSPauseRecord.md)                                        |[PauseRecord](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#pauserecord)                                                |
|[Send-OBSPressInputPropertiesButton](Send-OBSPressInputPropertiesButton.md)          |[PressInputPropertiesButton](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#pressinputpropertiesbutton)                  |
|[Send-OBSSleep](Send-OBSSleep.md)                                                    |[Sleep](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#sleep)                                                            |
|[Send-OBSStreamCaption](Send-OBSStreamCaption.md)                                    |[SendStreamCaption](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#sendstreamcaption)                                    |
|[Send-OBSTriggerHotkeyByKeySequence](Send-OBSTriggerHotkeyByKeySequence.md)          |[TriggerHotkeyByKeySequence](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#triggerhotkeybykeysequence)                  |
|[Send-OBSTriggerHotkeyByName](Send-OBSTriggerHotkeyByName.md)                        |[TriggerHotkeyByName](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#triggerhotkeybyname)                                |
|[Send-OBSTriggerMediaInputAction](Send-OBSTriggerMediaInputAction.md)                |[TriggerMediaInputAction](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#triggermediainputaction)                        |
|[Send-OBSTriggerStudioModeTransition](Send-OBSTriggerStudioModeTransition.md)        |[TriggerStudioModeTransition](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#triggerstudiomodetransition)                |
|[Set-OBSCurrentPreviewScene](Set-OBSCurrentPreviewScene.md)                          |[SetCurrentPreviewScene](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentpreviewscene)                          |
|[Set-OBSCurrentProfile](Set-OBSCurrentProfile.md)                                    |[SetCurrentProfile](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentprofile)                                    |
|[Set-OBSCurrentProgramScene](Set-OBSCurrentProgramScene.md)                          |[SetCurrentProgramScene](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentprogramscene)                          |
|[Set-OBSCurrentSceneCollection](Set-OBSCurrentSceneCollection.md)                    |[SetCurrentSceneCollection](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentscenecollection)                    |
|[Set-OBSCurrentSceneTransition](Set-OBSCurrentSceneTransition.md)                    |[SetCurrentSceneTransition](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentscenetransition)                    |
|[Set-OBSCurrentSceneTransitionDuration](Set-OBSCurrentSceneTransitionDuration.md)    |[SetCurrentSceneTransitionDuration](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentscenetransitionduration)    |
|[Set-OBSCurrentSceneTransitionSettings](Set-OBSCurrentSceneTransitionSettings.md)    |[SetCurrentSceneTransitionSettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentscenetransitionsettings)    |
|[Set-OBSInputAudioBalance](Set-OBSInputAudioBalance.md)                              |[SetInputAudioBalance](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputaudiobalance)                              |
|[Set-OBSInputAudioMonitorType](Set-OBSInputAudioMonitorType.md)                      |[SetInputAudioMonitorType](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputaudiomonitortype)                      |
|[Set-OBSInputAudioSyncOffset](Set-OBSInputAudioSyncOffset.md)                        |[SetInputAudioSyncOffset](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputaudiosyncoffset)                        |
|[Set-OBSInputAudioTracks](Set-OBSInputAudioTracks.md)                                |[SetInputAudioTracks](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputaudiotracks)                                |
|[Set-OBSInputMute](Set-OBSInputMute.md)                                              |[SetInputMute](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputmute)                                              |
|[Set-OBSInputName](Set-OBSInputName.md)                                              |[SetInputName](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputname)                                              |
|[Set-OBSInputSettings](Set-OBSInputSettings.md)                                      |[SetInputSettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputsettings)                                      |
|[Set-OBSInputVolume](Set-OBSInputVolume.md)                                          |[SetInputVolume](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputvolume)                                          |
|[Set-OBSMediaInputCursor](Set-OBSMediaInputCursor.md)                                |[SetMediaInputCursor](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setmediainputcursor)                                |
|[Set-OBSOutputSettings](Set-OBSOutputSettings.md)                                    |[SetOutputSettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setoutputsettings)                                    |
|[Set-OBSPersistentData](Set-OBSPersistentData.md)                                    |[SetPersistentData](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setpersistentdata)                                    |
|[Set-OBSProfileParameter](Set-OBSProfileParameter.md)                                |[SetProfileParameter](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setprofileparameter)                                |
|[Set-OBSSceneItemBlendMode](Set-OBSSceneItemBlendMode.md)                            |[SetSceneItemBlendMode](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsceneitemblendmode)                            |
|[Set-OBSSceneItemEnabled](Set-OBSSceneItemEnabled.md)                                |[SetSceneItemEnabled](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsceneitemenabled)                                |
|[Set-OBSSceneItemIndex](Set-OBSSceneItemIndex.md)                                    |[SetSceneItemIndex](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsceneitemindex)                                    |
|[Set-OBSSceneItemLocked](Set-OBSSceneItemLocked.md)                                  |[SetSceneItemLocked](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsceneitemlocked)                                  |
|[Set-OBSSceneItemTransform](Set-OBSSceneItemTransform.md)                            |[SetSceneItemTransform](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsceneitemtransform)                            |
|[Set-OBSSceneName](Set-OBSSceneName.md)                                              |[SetSceneName](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setscenename)                                              |
|[Set-OBSSceneSceneTransitionOverride](Set-OBSSceneSceneTransitionOverride.md)        |[SetSceneSceneTransitionOverride](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setscenescenetransitionoverride)        |
|[Set-OBSSourceFilterEnabled](Set-OBSSourceFilterEnabled.md)                          |[SetSourceFilterEnabled](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsourcefilterenabled)                          |
|[Set-OBSSourceFilterIndex](Set-OBSSourceFilterIndex.md)                              |[SetSourceFilterIndex](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsourcefilterindex)                              |
|[Set-OBSSourceFilterName](Set-OBSSourceFilterName.md)                                |[SetSourceFilterName](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsourcefiltername)                                |
|[Set-OBSSourceFilterSettings](Set-OBSSourceFilterSettings.md)                        |[SetSourceFilterSettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsourcefiltersettings)                        |
|[Set-OBSStreamServiceSettings](Set-OBSStreamServiceSettings.md)                      |[SetStreamServiceSettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setstreamservicesettings)                      |
|[Set-OBSStudioModeEnabled](Set-OBSStudioModeEnabled.md)                              |[SetStudioModeEnabled](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setstudiomodeenabled)                              |
|[Set-OBSTBarPosition](Set-OBSTBarPosition.md)                                        |[SetTBarPosition](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#settbarposition)                                        |
|[Set-OBSVideoSettings](Set-OBSVideoSettings.md)                                      |[SetVideoSettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setvideosettings)                                      |
|[Start-OBSOutput](Start-OBSOutput.md)                                                |[StartOutput](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#startoutput)                                                |
|[Start-OBSRecord](Start-OBSRecord.md)                                                |[StartRecord](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#startrecord)                                                |
|[Start-OBSReplayBuffer](Start-OBSReplayBuffer.md)                                    |[StartReplayBuffer](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#startreplaybuffer)                                    |
|[Start-OBSStream](Start-OBSStream.md)                                                |[StartStream](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#startstream)                                                |
|[Start-OBSVirtualCam](Start-OBSVirtualCam.md)                                        |[StartVirtualCam](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#startvirtualcam)                                        |
|[Stop-OBSOutput](Stop-OBSOutput.md)                                                  |[StopOutput](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#stopoutput)                                                  |
|[Stop-OBSRecord](Stop-OBSRecord.md)                                                  |[StopRecord](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#stoprecord)                                                  |
|[Stop-OBSReplayBuffer](Stop-OBSReplayBuffer.md)                                      |[StopReplayBuffer](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#stopreplaybuffer)                                      |
|[Stop-OBSStream](Stop-OBSStream.md)                                                  |[StopStream](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#stopstream)                                                  |
|[Stop-OBSVirtualCam](Stop-OBSVirtualCam.md)                                          |[StopVirtualCam](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#stopvirtualcam)                                          |
|[Switch-OBSInputMute](Switch-OBSInputMute.md)                                        |[ToggleInputMute](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#toggleinputmute)                                        |
|[Switch-OBSOutput](Switch-OBSOutput.md)                                              |[ToggleOutput](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#toggleoutput)                                              |
|[Switch-OBSRecord](Switch-OBSRecord.md)                                              |[ToggleRecord](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#togglerecord)                                              |
|[Switch-OBSRecordPause](Switch-OBSRecordPause.md)                                    |[ToggleRecordPause](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#togglerecordpause)                                    |
|[Switch-OBSReplayBuffer](Switch-OBSReplayBuffer.md)                                  |[ToggleReplayBuffer](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#togglereplaybuffer)                                  |
|[Switch-OBSStream](Switch-OBSStream.md)                                              |[ToggleStream](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#togglestream)                                              |
|[Switch-OBSVirtualCam](Switch-OBSVirtualCam.md)                                      |[ToggleVirtualCam](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#togglevirtualcam)                                      |
|[Watch-OBS](Watch-OBS.md)                                                            |






