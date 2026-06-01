Stop-OBS
--------

### Synopsis
Stops OBS

---

### Description

Stops OBS.

By default, stops recording and streaming.

If -Process is provided, will stop all running OBS processes

If -Recording is provided, will stop recording
If -Streaming if provided, will stop obs streaming
If -VirtualCamera is provided, will stop the virtual camera

---

### Related Links
* [Stop-OBSRecord](Stop-OBSRecord.md)

* [Stop-OBSStream](Stop-OBSStream.md)

* [Stop-OBSVirtualCam](Stop-OBSVirtualCam.md)

* [Set-OBSStudioModeEnabled](Set-OBSStudioModeEnabled.md)

---

### Examples
Stop Streaming and Recording

```PowerShell
Stop-OBS
```
Stops obs recording

```PowerShell
Stop-OBS -Recording
```
Stop Streaming        

```PowerShell
Stop-OBS -Streaming
```
Stop OBS Virtual Camera

```PowerShell
Stop-OBS -VirtualCamera
```
Stop OBS Virtual Camera without prompting

```PowerShell
Stop-OBS -VirtualCamera -Confirm:$false
```
> EXAMPLE 6

```PowerShell
Stop-OBS -StudioMode
```

---

### Parameters
#### **Recording**
If set, will stop recording.

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |

#### **Streaming**
If set, will stop streaming

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |

#### **VirtualCamera**
If set, will stop the virtual camera.

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |

#### **Process**
If set, will stop the OBS process.

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |

#### **StudioMode**
If set, will enable studio mode.

|Type      |Required|Position|PipelineInput|
|----------|--------|--------|-------------|
|`[Switch]`|false   |named   |false        |

#### **WhatIf**
-WhatIf is an automatic variable that is created when a command has ```[CmdletBinding(SupportsShouldProcess)]```.
-WhatIf is used to see what would happen, or return operations without executing them
#### **Confirm**
-Confirm is an automatic variable that is created when a command has ```[CmdletBinding(SupportsShouldProcess)]```.
-Confirm is used to -Confirm each operation.

If you pass ```-Confirm:$false``` you will not be prompted.

If the command sets a ```[ConfirmImpact("Medium")]``` which is lower than ```$confirmImpactPreference```, you will not be prompted unless -Confirm is passed.

---

### Notes
This command Supports Should Process and has a ConfirmImpact of 'High'

In an interactive session, this command prompt by default.

If `-WhatIf` is passed, will output what happen if this ran
If `-Confirm:$false`, confirmation will be skipped.

---

### Syntax
```PowerShell
Stop-OBS [-Recording] [-Streaming] [-VirtualCamera] [-Process] [-StudioMode] [-WhatIf] [-Confirm] [<CommonParameters>]
```
