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
|[Add-OBSInput](docs/Add-OBSInput.md)                                                      |[CreateInput](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createinput)                                                |
|[Add-OBSProfile](docs/Add-OBSProfile.md)                                                  |[CreateProfile](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createprofile)                                            |
|[Add-OBSScene](docs/Add-OBSScene.md)                                                      |[CreateScene](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createscene)                                                |
|[Add-OBSSceneCollection](docs/Add-OBSSceneCollection.md)                                  |[CreateSceneCollection](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createscenecollection)                            |
|[Add-OBSSceneItem](docs/Add-OBSSceneItem.md)                                              |[CreateSceneItem](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createsceneitem)                                        |
|[Add-OBSSourceFilter](docs/Add-OBSSourceFilter.md)                                        |[CreateSourceFilter](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#createsourcefilter)                                  |
|[Copy-OBSSceneItem](docs/Copy-OBSSceneItem.md)                                            |[DuplicateSceneItem](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#duplicatesceneitem)                                  |
|[Get-OBSCurrentPreviewScene](docs/Get-OBSCurrentPreviewScene.md)                          |[GetCurrentPreviewScene](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getcurrentpreviewscene)                          |
|[Get-OBSCurrentProgramScene](docs/Get-OBSCurrentProgramScene.md)                          |[GetCurrentProgramScene](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getcurrentprogramscene)                          |
|[Get-OBSCurrentSceneTransition](docs/Get-OBSCurrentSceneTransition.md)                    |[GetCurrentSceneTransition](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getcurrentscenetransition)                    |
|[Get-OBSCurrentSceneTransitionCursor](docs/Get-OBSCurrentSceneTransitionCursor.md)        |[GetCurrentSceneTransitionCursor](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getcurrentscenetransitioncursor)        |
|[Get-OBSGroup](docs/Get-OBSGroup.md)                                                      |[GetGroupList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getgrouplist)                                              |
|[Get-OBSGroupSceneItem](docs/Get-OBSGroupSceneItem.md)                                    |[GetGroupSceneItemList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getgroupsceneitemlist)                            |
|[Get-OBSHotkey](docs/Get-OBSHotkey.md)                                                    |[GetHotkeyList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#gethotkeylist)                                            |
|[Get-OBSInput](docs/Get-OBSInput.md)                                                      |[GetInputList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputlist)                                              |
|[Get-OBSInputAudioBalance](docs/Get-OBSInputAudioBalance.md)                              |[GetInputAudioBalance](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputaudiobalance)                              |
|[Get-OBSInputAudioMonitorType](docs/Get-OBSInputAudioMonitorType.md)                      |[GetInputAudioMonitorType](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputaudiomonitortype)                      |
|[Get-OBSInputAudioSyncOffset](docs/Get-OBSInputAudioSyncOffset.md)                        |[GetInputAudioSyncOffset](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputaudiosyncoffset)                        |
|[Get-OBSInputAudioTracks](docs/Get-OBSInputAudioTracks.md)                                |[GetInputAudioTracks](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputaudiotracks)                                |
|[Get-OBSInputDefaultSettings](docs/Get-OBSInputDefaultSettings.md)                        |[GetInputDefaultSettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputdefaultsettings)                        |
|[Get-OBSInputKind](docs/Get-OBSInputKind.md)                                              |[GetInputKindList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputkindlist)                                      |
|[Get-OBSInputMute](docs/Get-OBSInputMute.md)                                              |[GetInputMute](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputmute)                                              |
|[Get-OBSInputPropertiesListPropertyItems](docs/Get-OBSInputPropertiesListPropertyItems.md)|[GetInputPropertiesListPropertyItems](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputpropertieslistpropertyitems)|
|[Get-OBSInputSettings](docs/Get-OBSInputSettings.md)                                      |[GetInputSettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputsettings)                                      |
|[Get-OBSInputVolume](docs/Get-OBSInputVolume.md)                                          |[GetInputVolume](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getinputvolume)                                          |
|[Get-OBSLastReplayBufferReplay](docs/Get-OBSLastReplayBufferReplay.md)                    |[GetLastReplayBufferReplay](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getlastreplaybufferreplay)                    |
|[Get-OBSMediaInputStatus](docs/Get-OBSMediaInputStatus.md)                                |[GetMediaInputStatus](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getmediainputstatus)                                |
|[Get-OBSMonitor](docs/Get-OBSMonitor.md)                                                  |[GetMonitorList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getmonitorlist)                                          |
|[Get-OBSOutput](docs/Get-OBSOutput.md)                                                    |[GetOutputList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getoutputlist)                                            |
|[Get-OBSOutputSettings](docs/Get-OBSOutputSettings.md)                                    |[GetOutputSettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getoutputsettings)                                    |
|[Get-OBSOutputStatus](docs/Get-OBSOutputStatus.md)                                        |[GetOutputStatus](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getoutputstatus)                                        |
|[Get-OBSPersistentData](docs/Get-OBSPersistentData.md)                                    |[GetPersistentData](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getpersistentdata)                                    |
|[Get-OBSProfile](docs/Get-OBSProfile.md)                                                  |[GetProfileList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getprofilelist)                                          |
|[Get-OBSProfileParameter](docs/Get-OBSProfileParameter.md)                                |[GetProfileParameter](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getprofileparameter)                                |
|[Get-OBSRecordDirectory](docs/Get-OBSRecordDirectory.md)                                  |[GetRecordDirectory](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getrecorddirectory)                                  |
|[Get-OBSRecordStatus](docs/Get-OBSRecordStatus.md)                                        |[GetRecordStatus](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getrecordstatus)                                        |
|[Get-OBSReplayBufferStatus](docs/Get-OBSReplayBufferStatus.md)                            |[GetReplayBufferStatus](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getreplaybufferstatus)                            |
|[Get-OBSScene](docs/Get-OBSScene.md)                                                      |[GetSceneList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getscenelist)                                              |
|[Get-OBSSceneCollection](docs/Get-OBSSceneCollection.md)                                  |[GetSceneCollectionList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getscenecollectionlist)                          |
|[Get-OBSSceneItem](docs/Get-OBSSceneItem.md)                                              |[GetSceneItemList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemlist)                                      |
|[Get-OBSSceneItemBlendMode](docs/Get-OBSSceneItemBlendMode.md)                            |[GetSceneItemBlendMode](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemblendmode)                            |
|[Get-OBSSceneItemEnabled](docs/Get-OBSSceneItemEnabled.md)                                |[GetSceneItemEnabled](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemenabled)                                |
|[Get-OBSSceneItemId](docs/Get-OBSSceneItemId.md)                                          |[GetSceneItemId](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemid)                                          |
|[Get-OBSSceneItemIndex](docs/Get-OBSSceneItemIndex.md)                                    |[GetSceneItemIndex](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemindex)                                    |
|[Get-OBSSceneItemLocked](docs/Get-OBSSceneItemLocked.md)                                  |[GetSceneItemLocked](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemlocked)                                  |
|[Get-OBSSceneItemTransform](docs/Get-OBSSceneItemTransform.md)                            |[GetSceneItemTransform](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsceneitemtransform)                            |
|[Get-OBSSceneSceneTransitionOverride](docs/Get-OBSSceneSceneTransitionOverride.md)        |[GetSceneSceneTransitionOverride](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getscenescenetransitionoverride)        |
|[Get-OBSSceneTransition](docs/Get-OBSSceneTransition.md)                                  |[GetSceneTransitionList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getscenetransitionlist)                          |
|[Get-OBSSourceActive](docs/Get-OBSSourceActive.md)                                        |[GetSourceActive](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsourceactive)                                        |
|[Get-OBSSourceFilter](docs/Get-OBSSourceFilter.md)                                        |[GetSourceFilter](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsourcefilter)                                        |
|[Get-OBSSourceFilterDefaultSettings](docs/Get-OBSSourceFilterDefaultSettings.md)          |[GetSourceFilterDefaultSettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsourcefilterdefaultsettings)          |
|[Get-OBSSourceFilterList](docs/Get-OBSSourceFilterList.md)                                |[GetSourceFilterList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsourcefilterlist)                                |
|[Get-OBSSourceScreenshot](docs/Get-OBSSourceScreenshot.md)                                |[GetSourceScreenshot](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getsourcescreenshot)                                |
|[Get-OBSSpecialInputs](docs/Get-OBSSpecialInputs.md)                                      |[GetSpecialInputs](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getspecialinputs)                                      |
|[Get-OBSStats](docs/Get-OBSStats.md)                                                      |[GetStats](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getstats)                                                      |
|[Get-OBSStreamServiceSettings](docs/Get-OBSStreamServiceSettings.md)                      |[GetStreamServiceSettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getstreamservicesettings)                      |
|[Get-OBSStreamStatus](docs/Get-OBSStreamStatus.md)                                        |[GetStreamStatus](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getstreamstatus)                                        |
|[Get-OBSStudioModeEnabled](docs/Get-OBSStudioModeEnabled.md)                              |[GetStudioModeEnabled](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getstudiomodeenabled)                              |
|[Get-OBSTransitionKind](docs/Get-OBSTransitionKind.md)                                    |[GetTransitionKindList](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#gettransitionkindlist)                            |
|[Get-OBSVersion](docs/Get-OBSVersion.md)                                                  |[GetVersion](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getversion)                                                  |
|[Get-OBSVideoSettings](docs/Get-OBSVideoSettings.md)                                      |[GetVideoSettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getvideosettings)                                      |
|[Get-OBSVirtualCamStatus](docs/Get-OBSVirtualCamStatus.md)                                |[GetVirtualCamStatus](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#getvirtualcamstatus)                                |
|[Open-OBSInputFiltersDialog](docs/Open-OBSInputFiltersDialog.md)                          |[OpenInputFiltersDialog](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#openinputfiltersdialog)                          |
|[Open-OBSInputInteractDialog](docs/Open-OBSInputInteractDialog.md)                        |[OpenInputInteractDialog](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#openinputinteractdialog)                        |
|[Open-OBSInputPropertiesDialog](docs/Open-OBSInputPropertiesDialog.md)                    |[OpenInputPropertiesDialog](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#openinputpropertiesdialog)                    |
|[Open-OBSSourceProjector](docs/Open-OBSSourceProjector.md)                                |[OpenSourceProjector](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#opensourceprojector)                                |
|[Open-OBSVideoMixProjector](docs/Open-OBSVideoMixProjector.md)                            |[OpenVideoMixProjector](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#openvideomixprojector)                            |
|[Remove-OBSInput](docs/Remove-OBSInput.md)                                                |[RemoveInput](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#removeinput)                                                |
|[Remove-OBSProfile](docs/Remove-OBSProfile.md)                                            |[RemoveProfile](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#removeprofile)                                            |
|[Remove-OBSScene](docs/Remove-OBSScene.md)                                                |[RemoveScene](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#removescene)                                                |
|[Remove-OBSSceneItem](docs/Remove-OBSSceneItem.md)                                        |[RemoveSceneItem](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#removesceneitem)                                        |
|[Remove-OBSSourceFilter](docs/Remove-OBSSourceFilter.md)                                  |[RemoveSourceFilter](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#removesourcefilter)                                  |
|[Resume-OBSRecord](docs/Resume-OBSRecord.md)                                              |[ResumeRecord](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#resumerecord)                                              |
|[Save-OBSReplayBuffer](docs/Save-OBSReplayBuffer.md)                                      |[SaveReplayBuffer](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#savereplaybuffer)                                      |
|[Save-OBSSourceScreenshot](docs/Save-OBSSourceScreenshot.md)                              |[SaveSourceScreenshot](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#savesourcescreenshot)                              |
|[Send-OBSCallVendorRequest](docs/Send-OBSCallVendorRequest.md)                            |[CallVendorRequest](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#callvendorrequest)                                    |
|[Send-OBSCustomEvent](docs/Send-OBSCustomEvent.md)                                        |[BroadcastCustomEvent](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#broadcastcustomevent)                              |
|[Send-OBSOffsetMediaInputCursor](docs/Send-OBSOffsetMediaInputCursor.md)                  |[OffsetMediaInputCursor](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#offsetmediainputcursor)                          |
|[Send-OBSPauseRecord](docs/Send-OBSPauseRecord.md)                                        |[PauseRecord](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#pauserecord)                                                |
|[Send-OBSPressInputPropertiesButton](docs/Send-OBSPressInputPropertiesButton.md)          |[PressInputPropertiesButton](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#pressinputpropertiesbutton)                  |
|[Send-OBSSleep](docs/Send-OBSSleep.md)                                                    |[Sleep](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#sleep)                                                            |
|[Send-OBSStreamCaption](docs/Send-OBSStreamCaption.md)                                    |[SendStreamCaption](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#sendstreamcaption)                                    |
|[Send-OBSTriggerHotkeyByKeySequence](docs/Send-OBSTriggerHotkeyByKeySequence.md)          |[TriggerHotkeyByKeySequence](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#triggerhotkeybykeysequence)                  |
|[Send-OBSTriggerHotkeyByName](docs/Send-OBSTriggerHotkeyByName.md)                        |[TriggerHotkeyByName](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#triggerhotkeybyname)                                |
|[Send-OBSTriggerMediaInputAction](docs/Send-OBSTriggerMediaInputAction.md)                |[TriggerMediaInputAction](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#triggermediainputaction)                        |
|[Send-OBSTriggerStudioModeTransition](docs/Send-OBSTriggerStudioModeTransition.md)        |[TriggerStudioModeTransition](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#triggerstudiomodetransition)                |
|[Set-OBSCurrentPreviewScene](docs/Set-OBSCurrentPreviewScene.md)                          |[SetCurrentPreviewScene](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentpreviewscene)                          |
|[Set-OBSCurrentProfile](docs/Set-OBSCurrentProfile.md)                                    |[SetCurrentProfile](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentprofile)                                    |
|[Set-OBSCurrentProgramScene](docs/Set-OBSCurrentProgramScene.md)                          |[SetCurrentProgramScene](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentprogramscene)                          |
|[Set-OBSCurrentSceneCollection](docs/Set-OBSCurrentSceneCollection.md)                    |[SetCurrentSceneCollection](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentscenecollection)                    |
|[Set-OBSCurrentSceneTransition](docs/Set-OBSCurrentSceneTransition.md)                    |[SetCurrentSceneTransition](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentscenetransition)                    |
|[Set-OBSCurrentSceneTransitionDuration](docs/Set-OBSCurrentSceneTransitionDuration.md)    |[SetCurrentSceneTransitionDuration](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentscenetransitionduration)    |
|[Set-OBSCurrentSceneTransitionSettings](docs/Set-OBSCurrentSceneTransitionSettings.md)    |[SetCurrentSceneTransitionSettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setcurrentscenetransitionsettings)    |
|[Set-OBSInputAudioBalance](docs/Set-OBSInputAudioBalance.md)                              |[SetInputAudioBalance](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputaudiobalance)                              |
|[Set-OBSInputAudioMonitorType](docs/Set-OBSInputAudioMonitorType.md)                      |[SetInputAudioMonitorType](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputaudiomonitortype)                      |
|[Set-OBSInputAudioSyncOffset](docs/Set-OBSInputAudioSyncOffset.md)                        |[SetInputAudioSyncOffset](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputaudiosyncoffset)                        |
|[Set-OBSInputAudioTracks](docs/Set-OBSInputAudioTracks.md)                                |[SetInputAudioTracks](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputaudiotracks)                                |
|[Set-OBSInputMute](docs/Set-OBSInputMute.md)                                              |[SetInputMute](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputmute)                                              |
|[Set-OBSInputName](docs/Set-OBSInputName.md)                                              |[SetInputName](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputname)                                              |
|[Set-OBSInputSettings](docs/Set-OBSInputSettings.md)                                      |[SetInputSettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputsettings)                                      |
|[Set-OBSInputVolume](docs/Set-OBSInputVolume.md)                                          |[SetInputVolume](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setinputvolume)                                          |
|[Set-OBSMediaInputCursor](docs/Set-OBSMediaInputCursor.md)                                |[SetMediaInputCursor](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setmediainputcursor)                                |
|[Set-OBSOutputSettings](docs/Set-OBSOutputSettings.md)                                    |[SetOutputSettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setoutputsettings)                                    |
|[Set-OBSPersistentData](docs/Set-OBSPersistentData.md)                                    |[SetPersistentData](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setpersistentdata)                                    |
|[Set-OBSProfileParameter](docs/Set-OBSProfileParameter.md)                                |[SetProfileParameter](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setprofileparameter)                                |
|[Set-OBSSceneItemBlendMode](docs/Set-OBSSceneItemBlendMode.md)                            |[SetSceneItemBlendMode](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsceneitemblendmode)                            |
|[Set-OBSSceneItemEnabled](docs/Set-OBSSceneItemEnabled.md)                                |[SetSceneItemEnabled](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsceneitemenabled)                                |
|[Set-OBSSceneItemIndex](docs/Set-OBSSceneItemIndex.md)                                    |[SetSceneItemIndex](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsceneitemindex)                                    |
|[Set-OBSSceneItemLocked](docs/Set-OBSSceneItemLocked.md)                                  |[SetSceneItemLocked](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsceneitemlocked)                                  |
|[Set-OBSSceneItemTransform](docs/Set-OBSSceneItemTransform.md)                            |[SetSceneItemTransform](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsceneitemtransform)                            |
|[Set-OBSSceneName](docs/Set-OBSSceneName.md)                                              |[SetSceneName](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setscenename)                                              |
|[Set-OBSSceneSceneTransitionOverride](docs/Set-OBSSceneSceneTransitionOverride.md)        |[SetSceneSceneTransitionOverride](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setscenescenetransitionoverride)        |
|[Set-OBSSourceFilterEnabled](docs/Set-OBSSourceFilterEnabled.md)                          |[SetSourceFilterEnabled](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsourcefilterenabled)                          |
|[Set-OBSSourceFilterIndex](docs/Set-OBSSourceFilterIndex.md)                              |[SetSourceFilterIndex](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsourcefilterindex)                              |
|[Set-OBSSourceFilterName](docs/Set-OBSSourceFilterName.md)                                |[SetSourceFilterName](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsourcefiltername)                                |
|[Set-OBSSourceFilterSettings](docs/Set-OBSSourceFilterSettings.md)                        |[SetSourceFilterSettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setsourcefiltersettings)                        |
|[Set-OBSStreamServiceSettings](docs/Set-OBSStreamServiceSettings.md)                      |[SetStreamServiceSettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setstreamservicesettings)                      |
|[Set-OBSStudioModeEnabled](docs/Set-OBSStudioModeEnabled.md)                              |[SetStudioModeEnabled](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setstudiomodeenabled)                              |
|[Set-OBSTBarPosition](docs/Set-OBSTBarPosition.md)                                        |[SetTBarPosition](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#settbarposition)                                        |
|[Set-OBSVideoSettings](docs/Set-OBSVideoSettings.md)                                      |[SetVideoSettings](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#setvideosettings)                                      |
|[Start-OBSOutput](docs/Start-OBSOutput.md)                                                |[StartOutput](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#startoutput)                                                |
|[Start-OBSRecord](docs/Start-OBSRecord.md)                                                |[StartRecord](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#startrecord)                                                |
|[Start-OBSReplayBuffer](docs/Start-OBSReplayBuffer.md)                                    |[StartReplayBuffer](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#startreplaybuffer)                                    |
|[Start-OBSStream](docs/Start-OBSStream.md)                                                |[StartStream](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#startstream)                                                |
|[Start-OBSVirtualCam](docs/Start-OBSVirtualCam.md)                                        |[StartVirtualCam](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#startvirtualcam)                                        |
|[Stop-OBSOutput](docs/Stop-OBSOutput.md)                                                  |[StopOutput](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#stopoutput)                                                  |
|[Stop-OBSRecord](docs/Stop-OBSRecord.md)                                                  |[StopRecord](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#stoprecord)                                                  |
|[Stop-OBSReplayBuffer](docs/Stop-OBSReplayBuffer.md)                                      |[StopReplayBuffer](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#stopreplaybuffer)                                      |
|[Stop-OBSStream](docs/Stop-OBSStream.md)                                                  |[StopStream](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#stopstream)                                                  |
|[Stop-OBSVirtualCam](docs/Stop-OBSVirtualCam.md)                                          |[StopVirtualCam](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#stopvirtualcam)                                          |
|[Switch-OBSInputMute](docs/Switch-OBSInputMute.md)                                        |[ToggleInputMute](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#toggleinputmute)                                        |
|[Switch-OBSOutput](docs/Switch-OBSOutput.md)                                              |[ToggleOutput](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#toggleoutput)                                              |
|[Switch-OBSRecord](docs/Switch-OBSRecord.md)                                              |[ToggleRecord](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#togglerecord)                                              |
|[Switch-OBSRecordPause](docs/Switch-OBSRecordPause.md)                                    |[ToggleRecordPause](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#togglerecordpause)                                    |
|[Switch-OBSReplayBuffer](docs/Switch-OBSReplayBuffer.md)                                  |[ToggleReplayBuffer](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#togglereplaybuffer)                                  |
|[Switch-OBSStream](docs/Switch-OBSStream.md)                                              |[ToggleStream](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#togglestream)                                              |
|[Switch-OBSVirtualCam](docs/Switch-OBSVirtualCam.md)                                      |[ToggleVirtualCam](https://github.com/obsproject/obs-websocket/blob/master/docs/generated/protocol.md#togglevirtualcam)                                      |





